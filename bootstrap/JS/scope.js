// Global scope.
var globalName = "Andor" ;

function something() {
    var globalName = "" ;
    console.log(globalName) ;
}
something() ;

console.log(globalName) ;