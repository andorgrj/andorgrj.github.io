/* Objektumok
Már elég sokszor leírtam, de nem lehet elégszer: az objektumok a való világban létező dolgokat jelentik. Lehet objektum egy ember, állat, autó, ingatlan és még sok más is. Az objektum nem jeleníti meg az összes tulajdonságát a dolgoknak, csak azokat amelyek számunkra fontosak.
Tipikus ﻿\tt \bold{user}user﻿
Alapvető objektum szokott lenni a ﻿\tt user.user.﻿ Egy programot emberek használnak, akik belépnek, kilépnek, adatokkal dolgoznak. Nagyon jó alanyok lesznek most egy kis objektum készítéshez:
Egy durva user objektum felépítése:
let user = {
    "_id": "5cda967e7dc7132184fca4c7",
    "index": 0,
    "guid": "12f9f283-c1fb-475e-9e4d-fdddb30c970c",
    "isActive": true,
    "balance": "$1,241.29",
    "picture": "http://placehold.it/32x32",
    "age": 38,
    "eyeColor": "green",
    "name": {
      "first": "Imelda",
      "last": "Compton"
    },
    "company": "ENERVATE",
    "email": "imelda.compton@enervate.name",
    "phone": "+1 (949) 487-3823",
    "address": "120 Norwood Avenue, Canoochee, Washington, 6049",
    "about": "Ullamco consequat sit Lorem aute voluptate reprehenderit enim ut tempor amet. Ea nostrud deserunt ullamco veniam eu incididunt id exercitation ipsum consequat in ullamco occaecat do. Reprehenderit culpa magna cillum sint aliqua. Tempor sunt qui incididunt culpa mollit et cupidatat sunt amet duis. Esse est nisi Lorem eu cupidatat sint dolor proident do sit.",
    "registered": "Sunday, September 23, 2018 2:35 AM",
    "latitude": "8.539048",
    "longitude": "-42.045441",
    "tags": [
      "voluptate",
      "ipsum",
      "quis",
      "consectetur",
      "elit"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Malone Owens"
      },
      {
        "id": 1,
        "name": "Schultz Morales"
      },
      {
        "id": 2,
        "name": "Suzanne Stephenson"
      }
    ],
    "greeting": "Hello, Imelda! You have 7 unread messages.",
    "favoriteFruit": "apple"
};
Ezt az objektumot egy olyan oldalon generáltattam, ahol lehet a programod teszteléséhez készíteni nagy JSON tömböket (link a doksiknál). Ez a tömb egyik eleme. De ez nem igazi objektum még, csak egy JSON string. Igaz, a JS kompatibilis vele, tehát ha így egy az egyben bemásolnád a kódodba akkor tudnád használni.
Metódusok
Mit ér az objektum metódus nélkül (sokat, de jobb ha van neki)? Átalakítok gyorsan néhány statikus tulajdonságot metódusra, hogy ez is legyen gyakorolva. (nem írom ki a teljes kódot, csak a módosított részeket, tehát így egy az egyben nem lehet lefuttatni)
getBalance:
"balance": 1500, 
"getBalance": function(currency = "$") {
  return `${currency} ${this.balance}`; 
}
A ﻿\tt balancebalance﻿ tulajdonságot Number típusként adom meg, mert lehet hogy lesznek vele matematikai műveletek (csökkentés, növelés, stb...) és így praktikusabb. Ezért létrehozok egy ﻿\tt getBalancegetBalance﻿ metódust, ami formázva adja vissza a felhasználó egyenlegét. Sőt, felveszek egy ﻿\tt currencycurrency﻿ paramétert is $ alapértelmezett értékkel. Ha megadják a pénznemet, amikor meghívják a metódust, akkor azt teszi elé, ha nem, akkor dollár lesz.
getFullname:
"name": {  "first": "Imelda",  "last": "Compton" }, 
"getFullname": function() {
  return `${this.name.last} ${this.name.first}`; 
}
Az előző metódushoz hasonló, az teszi érdekessé, hogy a ﻿\tt namename﻿ az maga is objektum, tehát úgy érem el a vezeték és keresztnevet, hogy ﻿\tt this.name.lastthis.name.last﻿ és ﻿\tt this.name.first;this.name.first;﻿
greeting:
"greeting": function() {
  return `Hello, ${this.name.first}! You have 7 unread messages."; 
}
Ez már csak ujjgyakorlat. A ﻿\tt greetinggreeting﻿ metódus lett és az objektum ﻿\tt namename﻿ tulajdonságából veszi a keresztnevet. Miért jó ez? Azért, mert ha megváltoztatod a nevet, akkor is jól fog működni. Mire gondolok? Ha kiadom ezt a parancsot: ﻿\tt user.name.first\,=\,user.name.first=﻿ ﻿\tt \,"Maria""Maria"﻿ akkor megváltozik a keresztnév. Igen ám, de ha nem a ﻿\tt this.name.firstthis.name.first﻿ -el olvasom ki, akkor továbbra is azt fogja kiírni, hogy ﻿\tt Hello\,Imelda!....HelloImelda!....﻿
 */