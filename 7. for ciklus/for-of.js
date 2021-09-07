let cars = ["Volvo", "BMW", "Opel"];

for (let car of cars) {
    console.log(car);
}


//Nem a kulcsokon hanem az értékeken megy végig!


let számok = [10,20,30];

for (let érték of számok) {
    érték += 1;
    console.log(érték);
}


let string = "Hello";
for (let characters of string) {
    console.log(characters);
}