function calcAmount() {
    let ár = 1000;
    let beirtDbSzam = document.querySelector("input[name='amount-input']");
    let összegMutatas = document.querySelector("span.show-amount");
    let darabSzam = beirtDbSzam.value;
    



    if (darabSzam > 10) {
        alert("Maximum 10 db");
        return;
    } else if (darabSzam < 1) {
        alert ("Min 1 db");
    } 
    
    let végÖsszeg = beirtDbSzam.value * ár;
    összegMutatas.innerHTML = végÖsszeg;
} 