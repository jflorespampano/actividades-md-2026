# Actividad

Objetivo:
probar las bibliotecas better-slite3 y express

Actividad:

## variables de entorno

cree un nuevo proyecto, inicialicelo como siemprre "type":"modules", el archivo principal debe ser "server.js", y cree un script para ejecutar su archivo principal así:

"dev": "node --watch --env-file=.env server.js".

como ve hay 2 cosas nuevas:
1. --env-file=.env
2. --watch

1. Cuando su proyecto esta en desarrollo hay un conjunto de valores que describen datos importantes de su proyecto, por ejemplo el puerto donde atenderá el servidor, el usuario y password de la base de datos y otras mas, estos datos van a cambiar dependiendo si su proyecto esta en desarrollo o ya lo llevo a procduccion, por ejemplo el puerto en su equipo puede ser 3000, pero en el servidor del cleinte deberá ser 5200 y tal vez en el servidor de otro cliente sea 4000, de la misma forma los datos de la base de datos van a cambiar, para hacer mas facil estos cambios se crea un archivo `.env` donde ponemos estos datos y desde nuestra aplicación los leemos. Para esto en la sentencia de ejecución `--env-file=.env` indica que el archivo que tiene esas variables de inicialización se llama `.env` y lo prepara para ser leido. 

Ejemplo:

En el proyecto que acaba de crear agregue un archivo llamado `.env` y ponga los siguientes datos y guardelo.

Archivo: .env
```js
PORT=3000
DB_PLATFORM="sqlite"
HOST="localhost"
DB_NAME="app.db"
USER=""
PASSWORD=""
```

Ahora agregue el archivo `server.js`
```js
    const PORT = process.env.PORT || 3000;
    const DB_PLATFORM = process.env.DB_PLATFORM || "sqlite";
    console.log(PORT)
    console.log(DB_PLATFORM)

```

Como ve podemos leer los valores en el archivo .env

2. la opción  `--watch`

Cuando esta desarrollando su servidor, cada que hace algun cambio debe detener el servidor volverlo a correr y hacer las pruebas, esto es tedioso, la opcion `--watch` detectará cuando su proyecto tenga cambios y reinicia el servidor automáticamente, facilitando el desarrollo.

## probar variables de entorno

 en el proyecto que acaba de crear agregue un servidor para eso:
 1. agregue la biblioteca: en la consola ponga `npm i express`
 2. modifique el archivo `server.js` como sigue:

 ```js
 import express from 'express'

 const PORT = process.env.PORT || 3000;
 const HOST = process.env.HOST || "localhost";

 const app=express()

app.get('/',(req,res)=>{
    console.log("Home")
})

app.listen(PORT, () => {
  console.log(`Servidor en http://${HOST}:${PORT}`);
});
 ```
* arranque el servidor: `npm run dev` y pruebelo
* consulte con el profesor la sentencia: `const HOST = process.env.HOST || "localhost";`
* sin detener el servidor agregue al archivo `server.js` la siguiente ruta:
```js
app.get('/about',(req,res)=>{
    console.log("Estas en aceca de...")
})
```
* guarde el archivo `ctrl+s`
* pruebe en el navegador la nueva ruta: `http://localhost:3000/about`

Como ve al hacer cambios y guardar el servidor se reinicia automáticamente y eso ayuda en el desarrollo, esto es lo que hace la opcion `--watch`

## probar express y better-sqlite

Baje el repositorio de ejemplo del sitio:
```bash
# en su carpetra trabajo haga:
git clone https://github.com/jflorespampano/act-a4-better-express.git
```

En el proyecto no se respaldo (por seguridad) el archivo `.env` por lo tanto debe crearlo, cree un archivo llamado `.env` en la carpeta raiz del proyecto clonado `act-a4-better-express` para esto haga:

```bash
# vaya a la carpeta del pryecto clonado
cd act-a4-better-express
# abra vscode
code .
```

Dentro de code, cree un nuevo archivo: `.env` con el siguiente contenido:

Archivo: .env
```js
PORT=3000

DB_PLATFORM="sqlite"
HOST=""
DB_NAME="app.db"
USER=""
PASSWORD=""
```

## probar servidor

### probar con Thunder

Arranque el servidor: `npm run dev` y pruebelo en thunder con las rutas:

```text
# lance solicitudes get (puede usar el **navegador** o **thunder**) a las url:
http://localhost:3000/user/3
http://localhost:3000/user

# inserte un dato usando POST en **thunder**, enviando los datos json: { "name":"algo", "username":"algo" } al la url:
http://localhost:3000/user
```

### probar con el complemento Rest Client de Huachao Mao

1. Instale el complemento en vscode
2. agrgeue el siguiente archivo a su proyecto

Archivo: 'consultas.http'
```bash
### obtener todos los usuarios
GET http://localhost:3000/user HTTP/1.1
 
### obtener perfil del usuario
GET http://localhost:3000/user/3 HTTP/1.1

### agregar usuario
POST http://localhost:3000/user HTTP/1.1
content-type: application/json
  
{
  "name":"mary",
  "username":"usermary"
}
```

