const myPromise = new Promise( (resolve, reject) => {
    setTimeout( () => {
        resolve({name: "Piri"});
    }, 3000);
});
myPromise.then(
    data => console.log(data),
    err => console.error(err)
);













const myPromise = new Promise((resolve, reject) => {
    setTimeout(() => {
      reject(Error("Error message"));
    }, 3000); 
  }); 
  myPromise
    .then(data => {
      console.log(data);
    })
    .catch(err => {
      console.error(err);
    });














const cat = new Promise(resolve => {
    setTimeout(() => {
      resolve({
        sound: "miau",
        loyal: false
      });
    }, 10000);
   }); 
  const dog = new Promise(resolve => {
    setTimeout(() => {
      resolve({
        sound: "vau",
        loyal: true
      });
    }, 3000);
   }); 
  
  Promise.all([cat, dog]).then(responses => {
    const [catProps, dogProps] = responses;
    console.log(catProps, dogProps);
   });















   const datas = [
    { firstName: "John", lastName: "Doe", age: 31 },
    { firstName: "Jane", lastName: "Doe", age: 20 },
    { firstName: "Anonim", lastName: "Anonymous", age: 62 } 
  ];
   
  function postDataFunc(age) {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        const post = datas.find(postdata => postdata.age === age);
        if (post) {
          resolve(post);
        } else {
          reject(Error("Data not found"));
        }
      }, 3000);
    }); 
  }
  
  postDataFunc(31)
    .then(post => {
      console.log(post);
      return post;
    })
    .then(post => {
      console.log("Name:", post.firstName, post.lastName);
    })
    .catch(err => {    console.error(err);  }); 
  // Name: John Doe