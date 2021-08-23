function calcAmount() {
    let price = 1000;
    let amountInput = document.querySelector("input[name='amount input']") ;
    let amountNumber = parseInt(amountInput.value)
    amountNumber = isNaN(amountNumber) ? 0 : amountNumber;
    showSumPrice(price, amountNumber) ;   
}

function showSumPrice(price, amountNumber) {
    let shippingFee = 0;
    let showAmount = document.querySelector("span.show-amount") ;

    if ( amountNumber < 5 ){
        shippingFee = 500; 
    }

    if ( amountNumber > 10 ) {
        alert("Maximum 10 kaja lehet!") ;
        return;
    } else if ( amountNumber < 1 ) {
        alert("Minimum 1 kaját kell venni!") ;
    } else {
        let amount = amountNumber * price + shippingFee;
        showAmount.innerHTML = amount;
    }
}
