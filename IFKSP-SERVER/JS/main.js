// Keys of users.
let keys = ["id", "name", "email"];

// Function for get data from server.
function getServerData(url) {
    let fetchOptions = {
        method: "GET",
        mode: "cors",
        cache: "no-cache"
    };

    return fetch(url, fetchOptions).then(
    response => response.json(),
    err => console.error(err)
    );
}

function startGetUsers() {
    getServerData("http://localhost:3000/users").then(
        data => fillDataTable(data, "userTable")
    );
}
document.querySelector("#getDataBtn").addEventListener("click", startGetUsers);


// Function for filling the table with data from the server:
function fillDataTable(data, tableID) {
    let table = document.querySelector(`#${tableID}`);
    if (!table) {
        console.error(`Table "${tableID}" is not found.`)
        return;
    }
    // Add new user row to the table.
    let tBody = table.querySelector("tBody");
    tBody.innerHTML = '';
    let newRow = newUserRow();
    tBody.appendChild(newRow);

    for (let row of data) {
        let tr = createElement("tr");
        for (let k of keys) {
            let td = createAnyElement("td");
            if (k == "id") {
                td.innerHTML = row[k];
            } else {
            let input = createAnyElement("input", {
                class: "form-control",
                value: row[k]
            });
            td.appendChild(input);
        }
            tr.appendChild(td);
        }
        let btnGroup = createBtnGroup()
        tr.appendChild(btnGroup);
        tBody.appendChild(tr);
    } 
}
function createAnyElement(name,attribute) {
    let element = document.createElement(name);
    for (let k in attributes) {
        element.setAttribute(k, attributes[k]);
    }
    return element;
}



function createBtnGroup() {
    let group = createAnyElement("div", {class: "btn btn-group"});
    let infoBtn = createAnyElement("button", {class: "btn btn-info", onclick: "getInfo()"});
    infoBtn.innerHTML = '<i class="fa fa-refresh" aria-hidden="true"></i>'
    let delBtn = createAnyElement("button", {class: "btn btn-danger", onclick: "delRow(this)"});
    delBtn.innerHTML = '<i class="fa fa-trash" aria-hidden="true"></i>'

    group.appendChild(infoBtn);
    group.appendChild(infoBtn);

    let td = createAnyElement("td");
    td.appendChild(group);
    return td;
}

function delRow(btn) {
    let tr = btn.parentElement.parentElement.parentElement;
    let id = tr.querySelector("td:first-child").innerHTML;
    let fetchOptions = {
        method: "DELETE",
        mode: "cors",
        cache: "no-cache"
    };

    fetch(`http://localhost:3000/users/${id}`, fetchOptions).then(
        resp => resp.json(),
        err => console.error(err)
    ).then(
        data => {
            startGetUsers();

        }
    );

}

// Create new user.

function newUserRow(row) {
    let tr = createAnyElement("tr");
    for (let k of keys) {
        let td = createAnyElement("td");
        let input = createAnyElement("input", {
            class:"form-control",
            name: k
        });
        td.appendChild(input);
        tr.appendChild(td);
    }

    let newBtn = createAnyElement("button", {
        class: "btn btn-success",
        onclick: "createUser(this)"
    });
    newBtn.innerHTML = '<i class="fas fa-plus-circle"></i>';
    let td = createAnyElement("td");
    td.appendChild(newBtn);
    tr.appendChild(td);

    return tr;
}

// POST
function createUser(btn) {
    let tr = btn.parentElement.parentElement;
    let data = getRowData(tr);
    delete data.id;
    let fetchOptions = {
        method: "POST",
        mode: "cors",
        cache: "no-cache",
        headers: {
            'content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    };
    fetch(`http://localhost:3000/users`, fetchOptions).then(
        resp => resp.json(),
        err => console.error(err)
    ).then(
        data => startGetUsers()
    );
}

function getRowData(tr) {
    let inputs = tr.querySelectorAll("input.form-control");
    let data = {};
    for (let i = 0; i < inputs.length; i++) {
        data[inputs[i].name] = inputs[i].value;
    }
    return data;
}