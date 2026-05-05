# Sqlite

SQLite es un sistema de gestión de bases de datos relacional ligero, sin servidor y autocontenido. A diferencia de otros motores como MySQL o PostgreSQL, SQLite no funciona como un servicio separado al que te conectas por red; sino que se incrusta directamente en tu aplicación y lee/escribe desde un archivo común (.db o .sqlite).

## Actividad

Estudie los archivos:

* cli sqlite

y realice lo siguiente:

1. Diseñe una base de datos con carreras campos(id, nombre, creditos), alumnos con campos(id, nombre, apellidos, carrera) y alumnoCarrera con campos (idalumno, idcarrera).
2. Escriba las sentencias sql para crear la base de datos.
3. Use cli sqlite para crear y poblar la base de datos.
4. usando el cli hacer las consultas: **mostrar todos los alumnos**, **mostrar los alumnos de ingeniería informática**
5. Usando `SQLiteStudio` cree una base de datos para sqlite con las tablas: partes campos(id, nombre, existencia, proveedor), proveedores campos(id, nombre, correo, dps) donde dps indica los dias que tardaa en surtir el proveedor. Pueble con datos de ejemplo.
6. En SqliteStudio haga las consultas: **lista de productos**, lista de productos que surte un proveedor dado**.

## Solucion a 2.

Crear el archivo: **alumnos.sql**

```sql
-- Activar claves foráneas (SQLite las soporta pero hay que habilitarlas)
PRAGMA foreign_keys = ON;

-- Crear tabla carreras
CREATE TABLE carreras (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    creditos INTEGER NOT NULL
);

-- Crear tabla alumnos (con campo carrera como clave foránea a carreras)
CREATE TABLE alumnos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    apellidos TEXT NOT NULL,
    carrera INTEGER,  -- referencia a carreras.id (carrera principal del alumno)
    FOREIGN KEY (carrera) REFERENCES carreras(id) ON DELETE SET NULL
);

-- Crear tabla intermedia alumnoCarrera (para relación muchos a muchos)
CREATE TABLE alumnoCarrera (
    idalumno INTEGER NOT NULL,
    idcarrera INTEGER NOT NULL,
    PRIMARY KEY (idalumno, idcarrera),
    FOREIGN KEY (idalumno) REFERENCES alumnos(id) ON DELETE CASCADE,
    FOREIGN KEY (idcarrera) REFERENCES carreras(id) ON DELETE CASCADE
);

-- Insertar algunas carreras de ejemplo
INSERT INTO carreras (nombre, creditos) VALUES
('Ingeniería Informática', 240),
('Administración de Empresas', 180),
('Medicina', 360),
('Diseño Gráfico', 200);

-- Insertar alumnos (asignando una carrera principal)
INSERT INTO alumnos (nombre, apellidos, carrera) VALUES
('Juan', 'Pérez García', 1),
('María', 'López Sánchez', 2),
('Carlos', 'Martínez Ruiz', 1),
('Ana', 'Gómez Fernández', 3);

-- Insertar relaciones adicionales en alumnoCarrera (por si un alumno tiene varias carreras)
INSERT INTO alumnoCarrera (idalumno, idcarrera) VALUES
(1, 1),   -- Juan cursa Ingeniería Informática (principal)
(1, 2),   -- Juan también cursa Administración (doble titulación)
(2, 2),   -- María solo Administración
(3, 1),   -- Carlos solo Ingeniería
(4, 3);   -- Ana solo Medicina
```
## Solución a 3:

En una consola (bash / cmd / power shell) escriba:
```bash
# verificar si esta instalado el cli de sqlite3
sqlite3 --version
# si no esta instalado lee el archivo **Cli-sqlite.md** donde se indica como instalar
# si esta instalado: crear la base de datos
sqlite3 universidad.db < alumnos.sql
```

## Solución a 4

```bash
# abrir el cli con la base de datos universidad.db
sqlite3 universidad.db
# mostrar todos los alumnos
select * from alumnos;
# mostrar los alumnos de informática
select * from alumnos where carrera=1;
# en el cli, es importante poner el ; al final de las sentencias
```
