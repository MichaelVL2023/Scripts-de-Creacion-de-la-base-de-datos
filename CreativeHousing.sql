CREATE DATABASE CreativeHousingDB
go

USE CreativeHousingDB
go


-- tables
-- Table: artefactos_electronicos
CREATE TABLE artefactos_electronicos (
    codigo  int  NOT NULL,
    nombre  varchar(100)  NOT NULL,
    marca   varchar(100)  NOT NULL,
    modelo  varchar(100)  NOT NULL,
    precio  money  NOT NULL,
    ancho   float  NOT NULL,
    largo   float  NOT NULL,
    altura  float  NOT NULL,
    CONSTRAINT pk_artefactos_electronicos PRIMARY KEY (codigo)
);



-- Table: categorias
CREATE TABLE categorias (
    codigo              int  NOT NULL,
    nombre_categoria    varchar(45)  NOT NULL,
    CONSTRAINT pk_categorias PRIMARY KEY (codigo)
);

-- Table: decoraciones
CREATE TABLE decoraciones (
    codigo  int  NOT NULL,
    nombre  varchar(100)  NOT NULL,
    color   varchar(50)  NOT NULL,
    textura varchar(100)  NOT NULL,
    precio  money  NOT NULL,
    CONSTRAINT pk_decoraciones PRIMARY KEY (codigo)
);

-- Table: espacios
CREATE TABLE espacios (
    codigo          int  NOT NULL,
    tipo_de_espacio varchar(100)  NOT NULL,
    CONSTRAINT pk_espacios PRIMARY KEY (codigo)
);



-- Table: muebles
CREATE TABLE muebles (
    codigo  int  NOT NULL,
    nombre  varchar(100)  NOT NULL,
    modelo  varchar(100)  NOT NULL,
    marca   varchar(100)  NOT NULL,
    color   varchar(50)  NOT NULL,
    precio  money  NOT NULL,
    ancho   float  NOT NULL,
    largo   float  NOT NULL,
    altura  float  NOT NULL,
    CONSTRAINT pk_muebles PRIMARY KEY (codigo)
);


-- Table: planes
CREATE TABLE planes (
    codigo      int  NOT NULL,
    monto       money  NOT NULL,
    beneficios  text  NOT NULL,
    CONSTRAINT pk_planes PRIMARY KEY (codigo)
);

-- Table: proyectos
CREATE TABLE proyectos (
    codigo              int  NOT NULL,
    codigo_usuario      int  NOT NULL,
    nombre              varchar(100)  NOT NULL,
    fecha_de_creacion   date  NOT NULL,
    descripcion         text  NOT NULL,
    estado              varchar(100)  NOT NULL,
    ultima_modificacion date  NOT NULL,
    CONSTRAINT pk_proyectos PRIMARY KEY (codigo)
);

-- Table: usuarios
CREATE TABLE usuarios (
    codigo              int  NOT NULL,
    dni                 char(8)  NOT NULL,
    nombre              varchar(100)  NOT NULL,
    apellido_paterno    varchar(50)  NOT NULL,
    apellido_materno    varchar(50)  NOT NULL,
    correo_electronico  varchar(200)  NOT NULL,
    contrasenia         varchar(20)  NOT NULL,
    numero_telefonico   char(9)  NOT NULL,
     CONSTRAINT pk_usuarios PRIMARY KEY (codigo)
);

-- FOREINGS KEYS

-- Table: proyectos
ALTER TABLE proyectos
    ADD CONSTRAINT fk_usuarios_to_proyectos
        FOREIGN KEY (codigo_usuario)
            REFERENCES usuarios (codigo)


-- TABLAS INTERMEDIAS

-- Table: calificaciones_proyectos
CREATE TABLE calificaciones_proyectos (
    codigo_usuario          int  NOT NULL,
    codigo_proyecto         int  NOT NULL,
    fecha_de_calificacion   date  NOT NULL,
    puntuacion              int  NOT NULL,
    comentario              varchar(300) NOT NULL,
    PRIMARY KEY (codigo_usuario,codigo_proyecto,fecha_de_calificacion),
    FOREIGN KEY (codigo_usuario)  REFERENCES usuarios(codigo),
    FOREIGN KEY (codigo_proyecto) REFERENCES proyectos(codigo)
);

-- Table: espacios_artefactos_electronicos
CREATE TABLE espacios_artefactos_electronicos (
    codigo_artefacto_electronico    int  NOT NULL,
    codigo_espacio                  int  NOT NULL,
    PRIMARY KEY (codigo_artefacto_electronico,codigo_espacio),
    FOREIGN KEY (codigo_artefacto_electronico)  REFERENCES artefactos_electronicos(codigo),
    FOREIGN KEY (codigo_espacio) REFERENCES espacios(codigo)
);

-- Table: espacios_decoraciones
CREATE TABLE espacios_decoraciones (
    codigo_decoracion   int  NOT NULL,
    codigo_espacio      int  NOT NULL,
    PRIMARY KEY (codigo_decoracion,codigo_espacio),
    FOREIGN KEY (codigo_decoracion)  REFERENCES decoraciones(codigo),
    FOREIGN KEY (codigo_espacio) REFERENCES espacios(codigo)
);

-- Table: membresias
CREATE TABLE membresias (
    codigo_usuario      int  NOT NULL,
    codigo_plan         int  NOT NULL,
    fecha_inicio        date  NOT NULL,
    fecha_vencimiento   date  NOT NULL,
    estado              varchar(15)  NOT NULL,
    PRIMARY KEY (codigo_usuario,codigo_plan,fecha_inicio),
    FOREIGN KEY (codigo_usuario)  REFERENCES usuarios(codigo),
    FOREIGN KEY (codigo_plan) REFERENCES planes (codigo)
);


-- Table: espacios_muebles
CREATE TABLE espacios_muebles (
    codigo_mueble       int  NOT NULL,
    codigo_espacio     int  NOT NULL,
    PRIMARY KEY (codigo_mueble,codigo_espacio),
    FOREIGN KEY (codigo_mueble)  REFERENCES muebles(codigo),
    FOREIGN KEY (codigo_espacio) REFERENCES espacios (codigo)
);

-- Table: proyectos_categorias
CREATE TABLE proyectos_categorias (
    codigo_proyecto     int  NOT NULL,
    codigo_categoria    int  NOT NULL,
    PRIMARY KEY (codigo_proyecto,codigo_categoria),
    FOREIGN KEY (codigo_proyecto)  REFERENCES proyectos(codigo),
    FOREIGN KEY (codigo_categoria) REFERENCES categorias (codigo)
);

-- Table: proyectos_espacios
CREATE TABLE proyectos_espacios (
    codigo_proyecto     int  NOT NULL,
    codigo_espacio      int  NOT NULL,
    PRIMARY KEY (codigo_proyecto,codigo_espacio),
    FOREIGN KEY (codigo_proyecto)  REFERENCES proyectos(codigo),
    FOREIGN KEY (codigo_espacio) REFERENCES espacios (codigo)
);