Sobre cada consulta aparecerá un mensaje `send request` y al pasar el raton sobre el mensaje, se pone en color cian, dele clic a ese mensaje y vera el resultado de su consulta a la derecha.

### probar usando curl

**Escenario 1**

suponga que tiene que instalar su aplicación en el servidor del cliente y es unsistema Linux que no tiene instalado ni puede usted instalar VSCode ni Postman. y la única opción que tiene para probar sus rutas es `curl`

probando con curl

```bash
# Obtener todos los usuarios: GET request
curl -X GET http://localhost:3000/user
# o como la opcion get es x default puede omitir X GET:
curl http://localhost:3000/user

# obtener perfil de un usuario
curl http://localhost:3000/user/3

# Insertar un usuario: POST request con JSON
# puede poner la sentencia en varias lineas separandolas con el caracter \ 
curl -X POST http://localhost:3000/user \
  -H "Content-Type: application/json" \
  -d '{"name":"corina","username":"user_corina"}'

```

**Escenario 2** suponga que el parámetro json en -d es largo y no quieres escribirlo en la consola, puede crear un archivo json en tu carpeta para luego enviarlo con curl:

crea el:

Archivo: data.json
```json
{
  "name":"corina",
  "username":"user_corina"
}
```

Y lanza en bash tu consulta así:

```bash
curl -X POST http://localhost:3000/user \
  -H "Content-Type: application/json" \
  -d @datos.json
```

**Escenario 3** Suponga que desea guardar la salida de un get en un archivo para revsar con detalle, ejecute:

```bash
curl http://localhost:3000/user > respuesta.json
```
Ahora puede abrir en VSCode el archivo `respuesta.json` con los datos json recibidos.

**Escenario 3.1** Desea revisar los datos devueltos en el escenario 3 para revisarlos detalladamente para esto desea formatear los datos json del archivo.

Use el formateador de la herramienta [dev toys](https://devtoys.app/), o si prefiere use la opción en línea [devtoys en linea](https://devtoys.vercel.app/).

Para usar el formatedor de devtoys vaya a la opcion **fromateadores** elija **json** ponga su json en la ventana entrada y en la ventana salida vera el resultado, puede copiarlo a su arcivo `respuesta.json`.

**Escenario 4** Si las sentencias curl las tiene que ejecutar en un servidor **Winows** que solo cuenta con la consola **cmd**, las deberá escibir así:

```bash
# ejecutar así en la ventana cmd de Windows
# obtener todos los usuarios la escribe igual
curl http://localhost:3000/user

# obtener un usuario la escribe igual
curl http://localhost:3000/user/3

#insertar un usuario cambia
# si pone el comando en varias líneas debe usar el caracter ^
curl -X POST http://localhost:3000/user ^
  -H "Content-Type: application/json" ^
  -d "{\"name\":\"kobayashi\",\"username\":\"user_koba\"}"
```
## organizar el código DAO

El DAO es un patrón de diseño que se usa para separar la lógica de acceso a datos (base de datos, archivos, APIs, etc.) de la lógica de negocio de una aplicación. Actúa como una capa intermedia entre tu programa y el origen de datos.

Empecemos con un servidor sin usar DAO.

Creamos un servidor:

1. crear el proyecto e instalar la biblioteca `npm i express`
2. instalar la biblioteca `npm i better-sqlite3`
3. crear el archivo `server.js` que acceda a la base de datos `app.db`

Archivo: server.js
```js
import express from 'express'
import Database from "better-sqlite3"

const app=express()
const PORT=3000

app.get('/users',(req,res)=>{
    const db = new Database('app.db');
    const sql = "select * from users;"
    const respuesta = db.prepare(sql).all();
    db.close();
    res.send(respuesta)
})

app.get('/users/:id',(req,res)=>{
    const userId = req.params.id;
    const db = new Database('app.db');
    const sql = "select * from users where id=?;"
    const respuesta = db.prepare(sql).get([userId]);
    db.close();
    res.send(respuesta);
})

app.listen(PORT, () => {
  console.log(`Servidor en http://localhost:${PORT}`);
});
```

Esto funciona pero debemos organizar mejor el proyecto 

### separar el modelo de datos del acceso a datos

Debemos separar la lógica del negocio (como tratamos los datos) de la lógica de acceso a datos (modelos de base de datos API, etcetera), para esto creamos un módulo aparte para el manejo de la lógica de acceso a datos.

Suponga que para el modelo de acceso a datos de `users` requiero la funcionalidad de 

1. recuperar todos los datos llamemoslo `getAll`
2. recuperar un solo dato llamemoslo `get`
3. crear un nuevo usuario llamemoslo `create`

Usaremos una clausura para disponer de estos métodos (preguntar al profesor por las clausuras), por otro lado es recomendable separar la lógica de datos de la lógica de acceso a la base de datos por lo tanto necesitamos 2 clausuras una para la lógica de datos y otra para la lógica de la base de datos.

Creamos el módulo: `controller.bd.js`
```js
import Database from "better-sqlite3";

