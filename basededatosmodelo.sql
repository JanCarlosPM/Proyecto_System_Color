/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      Diseñobasededatosfinal.DM1
 *
 * Date Created : Friday, April 22, 2022 10:39:53
 * Target DBMS : Microsoft SQL Server 2017
 */

/* 
 * TABLE: departamento 
 */

CREATE TABLE departamento(
    iddepartamento    int             NOT NULL,
    nombredep         nvarchar(30)    NOT NULL,
    descripciondep    nvarchar(30)    NULL,
    CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (iddepartamento)
)
go



IF OBJECT_ID('departamento') IS NOT NULL
    PRINT '<<< CREATED TABLE departamento >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE departamento >>>'
go

/* 
 * TABLE: empleado 
 */

CREATE TABLE empleado(
    idrempleado         int              NOT NULL,
    Nombreempleado      nvarchar(30)     NOT NULL,
    Apellidoempleado    nvarchar(30)     NOT NULL,
    direccion           nvarchar(100)    NULL,
    telefono            int              NOT NULL,
    emailpersonal       nvarchar(100)    NULL,
    emaillaboral        nvarchar(100)    NOT NULL,
    idhorario           int              NOT NULL,
    idpuesto            int              NOT NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (idrempleado)
)
go



IF OBJECT_ID('empleado') IS NOT NULL
    PRINT '<<< CREATED TABLE empleado >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE empleado >>>'
go

/* 
 * TABLE: horario 
 */

CREATE TABLE horario(
    idhorario        int    NOT NULL,
    horadeentrada    int    NOT NULL,
    horadesalida     int    NOT NULL,
    CONSTRAINT PK4 PRIMARY KEY NONCLUSTERED (idhorario)
)
go



IF OBJECT_ID('horario') IS NOT NULL
    PRINT '<<< CREATED TABLE horario >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE horario >>>'
go

/* 
 * TABLE: logIn 
 */

CREATE TABLE logIn(
    idlogin       int             NOT NULL,
    usuario       nvarchar(60)    NOT NULL,
    contraseña    nvarchar(60)    NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (idlogin)
)
go



IF OBJECT_ID('logIn') IS NOT NULL
    PRINT '<<< CREATED TABLE logIn >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE logIn >>>'
go

/* 
 * TABLE: puesto 
 */

CREATE TABLE puesto(
    idpuesto          int             NOT NULL,
    Nombre            nvarchar(30)    NOT NULL,
    descripcion       nvarchar(30)    NULL,
    estado            bit             NOT NULL,
    iddepartamento    int             NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (idpuesto)
)
go



IF OBJECT_ID('puesto') IS NOT NULL
    PRINT '<<< CREATED TABLE puesto >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE puesto >>>'
go

/* 
 * TABLE: registrodeEyR 
 */

CREATE TABLE registrodeEyR(
    idregistro     int    NOT NULL,
    idrempleado    int    NOT NULL,
    idlogin        int    NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY NONCLUSTERED (idregistro)
)
go



IF OBJECT_ID('registrodeEyR') IS NOT NULL
    PRINT '<<< CREATED TABLE registrodeEyR >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE registrodeEyR >>>'
go

/* 
 * TABLE: empleado 
 */

ALTER TABLE empleado ADD CONSTRAINT Refhorario5 
    FOREIGN KEY (idhorario)
    REFERENCES horario(idhorario)
go

ALTER TABLE empleado ADD CONSTRAINT Refpuesto12 
    FOREIGN KEY (idpuesto)
    REFERENCES puesto(idpuesto)
go


/* 
 * TABLE: puesto 
 */

ALTER TABLE puesto ADD CONSTRAINT Refdepartamento11 
    FOREIGN KEY (iddepartamento)
    REFERENCES departamento(iddepartamento)
go


/* 
 * TABLE: registrodeEyR 
 */

ALTER TABLE registrodeEyR ADD CONSTRAINT Refempleado4 
    FOREIGN KEY (idrempleado)
    REFERENCES empleado(idrempleado)
go

ALTER TABLE registrodeEyR ADD CONSTRAINT ReflogIn8 
    FOREIGN KEY (idlogin)
    REFERENCES logIn(idlogin)
go

select * from departamento
go

insert into Departamento(iddepartamento,nombredep,descripciondep)
values
('724', 'administradores','equipo econimico, etc')
,('725', 'consultores','medicos generales(no cirujanos')
go

select * from puesto
go
insert into puesto (idpuesto,Nombre,descripcion,estado,iddepartamento)
values ('1021','cirujano pediatra','cirujanos de nenes','1','722')
,('1022','neuro cirujano','cirujanos de cerebros','1','722')
,('1023','cirujano ocular','cirujanos de ojos','1','722')
go
select * from horario
go
insert into horario(idhorario,horadeentrada,horadesalida)
values('12','7','5')
go
select * from empleado 
go

insert into Empleado(idrempleado, Nombreempleado, Apellidoempleado, telefono, direccion,emailpersonal,emaillaboral, idhorario, idpuesto)
values('251202', 'jason de jesus','esquivel rivera','75024102', 'leon', 'kwzz1@hotmail.com', 'jason.esquivelr13955@est.uca.edu.ni', '12','1023')
go

select * from logIn 
go
insert into logIn(idlogin,usuario,contraseña)
values ('1','admin','123')
go
select * from registrodeEyR
go
insert into registrodeEyR (idregistro,idrempleado,idlogin)
values ('101','251202','1')
go

select idrempleado,idregistro from registrodeEyR 
go
select nombreempleado,apellidoempleado,idhorario from empleado
go
