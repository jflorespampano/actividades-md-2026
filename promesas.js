function mipromesa(){
    //throw new Error("Erron en los datos")
    return new Promise((resolve,reject)=>{
        setTimeout(()=>{
            //resolve("Promesa cumplida");
            reject("Promesa rechazada");
        }, 3000);
    });
}

mipromesa()
.then(function(resp){
    console.log("promesa exitosa:",resp);
}
/*,
function(resp){
    console.log("fracaso la promesa:",resp);
}*/)
.catch(function(error){
    console.log("error en la promesa:",error);
})
.finally(function(){
    console.log("promesa finalizada");
})