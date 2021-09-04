Element.prototype.keretSzínMódosítás = function() {
    this.style.border = "solid 2px red";
}
document.querySelector("input#amountInput").keretSzínMódosítás()



document.querySelector("input#amountInput").setAttribute("type", "password"); //type-ot passwordre állítom át pl.


let többHáttérSzínEggyüttesMódosítása = document.querySelectorAll("input");     //Ez több elem együttes módosítására jó
    for (let i = 0; i < többHáttérSzínEggyüttesMódosítása.length; i++) {
        többHáttérSzínEggyüttesMódosítása[i].style.backgroundColor = "yellow";
    
    }
    
  

Element.prototype.feltétHáttérSzín = function(){                
    this.style.backgroundColor = "aqua";
}    
document.querySelector("select#topInput").feltétHáttérSzín()


