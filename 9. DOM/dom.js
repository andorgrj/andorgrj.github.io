Element.prototype.keretSzínMódosítás = function() {
    this.style.border = "solid 2px red";
}
document.querySelector("input#amountInput").keretSzínMódosítás()





document.querySelector("input#amountInput").setAttribute("type", "password"); //type-ot passwordre állítom át pl.





let myNodeList = document.querySelectorAll("input");     //Ez több elem együttes módosítására jó
    for (let i = 0; i < myNodeList.length; i++) {
        myNodeList[i].style.backgroundColor = "yellow";
    
    }
    
  

Element.prototype.feltétHáttérSzín = function(){                
    this.style.backgroundColor = "aqua";
}    
document.querySelector("select#topInput").feltétHáttérSzín()





/* for (let element in myNodeList) {
    if (element.style) {
        element.style.color = "red" ;
        console.log("red")
    }
} */




function massmodify(selector, attribute, value) {
    let nodeList = document.querySelectorAll(selector);
    for (let i = 0; i < nodeList.length; i++) {
        nodeList[i][attribute] = value;
    }
}
massmodify("input", "placeholder", "érték")

