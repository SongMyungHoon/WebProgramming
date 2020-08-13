
function inputValueChange(name, value) {
    document.getElementById(name).value = value;
}

function loanAddOnClick(value) {
    let loanVal = document.getElementById('loanInputBox_data_input').value;
    
    let beforeValue = loanVal == '' ? 0 : parseInt(loanVal);
    document.getElementById('loanInputBox_data_input').value = beforeValue + parseInt(value);
    document.getElementById('loanInputBox_data_print').innerHTML = numberWithCommas(beforeValue + parseInt(value)) + ' 원';
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function validation() {
    // 대출금
    let loanVal = parseInt(document.getElementById('loanInputBox_data_input').value);
    // 대출금리
    let loanRate = parseInt(document.getElementById('loanRateInputBox_data_input').value);
    // 대출기간
    let loanPeriod = parseInt(document.getElementById('loanPeriodInputBox_data_input').value);
    // 거치기간
    let unredeemedTerm = parseInt(document.getElementById('unredeemedTermInputBox_data_input').value);
    console.log(unredeemedTerm);
    if (loanVal <= 0 || loanVal == NaN) {
        alert("대출금을 바르게 입력하세요");
        document.getElementById('loanInputBox_data_input').focus();
        return true;
    } else if (loanRate <= 0 || loanRate == NaN) {
        alert("대출금리를 바르게 입력하세요");
        document.getElementById('loanRateInputBox_data_input').focus();
        return true;
    } else if (loanPeriod <= 0 || loanPeriod == NaN) {
        alert("대출기간을 바르게 입력하세요");
        document.getElementById('loanPeriodInputBox_data_input').focus();
        return true;
    } else if (unredeemedTerm < 0 || unredeemedTerm == NaN) {
        alert("거치기간을 바르게 입력하세요");
        document.getElementById('unredeemedTermInputBox_data_input').focus();
        return true;
    }
    return false;
}

function resultCal() {
    
    // 대출금
    let loanVal = parseInt(document.getElementById('loanInputBox_data_input').value);
    // 대출금리
    let loanRate = parseInt(document.getElementById('loanRateInputBox_data_input').value);
    // 대출기간
    let loanPeriod = parseInt(document.getElementById('loanPeriodInputBox_data_input').value);
    // 거치기간
    let unredeemedTerm = parseInt(document.getElementById('unredeemedTermInputBox_data_input').value);

    if (validation()) {
        return;
    } else {
        let inputBoxElement = document.getElementById("inputBox");
        let outputBoxElement = document.getElementById("outputBox");

        document.getElementById("output_first_tbl_loan").innerHTML = numberWithCommas(loanVal) + ' 원';
        document.getElementById("output_first_tbl_rate").innerHTML = '연 ' + loanRate + '%';
        console.log("loanPeriod: " + loanPeriod);
        document.getElementById("output_first_tbl_period").innerHTML = loanPeriod + ' 개월 (' 
                                                                    + ((loanPeriod % 12 == 0) ? (loanPeriod/12) : (loanPeriod/12).toFixed(2))
                                                                    + ' 년)';
        document.getElementById("output_first_tbl_unredeemedTerm").innerHTML = (unredeemedTerm == 0) ? '없음': unredeemedTerm + ' 개월';
        
        if(outputBoxElement.style.visibility == 'hidden' 
        || outputBoxElement.style.visibility == '') {
        
            inputBoxElement.style.display = 'none';
            outputBoxElement.style.visibility = 'visible';
            
            console.log("result_cal");
            console.log("inputBoxElement display: " + inputBoxElement.style.display);
            console.log("outputBoxElement visibility: " + outputBoxElement.style.visibility);

            if(document.getElementById("monthly_result_cal").innerHTML == '') {
                finance_cal(loanVal, loanRate, loanPeriod, unredeemedTerm);
            }
        }
    }
}

function reWrite() {
    if (confirm("입력된 내용을 삭제합니다.") == true) {
        // 대출금
        document.getElementById('loanInputBox_data_input').value = 0;
        // 대출금리
        document.getElementById('loanRateInputBox_data_input').value = 0;
        // 대출기간
        document.getElementById('loanPeriodInputBox_data_input').value = 0;
        // 거치기간
        document.getElementById('unredeemedTermInputBox_data_input').value = 0;

        document.getElementById('loanInputBox_data_print').innerHTML = '0 원';

        document.getElementById('loanInputBox_data_input').focus();
        
    } else {
        return;
    }
}

function retry() {
    let inputBoxElement = document.getElementById("inputBox");
    let outputBoxElement = document.getElementById("outputBox");
    
    inputBoxElement.style.display = '';
    outputBoxElement.style.visibility = 'hidden';

    console.log("retry");
    console.log("inputBoxElement display: " + inputBoxElement.style.display);
    console.log("outputBoxElement visibility: " + outputBoxElement.style.visibility);

    document.getElementById("monthly_result_cal").innerHTML = '';
}

function finance_cal(loan, loanRate, loanPeriod, unredeemedTerm) {
    /* loan: 대출금
     * loanRate: 대출이자(%)
     * loanPeriod: 상환기간 (개월)
     * unredeemedTerm: 거치기간 (개월) */

    let principalPaymentArray = [];
    let interestArray = [];
    let balanceArray = [];
    let accumulativePrincipalPaymentArray = [];
    
    /* 첫 번째 달의 이자
     * 소수점 이하 버림 */
    let repaymentUnredeemedTermZero = Math.floor( (loan * (loanRate/100/12) * Math.pow((1 + loanRate/100/12), loanPeriod)) / (Math.pow((1 + loanRate/100/12), loanPeriod) - 1));
    let interest = Math.floor(loan * loanRate/100/12);

    // unredeemedTerm == 0 ? : 거치기간 (unredeemedTerm) 이 0 인가
    let repayment = parseInt(unredeemedTerm) == 0 ? repaymentUnredeemedTermZero : interest;

    /* 거치기간에는 repayment == interest,
     * principal_payment == 0 */
    let principalPayment = repayment - interest;
    let balance = loan - principalPayment;
    let accumulativePrincipalPayment = principalPayment;
    let accumulativeInterest = interest;
        
    for(i = 0; i < (parseInt(unredeemedTerm) + parseInt(loanPeriod)); i++) {
        
        interestArray.push(interest);
        principalPaymentArray.push(principalPayment);
        balanceArray.push(balance);
        accumulativePrincipalPaymentArray.push(accumulativePrincipalPayment);

        // 마지막 달 대출 잔액 처리
        if (i == (parseInt(unredeemedTerm) + parseInt(loanPeriod)) - 1) {
            repayment += balance;
            principalPaymentArray[i] += balance;
            accumulativePrincipalPaymentArray[i] += balance;
            balanceArray[i] = 0;
        }
        document.getElementById("monthly_result_cal").innerHTML +=
                         ("        <div class=\"row cell-margin\">"
                        + "            <div class=\"col_num num_color col_height col_text_center border border-secondary\">" + (i + 1) + "</div>"
                        + "            <div class=\"col_size1 col_height col_text_center border border-secondary\">" + numberWithCommas(repayment) + "</div>"
                        + "            <div class=\"col_size1 col_height col_text_center border border-secondary\">" + numberWithCommas(principalPaymentArray[i]) +"</div>"
                        + "            <div class=\"col_size1 col_height col_text_center border border-secondary\">" + numberWithCommas(interestArray[i]) + "</div>"
                        + "            <div class=\"col_size2 col_height col_text_center border border-secondary\">" + numberWithCommas(accumulativePrincipalPaymentArray[i]) + "</div>"
                        + "            <div class=\"col_size2 col_height col_text_center border border-secondary\">" + numberWithCommas(balanceArray[i]) + "</div>"
                        + "        </div>");
        
        /* i > unredeemedTerm : 거치기간이 아닌 경우
         * repayment 계산 */
        repayment = (i >= parseInt(unredeemedTerm) - 1) ? repaymentUnredeemedTermZero : interest;

        // i > unredeemedTerm : 거치기간이 아닌 경우
        interest = (i >= parseInt(unredeemedTerm) - 1) ? Math.floor(balanceArray[i] * loanRate/100 / 12) : interest;
        
        principalPayment = repayment - interest;
        balance = balanceArray[i] - principalPayment;
        accumulativePrincipalPayment += principalPayment;
        accumulativeInterest += interest;

    }
    
    // 계산된 총 이자 값을 ouput first table 의 총 이자 부분에 출력
    document.getElementById("output_first_tbl_total_interest").innerHTML = numberWithCommas(accumulativeInterest) + " 원";
}