--CREAMOS LA BD
CREATE DATABASE ESCUELA_SENATI
GO
USE ESCUELA_SENATI
GO

--CREAMOS LA TABLA
CREATE TABLE ALUMNO(
CODALUMNO INT IDENTITY(1,1),
CODSALON INT,
FECHA_INSCRIPCIÓN DATE NOT NULL,
NOMBRE VARCHAR(40) NOT NULL,
APELLIDO VARCHAR(30) NOT NULL,
GÉNERO VARCHAR(30) NOT NULL
)
GO

CREATE TABLE NOTA(
CODNOTA INT IDENTITY(1,1),
CODALUMNO INT NOT NULL,
CODCURSO INT NOT NULL,
NOTA INT NOT NULL,
OBSERVACIÓN VARCHAR(30) NOT NULL
)
GO

CREATE TABLE CURSO(
CODCURSO INT IDENTITY(1,1),
NOMBRECUR VARCHAR(30) NOT NULL,
FECHA_INI DATE NOT NULL,
FECHA_FIN DATE NOT NULL,
COSTO_CURSO MONEY NOT NULL
)
GO

CREATE TABLE SALON(
CODSALON INT IDENTITY(1,1),
CAPACIDAD INT NOT NULL,
UBICACION VARCHAR(100)
)
GO

CREATE TABLE DOCENTE(
CODDOCENTE INT IDENTITY(1,1),
CODSALON INT,
CODCURSO INT,
NOMBRE VARCHAR(40) NOT NULL,
APELLIDO VARCHAR(30) NOT NULL 
)
GO

CREATE TABLE HORARIO(
    CODHORARIO INT IDENTITY(1,1),
    CODCURSO INT NOT NULL,
    HORA_INICIO TIME NOT NULL,
    HORA_FIN TIME NOT NULL
)

--MOSTRAR LA TB ALUMNO
SELECT * FROM ALUMNO

--DESEO AGREGAR UN CAMPO DESCRIPCI�N
ALTER TABLE ALUMNO
ADD DESCRIPCION varchar(100)
GO

--MODIFICAR LA TB ALUMNO
ALTER TABLE ALUMNO
ALTER COLUMN GÉNERO nvarchar(1) NOT NULL
GO

--ASIGNAR PK A TB
ALTER TABLE ALUMNO
ADD CONSTRAINT PK_ALUMNO
PRIMARY KEY(CODALUMNO)

ALTER TABLE NOTA
ADD CONSTRAINT PK_NOTA
PRIMARY KEY(CODNOTA)

ALTER TABLE CURSO
ADD CONSTRAINT PK_CURSO
PRIMARY KEY(CODCURSO)

ALTER TABLE SALON
ADD CONSTRAINT PK_SALON
PRIMARY KEY(CODSALON)

ALTER TABLE DOCENTE
ADD CONSTRAINT PK_DOCENTE
PRIMARY KEY(CODDOCENTE)

ALTER TABLE HORARIO
ADD CONSTRAINT PK_HORARIO
PRIMARY KEY(CODHORARIO)

--RELACI�N DE LA TB NOTA & CURSO
GO
ALTER TABLE NOTA
ADD CONSTRAINT FK_NOTA_CURSOS
FOREIGN KEY(CODCURSO)
REFERENCES CURSO(CODCURSO)
GO

ALTER TABLE NOTA
ADD CONSTRAINT FK_NOTA_ALUMNO
FOREIGN KEY(CODALUMNO)
REFERENCES ALUMNO(CODALUMNO)
GO

ALTER TABLE HORARIO
ADD CONSTRAINT FK_HORARIO_CURSO
FOREIGN KEY(CODCURSO)
REFERENCES CURSO(CODCURSO)

ALTER TABLE ALUMNO
ADD CONSTRAINT FKALUMNO_SALON
FOREIGN KEY(CODSALON)
REFERENCES SALON(CODSALON)

ALTER TABLE DOCENTE
ADD CONSTRAINT FK_DOCENTE_SALON
FOREIGN KEY(CODSALON)
REFERENCES SALON(CODSALON)

