CREATE DATABASE IF NOT EXISTS BibliothequeConnaissances;
USE BibliothequeConnaissances;
CREATE TABLE IF NOT EXISTS TIPO_DOCUMENTO(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR(5) NOT NULL UNIQUE,
    DESCRIPCION VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS USUARIO(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    USUARIO VARCHAR(20) NOT NULL UNIQUE,
    CONTRASENA VARCHAR(100) NOT NULL,
    CORREO VARCHAR(250) NOT NULL,
    FECHA_MODIFICACION_CLAVE DATE NOT NULL,
    ROL ENUM("ADMINISTRADOR","BIBLIOTECARIO","AFILIADO")
);

CREATE TABLE IF NOT EXISTS PERSONA_AUTOR(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    TIPO_DOCUMENTO INT NOT NULL,
    NUMERO_DOCUMENTO VARCHAR(25) NOT NULL,
    NOMBRE VARCHAR(50) NOT NULL,
    APELLIDO VARCHAR(50) NOT NULL,
    FECHA_NACIMIENTO DATE NOT NULL,
    GENERO ENUM('MASCULINO','FEMENINO', "OTRO") NOT NULL,
    ESTADO ENUM("S","N") NOT NULL,
    TIPO_GENERO_ESCRITURA VARCHAR(50) NOT NULL,
    FOREIGN KEY (TIPO_DOCUMENTO) REFERENCES TIPO_DOCUMENTO(ID)
);

CREATE TABLE IF NOT EXISTS PERSONA_BIBLIOTECARIO(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    TIPO_DOCUMENTO INT NOT NULL,
    NUMERO_DOCUMENTO VARCHAR(25) NOT NULL,
    NOMBRE VARCHAR(50) NOT NULL,
    APELLIDO VARCHAR(50) NOT NULL,
    FECHA_NACIMIENTO DATE NOT NULL,
    GENERO ENUM('MASCULINO','FEMENINO', "OTRO") NOT NULL,
    ESTADO ENUM("S","N") NOT NULL,
    USUARIO INT NOT NULL,
    FECHA_CONTRATACION DATE NOT NULL,
    FOREIGN KEY (TIPO_DOCUMENTO) REFERENCES TIPO_DOCUMENTO(ID),
    FOREIGN KEY (USUARIO) REFERENCES USUARIO(ID)
);

CREATE TABLE IF NOT EXISTS PERSONA_AFILIADO(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    TIPO_DOCUMENTO INT NOT NULL,
    NUMERO_DOCUMENTO VARCHAR(25) NOT NULL,
    NOMBRE VARCHAR(50) NOT NULL,
    APELLIDO VARCHAR(50) NOT NULL,
    FECHA_NACIMIENTO DATE NOT NULL,
    GENERO ENUM('MASCULINO','FEMENINO', "OTRO") NOT NULL,
    ESTADO ENUM("S","N") NOT NULL,
    USUARIO INT NOT NULL,
    FECHA_AFILIACION DATE NOT NULL,
    FOREIGN KEY (TIPO_DOCUMENTO) REFERENCES TIPO_DOCUMENTO(ID),
    FOREIGN KEY (USUARIO) REFERENCES USUARIO(ID)
);

CREATE TABLE IF NOT EXISTS CATEGORIA(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR(2) NOT NULL UNIQUE,
    DESCRIPCION VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS LIBRO(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    CODIGO VARCHAR(10) NOT NULL,
    NOMBRE VARCHAR(50) NOT NULL,
    EDITORIAL VARCHAR(50) NOT NULL,
    CATEGORIA INT NOT NULL,
    AUTOR INT NOT NULL,
    CANTIDAD_COPIAS INT NOT NULL,
    FECHA_PUBLICACION DATE NULL,
    FOREIGN KEY (CATEGORIA) REFERENCES CATEGORIA(ID),
    FOREIGN KEY (AUTOR) REFERENCES PERSONA_AUTOR(ID)
);

CREATE TABLE IF NOT EXISTS PRESTAMO(
    ID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    LIBRO INT NOT NULL,
    AFILIADO INT NOT NULL,
    FECHA_PRESTAMO DATE NOT NULL,
    FECHA_ENTREGADO DATE NULL,
    ENTREGADO ENUM("S","N") NOT NULL,
    FOREIGN KEY (LIBRO) REFERENCES LIBRO(ID),
    FOREIGN KEY (AFILIADO) REFERENCES PERSONA_AFILIADO(ID)
);