
function inputValueChange(name, value) {
    document.getElementById(name).value = value;
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function result_cal() {
    let outputBox_first_label_array = ['대출금', '대출금리', '대출기간', '거치기간', '상환방법', '총 이자'];
    // 대출금
    let loan_value = document.getElementById('loanInputBox_data_input').value;
    // 대출금리
    let loanRate = document.getElementById('loanRateInputBox_data_input').value;
    // 대출기간
    let loanPeriod = document.getElementById('loanPeriodInputBox_data_input').value;
    // 거치기간
    let unredeemedTerm = document.getElementById('unredeemedTermInputBox_data_input').value;

    let outputBox_first_value_array
        = [numberWithCommas(loan_value) + '원'
            , '연 ' + loanRate + ' %'
            , loanPeriod + ' 개월 (' + loanPeriod/12 + ' 년)'
            , unredeemedTerm == 0 ? '없음' : unredeemedTerm + " 개월"
            , '원리금균등반환'
            , numberWithCommas(Math.floor(loan_value * loanRate/100 * loanPeriod/12)) + ' 원'];
    
    document.write("<!DOCTYPE html>"
                 + "<html>"
                 + "<meta charset=\"UTF-8\">"
                 + "<body>"
                 + "<link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css\" integrity=\"sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z\" crossorigin=\"anonymous\"></link>"
                 + "<link href=\"test.css\" type=\"text/css\" rel=\"stylesheet\" />"
                 + "<link href=\"https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap\" rel=\"stylesheet\"></link>"
                 + "<div class=\"row\">"
                 + "    <div class=\"boxMargin-left\"></div>"
                 + "    <div id=\"outputBox\" class=\"div-block-col-head\"><br>");
    
    for(i = 0; i < outputBox_first_label_array.length; i++) {
        document.write("        <div class=\"row cell-margin text-center\">"
                     + "            <div id=\"col-head\" class=\"col_height border border-secondary\">" + outputBox_first_label_array[i] + "</div>"
                     + "            <div id=\"col-body\" class=\"col_height border border-secondary\">" + outputBox_first_value_array[i] + "</div>"
                     + "        </div>");
    }
    document.write("        <br>"
                 + "        <div class=\"cell-margin text-right\">"
                 + "            <input type=\"button\" class=\"btn btn-danger\" value=\"다시 계산하기\" onclick=\"location.href='index.html'\">"
                 + "        </div>"
                 + "        <br>"
                 + "        <div class=\"row cell-margin\">"
                 + "            <div id=\"col-num\" class=\"head_color col_height col_text_center border border-secondary\">No</div>"
                 + "            <div id=\"col-size1\" class=\"head_color col_height col_text_center border border-secondary\">상환금</div>"
                 + "            <div id=\"col-size1\" class=\"head_color col_height col_text_center border border-secondary\">납입원금</div>"
                 + "            <div id=\"col-size1\" class=\"head_color col_height col_text_center border border-secondary\">이자</div>"
                 + "            <div id=\"col-size2\" class=\"head_color col_height col_text_center border border-secondary\">납입원금계</div>"
                 + "            <div id=\"col-size2\" class=\"head_color col_height col_text_center border border-secondary\">잔금</div>"
                 + "        </div>");
                 
    finance_cal(loan_value, loanRate, loanPeriod, unredeemedTerm);

    document.write("        <br>"
                 + "        <div class=\"cell-margin text-right\">"
                 + "            <input type=\"button\" class=\"btn btn-danger\" value=\"다시 계산하기\" onclick=\"location.href='index.html'\">"
                 + "        </div>"
                 + "    <div class=\"boxMargin-right\"></div>"
                 + "</div>"
                 + "</body>"
                 + "</html>");
}

function finance_cal(loan, loanRate, loanPeriod, unredeemedTerm) {

    // loan = 100,000,000
    // loanRate = 10%
    // loanPeriod = 
    let principal_payment_array = [];
    let interest_array = [];
    let balance_array = [];
    let accumulative_principal_payment_array = [];
    
    // 첫 번째 달의 이자
    let repayment_unredeemedTerm_zero = Math.floor( (loan * (loanRate/100/12) * Math.pow((1 + loanRate/100/12), loanPeriod)) / (Math.pow((1 + loanRate/100/12), loanPeriod) - 1));
    let interest = Math.floor(loan * loanRate/100/12);

    // unredeemedTerm == 0 ? : 거치기간 (unredeemedTerm) 이 0 인가
    let repayment = parseInt(unredeemedTerm) == 0 ? repayment_unredeemedTerm_zero : interest;
    let principal_payment = repayment - interest;
    let balance = loan - principal_payment;
    let accumulative_principal_payment = principal_payment;
    let accumulative_interest = interest;
    console.log("loanPeriod * repayment = " + numberWithCommas(loanPeriod*repayment));
    
    for(i = 0; i < (parseInt(unredeemedTerm) + parseInt(loanPeriod)); i++) {
        
        interest_array.push(interest);
        principal_payment_array.push(principal_payment);
        balance_array.push(balance);
        accumulative_principal_payment_array.push(accumulative_principal_payment);
        repayment = i >= parseInt(unredeemedTerm) - 1 ? repayment_unredeemedTerm_zero : interest;

        // console.log("-------------------- No " + (i + 1) + ". --------------------");
        // console.log("repayment : " + numberWithCommas(repayment));
        // console.log("interest : " + numberWithCommas(interest_array[i]));
        // console.log("principal payment : " + numberWithCommas(principal_payment_array[i]));
        // console.log("interest + principal payment : " + numberWithCommas(interest_array[i] + principal_payment_array[i]));
        // console.log("balance : " + numberWithCommas(balance_array[i]));
        // console.log("accumulative principal payment : " + numberWithCommas(accumulative_principal_payment_array[i]));
        console.log("interest: " + interest);
        console.log("accumulative interest: " + accumulative_interest);
        document.write("        <div class=\"row cell-margin\">"
                        + "            <div id=\"col-num\" class=\"num_color col_height col_text_center border border-secondary\">" + (i + 1) + "</div>"
                        + "            <div id=\"col-size1\" class=\"col_height col_text_center border border-secondary\">" + numberWithCommas(repayment) + "</div>"
                        + "            <div id=\"col-size1\" class=\"col_height col_text_center border border-secondary\">" + numberWithCommas(principal_payment_array[i]) +"</div>"
                        + "            <div id=\"col-size1\" class=\"col_height col_text_center border border-secondary\">" + numberWithCommas(interest_array[i]) + "</div>"
                        + "            <div id=\"col-size2\" class=\"col_height col_text_center border border-secondary\">" + numberWithCommas(accumulative_principal_payment_array[i]) + "</div>"
                        + "            <div id=\"col-size2\" class=\"col_height col_text_center border border-secondary\">" + numberWithCommas(balance_array[i]) + "</div>"
                        + "        </div>");
        
        // i > unredeemedTerm : 거치기간 이 후인 경우
        interest = i >= parseInt(unredeemedTerm) - 1 ? Math.floor(balance_array[i] * loanRate/100 / 12) : interest;
        principal_payment = repayment - interest;
        balance = balance_array[i] - principal_payment;
        accumulative_principal_payment += principal_payment;
        accumulative_interest += interest;
    }
    console.log("총 이자: " + accumulative_interest);
}