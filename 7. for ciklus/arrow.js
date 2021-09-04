/* let adder = function(n1, n2) {
    return n1 + n2;
} */


/* let adder = (n1, n2) => {
    return n1 + n2;
} */

let adder = (n1, n2) => n1 + n2;  //egysoros műveletnél elhagyható a kapcsos zárójel

console.log(adder(8,2));




let rendesÜdvözlés = function(név) {
    return `Hello ${név}!`
}
console.log(rendesÜdvözlés("Rudi"));




let üdvözlés = (név) => `Hello ${név}`
console.log(üdvözlés("Majom"));