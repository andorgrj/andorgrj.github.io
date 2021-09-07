function calcAmount() {
    let penz = 500;

    let mennyiség = document.querySelector("input[name='amount-input']") ;
    let végösszeg = mennyiség.value * penz;

    let összeg = document.querySelector("span.show-amount") ;
    összeg.innerHTML = végösszeg;

   
}



