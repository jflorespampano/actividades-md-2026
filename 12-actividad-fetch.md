# Actividad fetch

## Pruebe el siguiente código:

```js
const URL='https://jsonplaceholder.typicode.com/posts'

function getDatos(URL){
    fetch(URL)
    .then(resp=>resp.json())
    .then(data=>console.log(data))
    .catch(error=>console.log(error))
}
```

## Convierta la funcion anterior a una función async await y pruebela.

### Solución:

```js
const URL='https://jsonplaceholder.typicode.com/posts'

async function getDatos(URL){
    const resp = await fetch(URL)
    const data = await resp.json()
    console.log(data)
}
```