ALTER TABLE DOCENTE
ADD CONSTRAINT FK_DOCENTE_CURSO
FOREIGN KEY(CODCURSO)
REFERENCES CURSO(CODCURSO)

--CREAR UNA RESTRICCI�N UNIQUE AL CAMPO NOMBRE CURSO DE LA TB CURSO
GO
ALTER TABLE CURSO
ADD CONSTRAINT U_NOM_CURSO_CURSO
UNIQUE(NOMBRECUR)

--ASIGNAR UN VALOR POR DEFECTO AL CAMPO FECHA INSCRIPCI�N DE LA TB ALUMNOS
GO
ALTER TABLE ALUMNO
ADD CONSTRAINT DF_FECHA_ALUM_ALUMNOS
DEFAULT GETDATE() FOR FECHA_INSCRIPCIÓN
GO

--ASIGNAR UN VALOR PARA VALIDAR EL CAMPO QUE DEBE INGRESAR NOTAS DESDE 0 A 20
GO
ALTER TABLE NOTA
ADD CONSTRAINT CHK_NOTA_ALUM_NOTAS
CHECK(NOTA>=0 AND NOTA <21)

GO
SELECT * FROM ALUMNO

--INSERTAR REGISTROS A LA TB ALUMNO
GO

INSERT INTO SALON(CAPACIDAD, UBICACION) VALUES(25,'Sección A: Salón 3'),
											  (28,'Sección E: Salón 5'),	
											  (23,'Sección B: Salón 1'),
											  (30,'Sección D: Salón 2'),
											  (27,'Sección C: Salón 1')
GO

INSERT INTO ALUMNO(CODSALON,NOMBRE,APELLIDO,GÉNERO,DESCRIPCION) VALUES(2,'CARLOS','CASTILLO','F','RETIRADO'),
													   (3,'ESTEFANI','QUISPE','F','ESTUDIANTE'),
													   (2,'PIERO JOSÉ','CERNA ROJAS','M','ESTUDIANTE'),
													   (4,'FLOR MARIBEL','ROJAS FLORES','F','RETIRADO'),
													   (1,'LUICA FLOR','DELGADO TORRES','F','RETIRADO')
GO

INSERT INTO CURSO VALUES('BASE DE DATOS','01/01/2024','01/02/2024',400),
						('BASE DE DATOS I','03/04/2024','04/05/2024',380),
						('PROGRAMACIÓN I','05/05/2024','04/06/2024',400),
						('JAVA I','05/06/2024','05/07/2024',420),
						('BACKEND DEVELOPER','06/07/2024','06/08/2024',500)
GO

INSERT INTO NOTA(CODALUMNO,CODCURSO,NOTA,OBSERVACIÓN) VALUES(4,3,15,'APROBADO'),
															(5,3,10,'DESAPROBADO'),
															(1,4,20,'APROBADO'),
															(2,2,18,'APROBADO'),
															(3,1,13,'APROBADO')
GO

INSERT INTO DOCENTE(CODSALON,CODCURSO,NOMBRE,APELLIDO) VALUES(2,4,'Marco','Peña Díaz'),
															 (3,1,'Joaquín','Palacios Huamaní'),
															 (1,3,'Lucía','Gonzales Rodríguez'),
															 (5,2,'Emilia','Raygada de la Cruz'),
															 (4,5,'Esteban','Torres Vargas')
GO

INSERT INTO HORARIO(CODCURSO,HORA_INICIO,HORA_FIN) VALUES(1,'11:00','14:30'),
														 (2,'10:00','13:30'),
														 (3,'10:00','13:00'),
														 (4,'15:00','18:30'),
														 (5,'14:00:00','17:15:00')
GO

--EJECUTAR TB
SELECT * FROM ALUMNO

SELECT * FROM CURSO

SELECT * FROM NOTA

SELECT * FROM SALON

SELECT * FROM DOCENTE

SELECT CODHORARIO,
	   CODCURSO,
       CONVERT(VARCHAR, HORA_INICIO, 108) HORA_INICIO,
       CONVERT(VARCHAR, HORA_FIN, 108) HORA_FIN
FROM 
    HORARIO

ALTER AUTHORIZATION ON DATABASE::[ESCUELA_SENATI] TO sa
