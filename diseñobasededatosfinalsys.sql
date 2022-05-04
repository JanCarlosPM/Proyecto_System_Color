/*Se crea la base de datos*/
 create database registroEyRprueba
 go
 /*Usamos la base de datos*/
 use registroEyRprueba
 go
 /*Creamos la tabla del departamento*/

CREATE TABLE Departamento(
    iddepartamento    int              IDENTITY(1,1),
    estadodep         bit              DEFAULT 1 NOT NULL,
    nombredep         nvarchar(30)     NOT NULL,
    descripciondep    nvarchar(100)    NULL,
    CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (iddepartamento)
	/*Se declara el Id como llave primaria*/
)
go

/*Si el ID del departamento no está vacío se crea la tabla
 *en caso contrario falla la creación de la tabla
*/

IF OBJECT_ID('Departamento') IS NOT NULL
    PRINT '<<< CREATED TABLE Departamento >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Departamento >>>'
go

/* 
 * Se crea la tabla para los empleados
 */

CREATE TABLE Empleado(
    idrempleado         int              IDENTITY(1,1),
    estadoempleado      bit              DEFAULT 1 NOT NULL,
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


IF OBJECT_ID('Empleado') IS NOT NULL
    PRINT '<<< CREATED TABLE Empleado >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Empleado >>>'
go

/* 
 * Se crea una tabla para el login de los empleados, administradores R U etc.
 */
 /* esta contiene la informacion de los empleados que poseen una cuenta para acceder a los reportes de la aplicacion*/

CREATE TABLE Empleadologin(
    idloginempleado    int    IDENTITY(1,1),
    idlogin            int    NOT NULL,
    idrempleado        int    NOT NULL,
    CONSTRAINT PK8 PRIMARY KEY NONCLUSTERED (idloginempleado)
)
go
/*Si el ID del login no está vacío se crea la tabla
 *en caso contrario falla la creación de la tabla
 */



IF OBJECT_ID('Empleadologin') IS NOT NULL
    PRINT '<<< CREATED TABLE Empleadologin >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Empleadologin >>>'
go

/* 
 * Se crea una tabla para los horarios
 */


CREATE TABLE Horario(
    idhorario             int              IDENTITY(1,1),
    descripcionhorario    nvarchar(100)    NOT NULL,
    horadeentrada         time         NOT NULL,
    horadesalida          time        NOT NULL,
	/* Declaramos el ID horario como llave primaria*/
    CONSTRAINT PK4 PRIMARY KEY NONCLUSTERED (idhorario)
)
go
/*Si el ID horario no está vacío se crea la tabla
 *en caso contrario falla la creación de la tabla
 */


IF OBJECT_ID('Horario') IS NOT NULL
    PRINT '<<< CREATED TABLE Horario >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Horario >>>'
go

/* 
 * Creación de tabla con los datos necesarios en el Login
 */
/* esta contiene la informacion de login de los empleados, contraseña, usuario etc*/

CREATE TABLE LogIn(
    idlogin       int             IDENTITY(1,1),
    usuario       nvarchar(60)    NOT NULL,
    contraseña    nvarchar(60)    NOT NULL,
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (idlogin)
)
go



IF OBJECT_ID('LogIn') IS NOT NULL
    PRINT '<<< CREATED TABLE LogIn >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE LogIn >>>'
go

/* 
 * Tabala de puesto(Cargo)
 */
CREATE TABLE Puesto(
    idpuesto          int              IDENTITY(1,1),
    Nombre            nvarchar(30)     NOT NULL,
    descripcion       nvarchar(100)    NULL,
    estado            bit              DEFAULT 1 NOT NULL,
    iddepartamento    int              NOT NULL,
	/* Declaramos el Id puesto como llave primaria*/ 
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (idpuesto)
)
go
/*Si el ID del puesto no está vacío se crea la tabla
 *en caso contrario falla la creación de la tabla
 */


IF OBJECT_ID('Puesto') IS NOT NULL
    PRINT '<<< CREATED TABLE Puesto >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE Puesto >>>'
go

/* 
 * Creamos la tabla de RegistroEyR
 */


CREATE TABLE RegistrodeEyR(
    idregistro     int         IDENTITY(1,1),
    tipodemarca    bit         NOT NULL,
    horademarca    time    NOT NULL,
    idrempleado    int         NOT NULL,
    CONSTRAINT PK5 PRIMARY KEY NONCLUSTERED (idregistro)
)
go


/*Si el ID del registroEyR no está vacío se crea la tabla
 *en caso contrario falla la creación de la tabla
 */

IF OBJECT_ID('RegistrodeEyR') IS NOT NULL
    PRINT '<<< CREATED TABLE RegistrodeEyR >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE RegistrodeEyR >>>'
go

/* 
 * TABLE: Empleado 
 */

 /* 
 * Concatenamos tablas para agregar el horario y puesto a
 * la tabla del empleado.
 */
ALTER TABLE Empleado ADD CONSTRAINT RefHorario5 
    FOREIGN KEY (idhorario)
    REFERENCES Horario(idhorario)
go

ALTER TABLE Empleado ADD CONSTRAINT RefPuesto12 
    FOREIGN KEY (idpuesto)
    REFERENCES Puesto(idpuesto)
go


/* 
 * TABLE: Empleadologin 
 */

ALTER TABLE Empleadologin ADD CONSTRAINT RefLogIn15 
    FOREIGN KEY (idlogin)
    REFERENCES LogIn(idlogin)
go

ALTER TABLE Empleadologin ADD CONSTRAINT RefEmpleado16 
    FOREIGN KEY (idrempleado)
    REFERENCES Empleado(idrempleado)
go


/* 
 * Alteramos la tabla del puesto y le concatenamos el departamento
 */

ALTER TABLE Puesto ADD CONSTRAINT RefDepartamento11 
    FOREIGN KEY (iddepartamento)
    REFERENCES Departamento(iddepartamento)
go


/* 
 * TABLE: registrodeEyR con alteración
 */


ALTER TABLE RegistrodeEyR ADD CONSTRAINT RefEmpleado4 
    FOREIGN KEY (idrempleado)
    REFERENCES Empleado(idrempleado)
go


/*Probamos la base de datos*/



/*Seleccionamos la tabla de departamento*/
select * from departamento

/*encendemos la tabla departamento para poder ingresar informacion*/
SET IDENTITY_INSERT departamento ON

go
/*Insertamos datos a la tabla Departamento*/
insert into Departamento(iddepartamento,nombredep,descripciondep)
values
('724', 'administradores','equipo econimico, etc')
,('725', 'consultores','medicos generales(no cirujanos')
,('726', 'cirujanos','medicos cirujanos')
go
/*apagamos la tabla departamento para poder ingresar informacion en las demas tablas*/
SET IDENTITY_INSERT departamento off
go
	/*verificamos que la tabla esta modificada*/
	select * from Departamento
go


/****************************/

/*Seleccionamos la tabla de puesto(cargo)*/
select * from puesto
go

/*encendemos la tabla para poder ingresar informacion*/
	SET IDENTITY_INSERT puesto ON

	go
insert into puesto (idpuesto,Nombre,descripcion,iddepartamento)

values ('100','recursos humanos','encargado de personal','724')
,('1021','cirujano pediatra','cirujanos de nenes','726')
,('1022','neuro cirujano','cirujanos de cerebros','726')
,('1023',' oftalmologo','realiza examenes a ojos','725')
go
/*apagamos la tabla puesto para poder ingresar informacion en las demas tablas*/
	SET IDENTITY_INSERT puesto off

	go
	/*verificamos que la tabla esta modificada*/
	select * from puesto
go


/****************************/

/*Seleccionamos la tabla de horarios*/
select * from Horario
go

/*encendemos la tabla para poder ingresar informacion*/
	SET IDENTITY_INSERT horario ON

	go
insert into Horario(idhorario,descripcionhorario,horadeentrada,horadesalida)
values ('1','horario matutino','7:00','3:00')
,('2','horario vespertino','3:00','11:00')
,('3','turno','11:00','7:00')
go
/*apagamos la tabla puesto para poder ingresar informacion en las demas tablas*/
	SET IDENTITY_INSERT horario off

	go
	/*verificamos que la tabla esta modificada*/
	select * from Horario
go


/****************************/

/*Seleccionamos la tabla de empleados*/
select * from Empleado
go

/*encendemos la tabla para poder ingresar informacion*/
	SET IDENTITY_INSERT empleado ON

	go
insert into Empleado(idrempleado, Nombreempleado, Apellidoempleado, telefono, direccion,emailpersonal,emaillaboral, idhorario, idpuesto)
values('251202', 'jason de jesus','esquivel rivera','75024102', 'leon', 'kwzz1@hotmail.com', 'jason.esquivelr13955@est.uca.edu.ni', '1','1023')
     ,('451652', 'jan carlos','prado mayorga','82970798', 'managua', 'sdawzz1@hotmail.com', 'jan.prado13373@est.uca.edu.ni', '1','1021')
     ,('155722', 'leoncio josé','pavón larios','8945322', 'masaya', 'sfgfde4@hotmail.com', 'leoncio.pavon14107@est.uca.edu.ni', '3','1022')
     ,('482359', 'Dylan Daliko','Diaz Mayorga','84435078', 'granada', 'sqwds1@hotmail.com', 'dylan.diaz14298@est.uca.edu.ni', '2','1023')
	, ('10000', 'Ernasto','Robleado Mayorga','84435078', 'granada', 'sqwds1@hotmail.com', 'dylan.diaz14298@est.uca.edu.ni', '2','100')
go
/*apagamos la tabla puesto para poder ingresar informacion en las demas tablas*/
	SET IDENTITY_INSERT empleado off

	go
	/*verificamos que la tabla esta modificada*/
	select * from Empleado
go



/****************************/

/*Seleccionamos la tabla de empleados*/
select * from LogIn
go

/*encendemos la tabla para poder ingresar informacion*/
	SET IDENTITY_INSERT Login ON

	go
insert into logIn(idlogin,usuario,contraseña)
values ('1','admin','123')
go
/*apagamos la tabla puesto para poder ingresar informacion en las demas tablas*/
	SET IDENTITY_INSERT Login off

	go
	/*verificamos que la tabla esta modificada*/
  
select * from logIn
go


/****************************/

/*ahora escogeremos que empleados tienen un login*/
select * from Empleadologin
go

/*encendemos la tabla para poder ingresar informacion*/
	SET IDENTITY_INSERT empleadologin ON

	go
insert into Empleadologin(idloginempleado,idlogin,idrempleado)
values ('15','1','10000')
go
/*apagamos la tabla puesto para poder ingresar informacion en las demas tablas*/
	SET IDENTITY_INSERT EmpleadoLogin off

	go
	/*verificamos que la tabla esta modificada*/
  
select * from Empleadologin
go

/****************************/

/*ahora validaremos el registro de entrada y salida de la aplicacion*/
select * from RegistrodeEyR
go

/*encendemos la tabla para poder ingresar informacion*/
	SET IDENTITY_INSERT RegistrodeEyR ON

	go
insert into RegistrodeEyR(idregistro,tipodemarca,horademarca,idrempleado)	
values ('78','0','7:00','251202')
go
/*apagamos la tabla puesto para poder ingresar informacion en las demas tablas*/
	SET IDENTITY_INSERT RegistroEyR off

	go
	/*verificamos que la tabla esta modificada*/
  
select * from RegistrodeEyR
go

SELECT     Departamento.nombredep, Puesto.Nombre, Empleado.Nombreempleado, Horario.horadeentrada, Horario.horadesalida
FROM        Departamento INNER JOIN
                  Puesto ON Departamento.iddepartamento = Puesto.iddepartamento INNER JOIN
                  Empleado ON Puesto.idpuesto = Empleado.idpuesto INNER JOIN
                  Horario ON Empleado.idhorario = Horario.idhorario