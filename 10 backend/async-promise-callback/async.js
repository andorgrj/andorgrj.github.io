const asynCall = () => {
    setTimeout( () => {
        return {message: "Ez egy időzített üzenet."};
    }, 2000);
}
const value = asyncCall()
console.log(value.message);