let varOne = 10, varTwo = 20;
    function changeValues(one, two) {
        one = 100;
        two = 200;
        console.log("From function: ", one, two);
    }
    changeValues(varOne, varTwo);
    console.log(varOne, varTwo);

    
    
    
    
    function callByValue(varOne, varTwo) {   
        console.log("A függvényen belül");
        varOne = 100;   varTwo = 200;   
        console.log("varOne =" + varOne +"varTwo =" +varTwo); 
    }  
    
    let varOne = 10; 
    let varTwo = 20; 
    console.log("A függvény hívása előtt"); 
    
    console.log("varOne =" + varOne +"varTwo =" +varTwo); 
    callByValue(varOne, varTwo);
    console.log("A függvény hívása után"); 
    console.log("varOne =" + varOne +" varTwo =" +varTwo); 


// Paraméterek átadása
//Amikor paramétereket adsz át egy függvénynek, akkor érdekes dolgok történnek a háttérben, ezért nem árt tisztában lenni azzal, hogy a függvények mit kezdenek a nekik átadott adatokkal.
//Primitívek átadása érték szerint
//Kis ismétlés:
//Primitív változó típusok: ﻿ \tt Boolean,\,Number,\,Boolean,Number,﻿﻿\tt String,\,Undefined,\,NullString,Undefined,Null﻿
//Tehát a következő szabályok rájuk vonatkoznak.
//Paraméter átadás érték szerint: a primitív típusokat másolja a JS. Azaz, amikor átadsz egy ilyen változót a függvénynek, akkor egy másolatot készít az eredetiről és azzal dolgozik.
//Miért ez a kimenet?
//Létrehoztam a ﻿ \tt varOne varOne﻿ és ﻿ \tt varTwo varTwo﻿ változókat 10 és 20 értékekkel.
//Amikor átadtam őket a függvénynek, akkor kiolvasta az értéküket és ahogy a paraméterlistában megadtam ﻿ \tt callByValue(varOne,\,varTwo) callByValue(varOne,varTwo)﻿ azon a néven létrehozott két lokális változót a függvényben és az eredeti értékeket bemásolta ebbe az két új változóba. Amikor kiíratom a függvényben az értékeket, látszik hogy megváltoztak.
//Mégis amikor az eredeti értékeket újra kiíratom a függvényhívás után, azok változatlanok maradnak. Azért, mert nem az eredeti változókkal dolgozik a függvény, csak a másolatukkal.
//https://www.w3schools.com/js/js_function_parameters.asp