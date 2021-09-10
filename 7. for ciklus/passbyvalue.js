//Paraméterek átadása
//Amikor paramétereket adsz át egy függvénynek, akkor érdekes dolgok történnek a háttérben, ezért nem árt tisztában lenni azzal, hogy a függvények mit kezdenek a nekik átadott adatokkal.
//Objektumok átadása referencia szerint
//Miket nevezek itt objektumoknak? Azokat a változókat, amelyek nem primitív típusok. Itt elsősorban a már tanult tömbökre gondolok és lesznek még az Object típusok, amelyeket hamarosan megismersz.
//Tehát a következő szabályok rájuk vonatkoznak.
//Paraméter átadás referencia szerint: az objektumokat nem másolja a JS. Minden változónak van egy címe a memóriában. Amikor egy objektumot kap a függvény, akkor létrejön egy új név a lokális változónak, de a memóriacím, ahova mutat, az ugyanaz lesz. Tehát két különböző néven ugyanazt a változót éred el.

function callByReference(arr) {   
    console.log("Érték a függvényen belül");
    arr[0] = 100;
    console.log(arr); 
} 

let varArray = [10]; 
console.log("Függvényhívás előtt"); 
console.log(varArray); 
callByReference(varArray); 
console.log("Függvényhívás után"); 
console.log(varArray);


//Miért ez a kimenet?
//Létrehoztam a ﻿ \tt varArray varArray﻿ tömböt [10] értékkel.
//Amikor átadtam a függvénynek, szándékosan más nevet választottam a lokális változónak: ﻿ \tt arr arr﻿, mivel az teljesen mindegy, hogy mi a neve a függvényen belül. A függvényben megváltoztattam a 0 indexű elemet és kiírtam. Látszik, hogy meg is változott.
//Most jön a meglepetés: amikor az eredeti tömböt újra kiíratom a függvényhívás után, akkor is megváltozott. Azért, mert az eredeti változó referenciájával dolgozik, tehát ugyanazt a helyet módosítja a memóriában.
//Előnyei:
//a függvényre nézve globális objektumokat is könnyen tudsz módosítani
//takarékoskodik a memóriával, mivel nem foglal új memóriaterületet mint a másolásnál
//Hátrányai:
//az átadott objektumokat akaratodon kívül módosíthatod

function callByRef(arr) {
    arr[1] = 200;
    console.log("From function: ", arr);
}
let fruits = ["Pear", "Avocado", "Apple"];
callByRef(fruits);
console.log(fruits);