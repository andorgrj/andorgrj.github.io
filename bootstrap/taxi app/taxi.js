function calcAmount() {
    let price = 1000;
    let amountInput = document.querySelector("input[name='amount input']") ;
    let amountNumber = parseInt(amountInput.value);
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
        alert(`az árucikk megrendelése postaköltséggel együtt: ${amount}`) ;
    }
}


/* function sumPrice(price, amountNumber) {
    let startFee = 0;
    let showAmount = document.querySelector("span.show-amount") ;
    let amount = amountNumber * price + startFee;
    showAmount.innerHTML = amount;
} */


/* 
/* let gumiKopás = 100;

function gumiKopásFüggvény(amountNumber) {
    let showTyre = document.querySelector("span.show-tyre") ;
    gumiKopás = gumiKopás - amountNumber;

        showTyre.innerHTML = gumiKopás;  */

// } */

/* let üzemanyagFogyás = 100;

function üzemanyagFogyás(amountNumber) {
    let showGas = document.querySelector("span.show-gas") ;
    üzemanyagFogyás = üzemanyagFogyás + amountNumber;

        showGas.innerHTML = üzemanyagFogyás */
// }


/* function imiCica() {
    return 67 - 2
}

console.log(`eredmény: ${imiCica()}`) ; */