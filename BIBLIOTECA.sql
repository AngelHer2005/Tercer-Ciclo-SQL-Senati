--CREACI�N DE LA BD BIBLIOTECA
GO
CREATE DATABASE BIBLIOTECA
GO
USE BIBLIOTECA
GO
--CREACI�N DE LA TB DISTRITO
GO
CREATE TABLE DISTRITO(
COD_DIS CHAR(4) NOT NULL PRIMARY KEY CHECK(COD_DIS LIKE 'D[0-9][0-9][0-9]'),
NOM_DIS VARCHAR(30) NOT NULL UNIQUE,
DES_DIS VARCHAR(50) NULL
)
GO
CREATE TABLE TIPO(
COD_TIP CHAR(4) NOT NULL PRIMARY KEY CHECK(COD_TIP LIKE 'T[0-9][0-9][0-9]'),
NOM_TIP VARCHAR(30) NOT NULL,
DES_TIP VARCHAR(50) NULL
)
GO
CREATE TABLE LECTORES(
COD_LEC CHAR(4) NOT NULL PRIMARY KEY CHECK(COD_LEC LIKE 'L[0-9][0-9][0-9]'),
NOM_LEC VARCHAR(30) NOT NULL UNIQUE,
DIR_LEC VARCHAR(50) NOT NULL,
DIS_LEC CHAR(4) NOT NULL FOREIGN KEY(DIS_LEC) REFERENCES DISTRITO,
TIP_LEC CHAR(4) NOT NULL FOREIGN KEY(TIP_LEC) REFERENCES TIPO,
FRE_LEC DATETIME DEFAULT(GETDATE()) NOT NULL,
TEL_LEC CHAR(9) NULL CHECK(TEL_LEC LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
OBS_LEC VARCHAR(50) NULL
)

CREATE TABLE CARGO(
COD_CAR CHAR(4) NOT NULL PRIMARY KEY CHECK(COD_CAR LIKE 'C[0-9][0-9][0-9]'),
NOM_CAR VARCHAR(30) NOT NULL UNIQUE,
DES_CAR VARCHAR(50) NULL
)

CREATE TABLE PERSONAL(
COD_PER CHAR(4) NOT NULL PRIMARY KEY CHECK(COD_PER LIKE 'P[0-9][0-9][0-9]'),
NOM_PER VARCHAR(30) NOT NULL,
DIR_PER VARCHAR(50) NOT NULL,
DIS_PER CHAR(4) NOT NULL FOREIGN KEY(DIS_PER) REFERENCES DISTRITO,
CAR_PER CHAR(4) NOT NULL FOREIGN KEY(CAR_PER) REFERENCES CARGO,
FRE_PER DATETIME DEFAULT(GETDATE()) NOT NULL,
EST_PER VARCHAR(40) NOT NULL,
TEL_PER CHAR(9) NULL CHECK(TEL_PER LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
OBS_PER VARCHAR(50) NULL
)


SELECT * FROM LECTORES

ALTER AUTHORIZATION ON DATABASE::[BIBLIOTECA] TO sa