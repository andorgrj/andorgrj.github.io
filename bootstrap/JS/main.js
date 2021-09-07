function calcAmount() {
    let price = 1000;
    let amountInput = document.querySelector("input[name='amount input']") ;
    let amountNumber = parseInt(amountInput.value);
    amountNumber = isNaN(amountNumber) ? 0 : amountNumber;
    
    showSumPrice(price, amountNumber) ;   
}

function showSumPrice(price, amountNumber) {
    let shippingFee = 0;
    let toppings = 200;
    let showAmount = document.querySelector("span.show-amount") ;

    if ( amountNumber < 5 ){
        shippingFee = 500; 
    }

    if ( amountNumber < 1){
        toppings = 200;

    }

    if ( amountNumber > 10 ) {
        alert("Maximum 10 kaja lehet!") ;
        return;
    } else if ( amountNumber < 1 ) {
        alert("Minimum 1 kaját kell venni!") ;
    } else {
        let amount = amountNumber * price + shippingFee + toppings;
        showAmount.innerHTML = amount;
        alert(`az árucikk megrendelése postaköltséggel együtt: ${amount}`);
    }
}




// Elem hozzáadása szülő elemhez gyerekként js-en keresztül
let elemHozzáadás = document.createElement("small");
elemHozzáadás.className = "form-text text muted";
elemHozzáadás.innerHTML = "Válaszd ki a feltéteket a listából";

let parent = document.querySelector("div#toppings.form.group");
parent.appendChild(elemHozzáadás);
//parent.removeChild(elemHozzáadás); így törölhető a hozzáadott elem

let fizetendőText = document.createElement("small");
fizetendőText.className = "form-text text muted";
fizetendőText.innerHTML = "Ez a végösszeg";

let parent2 = document.querySelector("div#stex.form-group");
parent2.appendChild(fizetendőText);






//Kell gombra kattintva alert üzenet jön fel (így csak egy funkciót tudok hozzáadni a gomb nyomásához, mert az esetleges többi gombfunkciót felülírom az = jellel!!!)
/* let sendButton = document.querySelector("button.btn.btn-primary");
sendButton.onclick = function() {
    alert ("Rendelés folyamatban");
} */

//ADDEVENTLISTENER - arra lesz jó itt, hogy ezzel a metódussal több funkciót lehet a gomb nyomásához kapcsolni!!!
// addeventlistenerrel nem kell az on elé, csak az eredeti eseményneve(pl. click)
let sendButton = document.querySelector("button.btn.btn-primary"); 
sendButton.addEventListener("click", function() {
    alert("Rendelés folyamatban");
});

window.addEventListener("resize", function() {      // itt átméretezést figyel
    console.log(this.innerWidth, this.innerHeight);
});





// Gombra kattintva bezárható a teljes alert gomb szülő elem 
let alertCloseButton = document.querySelectorAll(".btn-close[data-bs-dismiss='alert']");
let alertCloseEventHandlerFunction = function() { 
    this.parentElement.style.display = "none";
};
for (let i = 0; i < alertCloseButton.length; i++) {
    alertCloseButton[i].addEventListener("click", alertCloseEventHandlerFunction);
}






// Űrlap elemek kezelése addeventlistenerrel
/* let orderForm = document.querySelector("#orderForm");
orderForm.addEventListener("Submit", function(ev) { //Submitra át kell írni a gomb típusát html-ben
    ev.preventDefault();

let inputs = document.querySelectorAll("input");
let values = {};
for (let i = 0; i < inputs.length; i++); {
    values[inputs[i].name] = inputs[i].value;
}
    console.log(values);
}); */




// Select elem kitöltése:

let toppings = [
    "hagyma",
    "uborka",
    "répa",
    "narancs",
];
let toppingSelect = document.querySelector("#topInput");
let index =0;

while(index < toppings.length) {

    let option = document.createElement("option");
    option.value = toppings[index];
    option.innerHTML = toppings[index];
    toppingSelect.appendChild(option);
    index++;
    
}





Element.prototype.setProto = function () {
    this.style.border = "solid 2px pink";
}
    document.querySelector("select#topInput").setProto()


Element.prototype.setProto = function () {
    this.style.border = "solid 2px red";
}
    document.querySelector("input#amountInput").setProto()

    
Element.prototype.setProto = function () {
    this.style.border = "solid 4px green";
}
    document.querySelector("#stex").setProto()

Element.prototype.setProto = function () {
    this.style.border = "solid 2px yellow";
}
    document.querySelector("#gomb").setProto()




/* Több elem módosítása egyszerre ciklussal */
let myNodeList = document.querySelectorAll("input");
    for (let i = 0 ; i < myNodeList.length; i++) {
        myNodeList[i].style.backgroundColor = "lightblue";
    }




/* Több elem módosítása külön fügvénnyel */
function massModify (selector, attribute, value) {
    let nodeList = document.querySelectorAll(selector) ;
    for (let i = 0; i < nodeList.length; i++) {
        nodeList[i][attribute] = value;
    }
}
massModify("input", "placeholder", "érték" )










// Új elemek létrehozása és hozzáadása gyerekként JS-Ben
 
// let helpText = document.createElement("small"); - /* új Html elemet hoz létre */
// helpText.className = "form-text text-muted"; - /* itt állítom be milyen osztályú lesz */
// helpText.innerHTML = "Adja meg a mennyiséget!"; - /* itt a tartalmát állítom be */
// // console.log(helptext); 
// let parent = document.querySelector("div.form-group(1):nth-child(1)");
// parent.appendChild(helpText);






/* function imiCica() {
    return 67 - 2
}
console.log(`eredmény: ${imiCica()}`) ; */






// DOM Events esemenykezelo
/* window.addEventListener("resize", function() {
    console.log(this.innerHeight, this.innerWidth);
});
     */