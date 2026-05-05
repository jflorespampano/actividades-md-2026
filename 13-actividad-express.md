# Actividad express

## Objetivo

Hacer un servidor web con node usando la biblioteca express.

## Requerimientos

1. node
2. conexión a internet
3. editor VSCode

## Actividad

Para crear un proyecto node con express, realice lo siguiente:

1. Crear un nuevo proyecto llamado 'act13-express-server' y carguelo en VSCode

### Solución:

```bash
# abra una consola bash en su carpeta de trabajo
# cree la carpeta de su nuevo proyecto
mkdir act-13-express-server
# muevase a esa carpeda
cd act-13-express-server
# inicialice el proyecto
npm init -y
# abra vscode
code .
```

2. Adecue el archivo **package.json** para que el archivo principal del proyecto se llame **server.js**, el proyecto soporte modulos ES6,  y ademas tenga un script de ejecución.

### Solución

- cambie el nombre del archivo en la entrada "main.js" a: 'server.js'

- indique que usará módulos de ECMA Script agregando la entrada "type":"module", en caso de existir la entrada "type":"commonjs", eliminela.

- cree un comando llamado 'dev' para ejecutar el archivo principal

Su archivo **package.json** debe verse así:

```json
{
  "name": "act-13-express-server",
  "version": "1.0.0",
  "description": "",
  "main": "server.js",
  "type":"module",
  "scripts": {
    "dev": "node server.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
```

## Instale el paquete express

**Express.js** es un framework minimalista y flexible para Node.js que te ayuda a construir aplicaciones web y APIs de forma más rápida y estructurada.

Instale la biblioteca express [Documentación](https://www.npmjs.com/package/express)

### solución:

En una consola, en la carpeta de su proyecto ejecute: 

```bash
npm i express
```

## Crear un servidor

Cree un servidor con los ****'endpoints'****:

1. '/' que devuelva el texto 'HOME'
2. '/user' que devuelva un usuario
3. '/users' que devuelva una lista de usuarios.

### Solución

Crear el archivo 'server.js' y poner el código:

```js
import express from 'express'; //cargar la biblioteca

const app = express(); //crear el servidor
const PORT = 3000;

//para atender el endpoint / al recibir una solicitud get
app.get('/', (req, res) => {
  res.send('¡Hola, mundo!');
});

//para atender el endpoint /user al recibir una solicitud get
app.get('/user', (req, res) => {
    const user={id: 1, name: 'John Doe'}
  res.send(user);
});

app.get('/users', (req, res) => {
    const users=[
        {id: 1, name: 'John Doe'},
        {id: 2, name: 'Jane Smith'},
        {id: 3, name: 'Alice Johnson'}
    ]
  res.send(users);
});

//arrancar el servidor
app.listen(PORT, () => {
  console.log(`Servidor escuchando en http://localhost:${PORT}`);
});
```

Pruebelo así:

1. en una consola en su proyecto, ejecute el programa así: `npm run dev`
2. en su navegador pruebe:
   1. ponga la ruta:  'http://localhost:3000/' debe ver HOME
   2. ponga la ruta: 'http://localhost:3000/user' debe ver un usario
   3. ponga la ruta: 'http://localhost:3000/users' debe ver una lista de usuarios

## Preguntas

Conteste las siguientes preguntas:

1. ¿como se crea un servidor en express en el puerto 3000?

respuesta:

```js
import express from 'express';

const app = express();
const PORT = 3000;


app.listen(PORT, () => {
  console.log(`Servidor escuchando en http://localhost:${PORT}`);
});
```

2. recordando que estamos usando el protocolo HTTP y en el existen un conjunto de métodos (también llamados verbos) que indican que acción queremos realizar sobre la URL y que esos verbos son (GET, POST, PUT, PATCH, DELETE), que verbo en el adecuado para solicitar un recurso al servidor.

respuesta: el verbo **GET**

3. cree el código para hacer 2 solicitudes: un usuario individual y una lista de usuarios al servidor.

respuesta:

```js
app.get('/user', (req, res) => {
    const user={id: 1, name: 'John Doe'}
  res.send(user);
});

app.get('/users', (req, res) => {
    const users=[
        {id: 1, name: 'John Doe'},
        {id: 2, name: 'Jane Smith'},
        {id: 3, name: 'Alice Johnson'}
    ]
   res.send(users);
})
```

4. ¿para que sirve el parámetro **res** de las funciones de **app.get(endpoint, (req,res)=>{})?**

respuesta:

El parámetro **req**: Contiene toda la información de la solicitud HTTP que el cliente envía al servidor. 

El parámetro **res**: Se usa para construir y enviar la respuesta HTTP de vuelta al cliente. Métodos comunes usados en res:

- `res.send()` – Envía una respuesta (texto, HTML, buffer, etc.)
- `res.json()` – Envía un objeto JSON automáticamente con `Content-Type: application/json`
- `res.status()` – Define el código de estado HTTP (200, 404, 500, etc.)
- `res.set()` – Agrega cabeceras a la respuesta
- `res.end()` – Termina la respuesta sin datos

## Ejercicio materias

Repita este ejercicio pero ahora devolviendo:

* la lista de materias 
* la primera materia de la lista

Envie el resultado al profesor.

## Ejercicio DF

Para los datos fake de jsonplaceholder, haga una aplicación que devuelva:

1. la lista de usuarios
2. el primer usuario

solución:

```js
import express from 'express';

const app = express();
const PORT = 3000;


//el primer usuario
app.get('/user', (req, res) => {
  fetch('https://jsonplaceholder.typicode.com/users/1')
  .then(response => response.json())
  .then(users => res.json(users[0]))
  .catch(error => {
    res.status(500).json({ error: 'No se pudieron obtener los usuarios' });
  })
});

//lista de usuarios
app.get('/users', (req, res) => {
  fetch('https://jsonplaceholder.typicode.com/users')
  .then(response => response.json())
  .then(users => res.json(users))
  .catch(error => {
    res.status(500).json({ error: 'No se pudieron obtener los usuarios' });
  })
})

app.listen(PORT, () => {
  console.log(`Servidor en http://localhost:${PORT}`);
});
```

> Note que usamos la sentencia: `res.status(500).json(...)`, esta sentencia hace: envia al usuario la respuesta dentro del json() y ademas envia el código de estado 500, que indica un error, esto se usa cuando queremos enviar una respuesta con un código de estado específico, por ejemplo, la sentencia: `res.json(users)` envia como respuesta la variable usuarios en formato json y por defecto el código de estado 200, si quisieramos enviar un código de estado diferente, por ejemplo 203, usaríamos: `res.status(203).json(users)`



Puede ver que significan los diferengtes códigos de estado http en la página [Códigos de estado de respuesta HTTP - HTTP | MDN](https://developer.mozilla.org/es/docs/Web/HTTP/Reference/Status)

## Referencias

[express en npm](https://www.npmjs.com/package/express)
[express en w3css](https://www.w3schools.com/nodejs/nodejs_express.asp)
