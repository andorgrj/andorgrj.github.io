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
        alert(`az árucikk megrendelése postaköltséggel együtt: ${amount}`) ;
    }
}

// Bootstrap gombra kattintva bezárható a teljes alert szülő elem
let alertCloseButton = document.querySelectorAll(".btn-close[data-bs-dismiss='alert']");
let alertCloseEventHandlerFunction = function(ev) { 
    this.parentElement.style.display = "none";
};
for (let i = 0; i < alertCloseButton.length; i++) {
    alertCloseButton[i].addEventListener("click", alertCloseEventHandlerFunction);
}


// Elem hozzáadása szülő elemhez gyerekként js-ben
let elemHozzáadás = document.createElement("small");
elemHozzáadás.className = "form-text text muted";
elemHozzáadás.innerHTML = "Válaszd ki a feltéteket a listából";

let parent = document.querySelector("div#toppings.form.group");
parent.appendChild(elemHozzáadás);




// Select elem kitöltése.

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
    this.style.border = "solid 2px blue";
}
    document.querySelector("input#topInput").setProto()


Element.prototype.setProto = function () {
    this.style.border = "solid 2px red";
}
    document.querySelector("input#amountInput").setProto()

    
Element.prototype.setProto = function () {
    this.style.border = "solid 4px green";
}
    document.querySelector("#stex").setProto()


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



let orderForm = document.querySelector("#orderForm");
orderForm.addEventListener("Submit", function(ev) {
    ev.preventDefault();
})







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