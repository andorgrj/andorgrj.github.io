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

/* // Metódusok:

getBalance:
"balance": 1500, 
"getBalance": function(currency = "$") {
  return `${currency} ${this.balance}`; 
}

getFullname:
"name": {  "first": "Imelda",  "last": "Compton" }, 
"getFullname": function() {
  return `${this.name.last} ${this.name.first}`; 
}

greeting:
"greeting": function() {
  return `Hello, ${this.name.first}! You have 7 unread messages."; 
} */

let user = {
    "-id": "ljkf8984kjjkdfij45" ;
    index: 0,
    isActive: true,
    balance: 1400250;
    picture: "https://placeholder.it/32*32"
}
user.minusbalance = function() {
    user.balance -= amount;
}
/* user.minusbalance = function() {
    this.balance -= amount;
} */

user.addbalance = function() {
    user.balance += amount;
}

user.balanceStatus = function () {
    return amount
}
/* user.balanceStatus = function () {
    return `$ ${this.balance}`
} */