function calcAmount() {
    let penz = 500;
    let kolbasz = document.querySelector("input[name='amount-input']") ;
    let kolbaszosKenyer = kolbasz.value * penz;
        // console.log(no, "kezdem erteni")
    let kenyer = document.querySelector("span.show-amount") ;

    kenyer.innerHTML = kolbaszosKenyer;

   
}

