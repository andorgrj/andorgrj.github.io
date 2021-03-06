/* Arrow Function
Elérkeztünk a függvényekkel kapcsolatos újítások legzseniálisabb részéhez, azaz az ﻿\texttt {Arrow function}Arrow function﻿ -ökhöz.
Nézzük meg mi is ez az új CSODA. Az előző leckékben már tettem rá említést, most a gyakorlatban is megmutatom, hogy is teszik egyszerűbbé az életünket az ﻿\texttt {arrow function}arrow function﻿ -ök.
Az ﻿\texttt {arrow function}arrow function﻿ segítségével egyszerűbben tudsz létrehozni függvényeket, mint függvény kifejezéssel.

*/

let people = [
    {
      firstName: "John",
      lastName: "Doe"
    },
    {
      firstName: "Jane",
      lastName: "Doe"
    }
  ]; 
  let template = `<div>  ${people .map(function(person) {
           return `<p> ${person.firstName} ${person.lastName} </p>`;
            })
          .join("")} </div>`;

/* Egyszerűsítve */


 let people = [
  {
    firstName: "John",
    lastName: "Doe"
  },
  {
    firstName: "Jane",
    lastName: "Doe"
  }
]; 
let template = `<div> 
    ${people .map(person => `<p> ${person.firstName} ${person.lastName}</p>`)
    .join("")} </div>`; 
console.log(template);<div> <p> John Doe </p><p> Jane Doe </p> </div>        


/* Ugyanazt kapjuk a kimeneten. De mi is történt? A ﻿\tt callbackcallback﻿ függvényünket átírtuk egy újfajta szintaxisra.
elhagytuk a ﻿\tt functionfunction﻿ kulcsszót
az ﻿\texttt {arrow function}arrow function﻿ mindig anonim lesz
A paraméter körüli zárójeleket töröltük (EZT CSAK AKKOR TEHETJÜK MEG HA 1 PARAMÉTER VAN!)
Elhagytuk a kapcsos zárójeleket (NEM MINDIG!)
Egy => jelet írunk a paramétere(k) után
Elhagytuk a ﻿\tt returnreturn﻿ kulcsszót */

// Van egy webshopunk, és a html kódból meg kell mondanunk, hogy az általunk árult szerverek összesített ára mennyi:

<!DOCTYPE html>
    <html lang="hu">
     <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Arrow Function Example</title>
    </head>
     <body>
        <ul id="price-list">
            <li>TV</li>
            <li data-company="Dell">Server</li>
            <li data-price="11.012,12">TV</li>
            <li data-price="23.243,55">Server</li>
            <li data-price="4.543,29">TV</li>
            <li data-price="230.323,32">Server</li>
            <li data-price="48.344,30">Server</li>
        </ul>
    </body>
    <script>
        const serverPrice = Array.from(
            document.querySelectorAll('#price-list li[data-price]'))
             .filter(item => item.textContent.includes('Server'))
             .map(item => parseFloat(item.dataset.price.replace('.', '')
             .replace(',', '.')))             
            .reduce((total, item) => total + item);         
        console.log(serverPrice);
    </script>
</html>

</html>
{/* Mindössze annyit teszünk, hogy használjuk a tömb metódusainkat, most már ﻿\texttt {Arrow function}Arrow function﻿ -ökkel kombinálva. (Az ﻿\tt Array.from(\,)Array.from()﻿ szintén hamarosan kifejtésre kerül, csakúgy, mint az ﻿\tt includes(\,)includes()﻿, ami leginkább az ﻿\tt indexOf(\,)indexOf()﻿ -ra hasonlít)
Kigyűjtjük egy konstansba a ﻿\tt price\text{-}listprice-list﻿ id-jú elemen belül az összes li-t, aminek a ﻿\tt data\text{-}pricedata-price﻿ attribútuma meg van adva. (Az ﻿\tt Array.from(\,)Array.from()﻿ -ról a későbbiekben részletesen).
Leszűrjük az elemeket, hogy a "Server" szót tartalmazó elemek maradjanak, tehát csak a szerverek árai érdekelnek.
Tömböt készítünk ezen elemek áráról, mely érték már ﻿\tt floatfloat﻿ -á lesz alakítva (kiszedjük a pontot), és figyelünk a "," karakterekre is, melyeket "."-ra cserélünk.
A kapott összegeket összeadjuk. */}

{/* Arrow function és a return utasítás */}

// return: undefined 
// Üres blokk, implicit return 
(firstName => {})() 

// return: 'Hello John' 
// Nincs blokk, implicit return 
(firstName => 'Hello ' + firstName)('John') 

// return: undefined 
// explicit return kell a blokkon belül, de Hello hiányzik 
(firstName => {'Hello ' + firstName})('John') 

// return: 'Hello John' 
// explicit return a blokkon belül 
(firstName => {return 'Hello ' + firstName})('John') 

// return: undefined 
// a block egy label-t tartalmaz. Nincs explicit return. 
// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/label 
(firstName => {name: firstName})('John') 

// return: {name: 'John'} 
// implicit return a ( ) belül, ami egy objektum 
(firstName => ({name: firstName}))('John') 

// return: name: 'John' 
// explicit return a blokkon belül, objektum 
(firstName => {return {name: firstName}})('John')