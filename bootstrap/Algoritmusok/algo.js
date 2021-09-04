/* Összegzés algoritmusa

össszeg = 0 
ciklus amíg van még szám, addig
    szám = következő Elem 
    összeg = összeg + szám
ciklus vége
*/


let numericArray = [1, 3, 2, 5, 4, 7, 6, 9];
let sum = 0;
for (let i = 0; i < numericArray.length; i++) {
    sum += numericArray[i];
}
console.log("Sum: ", sum);


/* Számlálás algoritmusa */

let db = 0;
for (let i = 0; i < numericArray.length; i++) {
    if (numericArray[i] % 2 == 0) {
        db++;
    }
}
console.log("Even numbers: ", db);

/* Szélsőérték keresés */

let biggest = numericArray[0];
for (let i = 0; i < numericArray.length; i++) {
    if (numericArray[i] > biggest) {
        biggest = numericArray[i];
     }
}
console.log("The biggest number: ", biggest);

/* Eldöntés algoritmusa  tartalmazza e az ötös számot a tömb*/

let contains = false
for (let i = 0; i < numericArray.length && contains == false; i++) {
    if (numericArray[i] == 5) {
        contains = true;
    }
}
console.log("This array contains 5:", contains) ;


3 % 5 > 1 ? 4:7