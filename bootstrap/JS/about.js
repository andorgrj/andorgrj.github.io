let users = [
    {surname: "Berger", firstname: "Whitney", age: 22},
    {surname: "Kalk", firstname: "Mike", age: 22},
    {surname: "Doe", firstname: "John", age: 22},
    {surname: "Kolin", firstname: "Nick", age: 19},
    {surname: "Mario", firstname: "Joyki", age: 35},
    {surname: "Yusuf", firstname: "Axel", age: 27},
    {surname: "Jose", firstname: "Niko", age: 23},
    {surname: "Red", firstname: "Marika", age: 28},
]
let tableBody = document.querySelector("#userTable tbody");
let createTD = (html, parent) => {
    
};

let createButtonGroup = parent => {
    let group = document.createElement("div");
    group.className = "btn-group";
    let btnInfo = document.createElement("button");
    btnInfo.className = "btn-info btn";
    btnInfo.innerHTML = '<i class="fas fa-sync-alt"></i>';

    let btnInfo = document.createElement("button");
    btnInfo.className = "btn-danger btn";
    btnInfo.innerHTML = '<i class="fas fa-sync-alt"></i>';

    group.appendChild(btnInfo);
    group.appendChild(btnDanger);

    let td = document.createElement("td");
    td.appendChild(group);
    parent.appendChild(td);
}

for (let k in users) {
    let tr = document.createElement("tr");
    createTD(parseInt(k)+1, tr);
    for(let value of Object.values(users[k])) {
        createTD(value, tr);

    }
    createButtonGroup(tr);
    tableBody.appendChild(tr);
}































/* Tablazat keszítes js-el
let table = document.querySelector("#demoTable"); 
for ( let i = 0; i < users.length; i++ ) {
    let tr = document.createElement("tr");
    for ( let data of Object.values(users[i]) ) {
        let td = document.createElement("td");
        td.innerHTML = data;
        tr.appendChild(td);
    }
    table.appendChild(tr);  
} */