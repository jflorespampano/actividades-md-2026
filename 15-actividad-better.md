# better-sqlite3

La biblioteca más rápida y sencilla para SQLite3 en Node.js. Soporte completo para transacciones. Alto rendimiento, eficiencia y seguridad. API sincrónica fácil de usar (mejor concurrencia que una API asincrónica... sí, leyó bien). Soporte para funciones definidas por el usuario, agregados, tablas virtuales y extensiones. Enteros de 64 bits (invisibles hasta que los necesite). Soporte para subprocesos de trabajo (para consultas grandes/lentas).

```sh
#instalar en su proyecto
npm install better-sqlite3
```

## Crear/abrir base de datos

Archivo: **crearDb.js**
```js
import Database from "better-sqlite3";
//abre la base de datos: 'app.db', si no existe la crea
const db = new Database('app.db')
// hacer algo con la base de datos
db.close()
```

Si en su consola ejecuta este código: `node crearDb.js` en su carpeta verá un archivo **app.db** que contiene la base de datos (que ahora esta vacia).

## complemento SQLite Viewer

En code, agregue el complemente SQLite Viewer de **Florian Klampfer**, esto le permitirá ver el contenido de una base de datos sqlite (no le permitirá editarlos).

Ahora puede desde Code ver su archivo de base de datos SQlite **ap.db** que creo antes.

## Crear tabla

Como vio en la práctica anterior puede crear las tablas en la herramienta en línea **cli** o en la interfaz gráfica **SQLite studio**, pero tambien puede crearla desde el código js.

Archivo: crearTabla.js
```js
import Database from "better-sqlite3";
const db = new Database('app.db')

const query=`CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    name STRING NOT NULL,
    username STRING NOT NULL UNIQUE
)    
`
db.exec(query)
db.close()
```

Haga:
1. Pruebe el código anterior: `node crearTabla.js`
2. Ahora vea el archivo **app.db** desde Code, verá que ya contiene una tabla vacia.

## Insertar datos

Insertar un dato:

```js
import Database from "better-sqlite3";

const user = {name:"lupe", username:"lp1"}
const db = new Database('app.db')
const insertData=db.prepare(`insert into users(name,username) values(?,?)`)
const r=insertData.run(user.name, user.username)
```

>[Nota] obserbe que en el insert no se envia el valor del campo id, esto se debe a que en SQLite cuando se define la llave primaria como `INTEGER PRIMARY KEY` automáticamente lo convierte en un campo autoincrementable, es decir no necesito darselo, el lo maneja de forma automática poniendo valores numéricos diferentes iniciando en 1 e incrementando automáticamente en cada insersión. También puede indicar el autoincrement explicitamente `id INTEGER PRIMARY KEY AUTOINCREMENT,`

Insertar varios datos:
```js
//Archivo insertaDatos
import Database from "better-sqlite3";
const db = new Database('app.db')

const data=[
    {name:"ana",username:"an1"},
    {name:"juan",username:"ju2"},
    {name:"bety",username:"be3"},
    {name:"paco",username:"pa0"},
    {name:"luis",username:"lu5"}
]
//Usar `?` en la consulta y pasar los valores como argumentos a `run()` 
//previene automáticamente los ataques de inyección SQL
const insertData=db.prepare(`insert into users(name,username) values(?,?)`)

data.forEach(user=>{
    const r=insertData.run(user.name, user.username)
    console.log(r)
})
db.close()
```
Salida:
```txt
[
  { id: 1, name: 'ana', username: 'an1' },
  { id: 2, name: 'juan', username: 'ju2' },
  { id: 3, name: 'bety', username: 'be3' },
  { id: 4, name: 'paco', username: 'pa0' },
  { id: 5, name: 'luis', username: 'lu5' }
]
```

Vea el contenido del archivo **app.db** en Code.

## Actividad

* Crear la base de datos de su proyecto de clase (en cli, en SQLite admin o en código js).
* Poblar su base de datos con datos de prueba
* Construir funciones para buscar un dato por id, insertar un dato, recuperar todos los datos de cada tabla.
