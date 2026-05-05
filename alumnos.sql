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