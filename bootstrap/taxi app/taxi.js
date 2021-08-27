function calcAmount() {
    let price = 500;
    let amountInput = document.querySelector("input[name='amount input']") ;
    let amountNumber = parseInt(amountInput.value)
    amountNumber = isNaN(amountNumber) ? 0 : amountNumber;
    
    sumPrice(price, amountNumber) ;     
    gumiKopásFüggvény(amountNumber) ;
    üzemanyagFogyás(amountNumber) ;
}


function sumPrice(price, amountNumber) {
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


/* function sumPrice(price, amountNumber) {
    let startFee = 0;
    let showAmount = document.querySelector("span.show-amount") ;
    let amount = amountNumber * price + startFee;
    showAmount.innerHTML = amount;
} */



let gumiKopás = 100;

function gumiKopásFüggvény(amountNumber) {
    let showTyre = document.querySelector("span.show-tyre") ;
    gumiKopás = gumiKopás - amountNumber;

        showTyre.innerHTML = gumiKopás; 

}

let üzemanyagFogyás = 100;

function üzemanyagFogyás(amountNumber) {
    let showGas = document.querySelector("span.show-gas") ;
    üzemanyagFogyás = üzemanyagFogyás + amountNumber;

        showGas.innerHTML = üzemanyagFogyás
}