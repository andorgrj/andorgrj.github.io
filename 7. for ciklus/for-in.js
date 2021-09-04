let myCar = {
    make: 'Ford',
    model: 'Mustang',
    year: 1999
};

for (let k in myCar) {
    console.log(k, myCar[k] );
    myCar[k] = myCar[k] +"black"
}

console.log("myCar Object: ", myCar);
console.log("myCar.make értéke: ", myCar.make);