let user = {
    "_id": "lkdflkhkldsf3455535",
    indes: 0,
    isActive: true,
    balance: 124000,
    picture: "van valahol"
}

user.minusBalance = function(amount) {
    this.balance -= amount;
}

user.minusBalance(4000);
console.log(user.balance);

user.addBalance = function(amount) {
    this.balance += amount;
}

user.addBalance(22);
console.log(user.balance);

user.getBalance = function() {
    return `EUR ${this.balance} `;
}

console.log(`Ez az aktuális egyenleged: ${user.getBalance()}`);
