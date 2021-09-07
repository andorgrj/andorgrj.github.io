function calcAmount () {
    let price = 500;
    let amountInput = document.querySelector("input#amountInput.form-control")
    let amountNumber = amountInput.value;
    
    


finalPrice(price, amountNumber);

}

function finalPrice (price, amountNumber) {
    let shippingFee = 0;
    let showAmount = document.querySelector("span.show-amount")
    
    if (amountNumber < 3 ) {
        shippingFee = 1;
    }

    if (amountNumber < 1 ) {
        alert("Minimum 1 db kiválasztása szükséges")
        return;
    } else if (amountNumber > 5)
        alert("Max 10 lehet")
    else {
        
        let amount = amountNumber * price + shippingFee;
        showAmount.innerHTML = amount;
    }
}

let kiegészítőApróbetűsSzövegHozzáadás = document.createElement("small");
kiegészítőApróbetűsSzövegHozzáadás.className = "form-text text muted";
kiegészítőApróbetűsSzövegHozzáadás.innerHTML = "Válaszd ki a darabszámot";

let parent = document.querySelector("div#car.form.group");
parent.appendChild(kiegészítőApróbetűsSzövegHozzáadás);


let mennyiségInfo = document.createElement("small");
mennyiségInfo.className = "form-text text muted";
mennyiségInfo.innerHTML = "Mennyiség megadása itt";

let parent2 = document.querySelector("div#számok.form-group");
parent2.appendChild(mennyiségInfo);




let többMódosítás = document.querySelectorAll("input");
    for (let i = 0; i < többMódosítás.length; i++) {
        többMódosítás[i].style.backgroundColor = "pink";
    }
