let i = 0;
while(i < 10) {
    i++;
    console.log(i);
}

let animal = {name: "cat", age: 3};
let keys = Object.keys(animal);
i = 0;
while(i < keys.length) {
    console.log(animal[keys[i]]); //keys i lesz a name és age
    i++; 
}

/* Természetesen a ﻿ \tt whilewhile﻿ ciklus is alkalmas arra, hogy tömböket vagy objektumokat járj be a segítségével. Itt viszont nem kapsz semmi segítséget ehhez, neked kell leprogramoznod a kulcsok léptetését.
A példában kiolvasom a kulcsokat, majd bejárom az objektumot, közben pedig növelem az iterátort, ami alapján előállítom a kulcsokat: */



//Az elöltesztelős ciklusoknál megfigyelhettük, hogy először a feltétel vizsgálata történik meg, majd utána a kiértékelés eredményétől függően a ciklusmag futtatása. Ezzel szemben a hátultesztelős ciklus először lefuttatja a ciklusmagot, és csak utána vizsgálja meg a feltételt. A gyakorlatban ez a következőképp fest:

/* let i = 10;         
do {
    console.log(i);
    i++
}
while(i < 0); */