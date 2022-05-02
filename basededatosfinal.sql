/*Se crea la base de datos*/
create database RegistroEyRSystemColor 
go
/*Usamos la base de datos*/
use RegistroEyRSystemColor
go
/*Creamos la tabla del departamento*/
CREATE TABLE departamento(
    iddepartamento    int             NOT NULL,
    nombredep         nvarchar(30)    NOT NULL,
    descripciondep    nvarchar(30)    NULL,
	/*Se declara el Id como llave primaria*/
    CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (iddepartamento)
)
go

/*Si el ID del departamento no está vacío se crea la tabla
 *en caso contrario falla la creación de la tabla
*/
IF OBJECT_ID('departamento') IS NOT NULL
    PRINT '<<< CREATED TABLE departamento >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE departamento >>>'
go

/* 
 * Se crea la tabla para los empleados
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
	/*Declaramos el id del empleado como llave primaria*/
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (idrempleado)
)
go

/*Si el ID del empleado no está vacío se crea la tabla
 *en caso contrario falla la creación de la tabla
 */

IF OBJECT_ID('empleado') IS NOT NULL
    PRINT '<<< CREATED TABLE empleado >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE empleado >>>'
go

/* 
 * Se crea una tabla para los horarios
 */

CREATE TABLE horario(
    idhorario        int    NOT NULL,
    horadeentrada    int    NOT NULL,
    horadesalida     int    NOT NULL,
	/* Declaramos el ID horario como llave primaria*/
    CONSTRAINT PK4 PRIMARY KEY NONCLUSTERED (idhorario)
)
go

/*Si el ID horario no está vacío se crea la tabla
 *en caso contrario falla la creación de la tabla
 */


IF OBJECT_ID('horario') IS NOT NULL
    PRINT '<<< CREATED TABLE horario >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE horario >>>'
go

/* 
 * Creación de tabla con los datos necesarios en el Login
 */

CREATE TABLE logIn(
    idlogin       int             NOT NULL,
    usuario       nvarchar(60)    NOT NULL,
    contraseña    nvarchar(60)    NOT NULL,
	/*Declaramos el ID del login como llave primaria*/
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (idlogin)
)
go

/*Si el ID del login no está vacío se crea la tabla
 *en caso contrario falla la creación de la tabla
 */


IF OBJECT_ID('logIn') IS NOT NULL
    PRINT '<<< CREATED TABLE logIn >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE logIn >>>'
go

/* 
 * Tabala de puesto(Cargo)
 */

CREATE TABLE puesto(
    idpuesto          int             NOT NULL,
    Nombre            nvarchar(30)    NOT NULL,
    descripcion       nvarchar(30)    NULL,
    estado            bit             NOT NULL,
    iddepartamento    int             NOT NULL,
	/* Declaramos el Id puesto como llave primaria*/ 
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (idpuesto)
)
go

/*Si el ID del puesto no está vacío se crea la tabla
 *en caso contrario falla la creación de la tabla
 */


IF OBJECT_ID('puesto') IS NOT NULL
    PRINT '<<< CREATED TABLE puesto >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE puesto >>>'
go

/* 
 * Creamos la tabla de RegistroEyR
 */

CREATE TABLE registrodeEyR(
    idregistro     int    NOT NULL,
    idrempleado    int    NOT NULL,
    idlogin        int    NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY NONCLUSTERED (idregistro)
)
go

/*Si el ID del registroEyR no está vacío se crea la tabla
 *en caso contrario falla la creación de la tabla
 */


IF OBJECT_ID('registrodeEyR') IS NOT NULL
    PRINT '<<< CREATED TABLE registrodeEyR >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE registrodeEyR >>>'
go

/* 
 * Concatenamos tablas para agregar el horario y puesto a
 * la tabla del empleado.
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
 * Alteramos la tabla del puesto y le concatenamos el departamento
 */

ALTER TABLE puesto ADD CONSTRAINT Refdepartamento11 
    FOREIGN KEY (iddepartamento)
    REFERENCES departamento(iddepartamento)
go


/* 
 * TABLE: registrodeEyR con alteración
 */

ALTER TABLE registrodeEyR ADD CONSTRAINT Refempleado4 
    FOREIGN KEY (idrempleado)
    REFERENCES empleado(idrempleado)
go

ALTER TABLE registrodeEyR ADD CONSTRAINT ReflogIn8 
    FOREIGN KEY (idlogin)
    REFERENCES logIn(idlogin)
go

/*Seleccionamos la tabla de departamento*/
select * from departamento
go

/*Insertamos datos a la tabla Departamento*/

insert into Departamento(iddepartamento,nombredep,descripciondep)
values
('724', 'administradores','equipo econimico, etc')
,('725', 'consultores','medicos generales(no cirujanos')
,('726', 'cirujanos','medicos cirujanos')
go

/*Seleccionamos la tabla puesto*/ 

select * from puesto
go

/*Agregamos datos a la tabla de puesto*/

insert into puesto (idpuesto,Nombre,descripcion,estado,iddepartamento)
values ('1021','cirujano pediatra','cirujanos de nenes','1','726')
,('1022','neuro cirujano','cirujanos de cerebros','1','726')
,('1023',' oftalmologo','realiza examenes a ojos','1','725')
go

/*Seleccionamos la tabla horario*/

select * from horario
go

/*Insertamos datos dentro de la tabla de horarios*/ 

insert into horario(idhorario,horadeentrada,horadesalida)
values('12','7','5')
,('11','5','12')
,('16','12','7')
,('17','10','7')
go

/*Seleccionamos la tabla de empleados*/

select * from empleado 
go

/*Agregamos datos a la taba de empleado, en este caso agregamos 4 empleados de prueba*/ 

insert into Empleado(idrempleado, Nombreempleado, Apellidoempleado, telefono, direccion,emailpersonal,emaillaboral, idhorario, idpuesto)
values('251202', 'jason de jesus','esquivel rivera','75024102', 'leon', 'kwzz1@hotmail.com', 'jason.esquivelr13955@est.uca.edu.ni', '12','1023')
     ,('451652', 'jan carlos','prado mayorga','82970798', 'managua', 'sdawzz1@hotmail.com', 'jan.prado13373@est.uca.edu.ni', '16','1021')
     ,('155722', 'leoncio josé','pavón larios','8945322', 'masaya', 'sfgfde4@hotmail.com', 'leoncio.pavon14107@est.uca.edu.ni', '11','1022')
     ,('482359', 'Dylan Daliko','Diaz Mayorga','84435078', 'granada', 'sqwds1@hotmail.com', 'dylan.diaz14298@est.uca.edu.ni', '17','1023')
go

/*Agregamos datos de prueba a la tabla login*/

insert into logIn(idlogin,usuario,contraseña)
values ('1','admin','123')
go

/* Mostramos los datos del Login*/ 
select * from logIn
go

/*Prueba para visualizar los empleados  que poseen el ID*/
select * from empleado where idpuesto = '1023' 
go


  