function calcAmount() {
    let price = 500;
    let amountInput = document.querySelector("input[name='amount input']") ;
    let amountNumber = parseInt(amountInput.value)
    amountNumber = isNaN(amountNumber) ? 0 : amountNumber;
    
    showSumPrice(price, amountNumber) ;   
}

function showSumPrice(price, amountNumber) {
    let startFee = 0;
    let showAmount = document.querySelector("span.show-amount") ;

    if ( amountNumber > 1 ){
        startFee = 500; 
    }

    if ( amountNumber > 50 ) {
        alert("Messzire mész!") ;
        return;
    } else if ( amountNumber < 5 ) {
        alert("Minimum menj 5 km-t!") ;
    } else {
        let amount = amountNumber * price + startFee;
        showAmount.innerHTML = amount;
    }    
}
