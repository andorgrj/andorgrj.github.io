let user = {
    name: "John Doe",
    age: 30,
    sayHi: function() {
        return `Hi, my name is ${this.name}!`;
    }
};
console.log(user.sayHi())

user.name = "majom";

console.log(user.sayHi())