function controllerDbSqlite(dbFilePath) {
  let db = null;
  let dbOpen = false;

  return {
    /**
     * abre la base de datos, si ya esta abierta no hace nada, si no esta abierta la abre y marca el estado como abierto
     */
    open() {
      db = new Database(dbFilePath);
      dbOpen = true;
    },

    /**
     * 
     * @param {string} sql por ejemplo "insert into users(name,username) values(@name,@username)"
     * @param {object} params por ejemplo {name: "ana", username: "an1"}
     * @returns {object} el resultado de la consulta, por ejemplo {changes: 1, lastInsertRowid: 1}
     */
    run(sql, params = []) {
      const insertData = db.prepare(sql);
      const r = insertData.run(params);
      return r;
    },

    /**
     * 
     * @param {string} sql por ejmplo "select * from users where id=?;"
     * @param {array} params por ejemplo [1]
     * @returns {object} el resultado de la consulta, por ejemplo {id: 1, name: "ana", username: "an1"}
     */
    get(sql, params = []) {
      const res = db.prepare(sql).get(params);
      return res;
    },

    /**
     * 
     * @param {string} sql por ejemplo "select * from users;"
     * @param {array} params ninguno por ejemplo []
     * @returns {array} el resultado de la consulta, por ejemplo [{id: 1, name: "ana", username: "an1"}, {id: 2, name: "juan", username: "ju2"}]
     */
    all(sql, params = []) {
      const res = db.prepare(sql).all();
      return res;
    },

    /**
     * cierra la base de datos, si ya esta cerrada no hace nada, si esta abierta la cierra y marca el estado como cerrado
     */
    close() {
      console.log("base de datos cerrada");
      if (dbOpen) db.close();
      dbOpen = false;
    },
  };
}

export default controllerDbSqlite;
```

Modificamos el archivo: `server.js`
```js
import express from 'express'
import Database from "better-sqlite3"
import controllerDbSqlite from './controller.db.js'

const app=express()
const PORT=3000

const controllerDB = controllerDbSqlite('app.db')

app.get('/users',(req,res)=>{
    const sql = "select * from users;"
    controllerDB.open()
    const respuesta = controllerDB.all(sql)
    controllerDB.close();
    res.send(respuesta)
})

app.get('/users/:id',(req,res)=>{
    const userId = req.params.id;
    controllerDB.open()
    const sql = "select * from users where id=?;"
    const respuesta = controllerDB.get(sql,[userId]);
    controllerDB.close();
    res.send(respuesta);
})

app.listen(PORT, () => {
  console.log(`Servidor en http://localhost:${PORT}`);
});
```
Si tiene instalado el complemento **Rest Client** en VSCode, pruebe las consultas con el archivo: `consultas.http`
```bash
### obtener todos los usuarios
GET http://localhost:3000/users HTTP/1.1
 
### obtener perfil del usuario
GET http://localhost:3000/users/3 HTTP/1.1
```
## Modelo de negocio

Separar el modelo del negocio del servidor. 

Debemos ahora separar toda la lógica de datos del cliente de la lógica de manejo del servidor.

Creamos un modelo de usuario:

Archivo: `model.user.js`
```js
function modelUser(controllerDB){
    return {
        get:function(userId){
            const sql = "select * from users where id=?;"
            controllerDB.open(userId)
            const respuesta = controllerDB.get(sql,[userId]);
            controllerDB.close();
            return(respuesta);
        },
        all:function(){
            const sql = "select * from users;"
            controllerDB.open()
            const respuesta = controllerDB.all(sql)
            controllerDB.close();
            return(respuesta)
        },
        create:function(){

        }
    }
}

export default modelUser
```

Modificamos el archivo `server.js` así:
```js
import express from 'express'
import Database from "better-sqlite3"
import controllerDbSqlite from './controller.db.js'
import modelUser from './model.user.js'

const app=express()
const PORT=3000

const controllerDB = controllerDbSqlite('app.db')
const usrMdl=modelUser(controllerDB)

app.get('/users',(req,res)=>{
    const respuesta = usrMdl.all()
    res.send(respuesta)
})

app.get('/users/:id',(req,res)=>{
    const userId = req.params.id;
    const respuesta = usrMdl.get(userId)
    res.send(respuesta);
})

app.listen(PORT, () => {
  console.log(`Servidor en http://localhost:${PORT}`);
});
```


## Rutas

Agregando rutas al proyecto

**en construcción**

## probar ejemplo de rutas

Regresando al ejemplo que clono antes: `https://github.com/jflorespampano/act-a4-better-express.git`

Recordandole que bajo el proyecto `git clone https://github.com/jflorespampano/act-a4-better-express.git`, bajemops ahora su rama `routes`.

Para bajar la rama routes haga:
```bash
# actualice la información del remoto
git fetch origin

#baje la rama y muevase a ella
git switch -c routes origin/routes
# verificar
git branch
```

Pruebe el código y reviselo.
