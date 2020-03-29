USE MASTER
GO

CREATE DATABASE dbventasProyectTer
GO

USE dbventasProyectTer
GO

CREATE TABLE cat_persona
(
	cod_persona			INT PRIMARY KEY NOT NULL,
	chrTipoPersona		CHAR(1) CHECK (chrTipoPersona in ('J','N')),
	chrTipoIdent		CHAR(3) CHECK (chrTipoIdent in ('CED','PAS', 'RUC')),
	numIdentificacion	NVARCHAR(14) UNIQUE NOT NULL,
	strNombre			VARCHAR(60) NOT NULL,
	strApellidoRazon	NVARCHAR(60) NOT NULL,
	dtFechaNacConst		DATE NULL,
	chrGenero			CHAR(1) CHECK (chrGenero IN('M','F','N')),  
	chrEstadoCivilNat	CHAR(2) CHECK (chrEstadoCivilNat IN('S','C','D', 'V', 'P', 'E', 'M')),	--soltero, casado, divorciado, viudo, privado, estatal, mixta
	strDireccion		VARCHAR(300) NULL,
)
GO

CREATE TABLE cat_cargo
(
id_cargo			int primary key, --identity da muchos problemas
nombre_cargo		varchar(50) not null,
descripcion_cargo	varchar(200) not null,
strRegistrado		varchar(100) not null,
strAutorizado		varchar(100) not null,
fecharegistro		date default getdate(),
estado				char(1)check (estado in ('A','I'))not null
)
GO

CREATE TABLE cat_empleado
(
cod_empleado		int primary key,
codPersona			int not null,
numINSS				varchar(50) null,
tipoContrato		char(2) check (tipoContrato IN ('TD', 'TI')) null,---tiempo determinado, tiempo indefinido.
telefono			nvarchar(12) null,
celular				nvarchar(12) null,
fechaReg			date default getdate(),
estado				char(1) check (estado in ('A','I'))not null---agregar al programa
CONSTRAINT FK_persona FOREIGN KEY (codPersona) REFERENCES cat_persona (cod_persona)
)


CREATE TABLE tbl_detalleCargoEmpleado
(
id_detalleCargoEmpleado		int primary key,
codEmpleado					int FOREIGN KEY REFERENCES cat_empleado(cod_empleado),
codCargo					int FOREIGN KEY REFERENCES  cat_cargo(id_cargo),
registrado					varchar(80) null,
autorizado					varchar(80) null,
dtFechaRegis				date default getdate(),
estado						char(1) check(estado in('A','I'))
)
GO

CREATE TABLE cat_pais
(
	idPais 	int primary key not null,
	nombre	varchar(50) not null,
	nacionalidad varchar(50) not null
)
GO

CREATE TABLE cat_proveedor
(
	cod_proveedor	 INT PRIMARY KEY NOT NULL,
	cod_persona		 INT FOREIGN KEY REFERENCES cat_persona(cod_persona),
	politica_venta	 varchar (3) check (politica_venta in ('CRE','COT', 'CON')) not null, --crédito, contado, consignacion
	origen			 int foreign key references cat_pais(idPais),
	observacion		 varchar(200) not null,
	sitioWeb		 NVARCHAR(100) NULL,
	estado			 CHAR(1) CHECK (estado IN ('A','I'))
)
GO

CREATE TABLE tblContactoProveedor
(
	numContactoProv			int primary key,
	codPersona				int foreign key references cat_persona(cod_persona),
	codProveedor			int foreign key references cat_proveedor(cod_proveedor),
	strCelular				nvarchar(12) not null,
	strTelefono				nvarchar(12) not null,
	strEmail				nvarchar(80) not null,
	chrEstado               char(1) check(chrEstado in('A', 'I'))
)
GO


--usar
Create Table cat_marca
(
  id_marca           INT IDENTITY(1,1) PRIMARY KEY,
  Marca_Producto     nvarchar(50) not null
)
GO

--usar
CREATE TABLE cat_unidad_medida
(
	idUnidMed	INT IDENTITY(1,1) PRIMARY KEY,
	strUnidadMedida	VARCHAR(10) NOT NULL,	 
	strDescripcion	VARCHAR(120) NOT NULL
)
GO

--usar
CREATE TABLE tbl_categoria
(
id_categoria int IDENTITY(1,1)PRIMARY KEY NOT NULL,
nombrecat varchar(50) NOT NULL,
observacion varchar(256) NULL,
fecharegistro date default getdate()
)
GO

--usar
CREATE TABLE tbl_presentacion
(
id_presentacion int IDENTITY(1,1)PRIMARY KEY NOT NULL,
nombre varchar(50) NOT NULL,
descripcion varchar(256) NULL,
fecharegistro date default getdate()
)
GO


CREATE TABLE cat_articulo
(
cod_articulo		int PRIMARY KEY  NOT NULL,
codigo_barra		varchar(40) null,
marca				int foreign key references cat_marca(id_marca),
categoria_articulo	int NOT NULL,
unidadMedida		int foreign key references cat_unidad_medida(idUnidMed),
nombre				varchar(50) NOT NULL,
descripcion			varchar(1024) NULL,
imagen				image NULL,
cod_presentacion	int NOT NULL,
CONSTRAINT FK_articulo_categoria2 FOREIGN KEY (categoria_articulo) REFERENCES tbl_categoria (id_categoria), 
CONSTRAINT FK_articulo_presentacion2 FOREIGN KEY (cod_presentacion) REFERENCES tbl_presentacion (id_presentacion) 
)

--para listar los proveedores que ofertan determinado artículo
CREATE TABLE tblArticuloProveedor
(
	idArtProv		int primary key,
	cod_proveedor	int foreign key references cat_proveedor(cod_proveedor),
	cod_articulo	int foreign key references cat_articulo(cod_articulo),
	estado			char(1) check (estado in('A', 'I')) --Si el proveedor todavia provee el artículo o no
)
GO


CREATE TABLE cat_cliente
(
cod_cliente int PRIMARY KEY NOT NULL,
persona int not null,
telefono	nvarchar(12) null,
celular		nvarchar(12) null,
correo		nvarchar(80) null,
fechaReg	date default getdate(),
estado char(1)check (estado in ('A','I'))not null,
CONSTRAINT FK_persona2 FOREIGN KEY (persona) REFERENCES cat_persona (cod_persona)
)
GO

-----------------punto 6
CREATE TABLE cat_compra
(
cod_compra int PRIMARY KEY NOT NULL,
cod_empleado int NOT NULL,
cod_proveedor int NOT NULL,
tipo_compra char(4) check (tipo_compra in ('CRED','CONT','CONS')) NOT NULL,-----credito, contado, consignacion.
subtotal float NOT NULL,
IVA float NOT NULL,
total float NOT NULL,
fecharegistro date default getdate(),
estado char(1)check (estado in ('A','I'))not null, --se controla si todo lo pedido fue recibido
CONSTRAINT FK_ingreso_proveedor FOREIGN KEY (cod_proveedor) REFERENCES cat_proveedor (cod_proveedor),
CONSTRAINT FK_ingreso_trabajador FOREIGN KEY (cod_empleado) REFERENCES  cat_empleado (cod_empleado)
)
GO

CREATE TABLE tbl_detalle_compra
(
cod_detalle_compra int IDENTITY(1,1)PRIMARY KEY NOT NULL,
compra int NOT NULL,
articulo int NOT NULL,
cantidad int not null,
cantidad_rec int not null,
precio_compra int not null,
tasa_descuento varchar(20) not null,
descuento float not null,
monto float not null
CONSTRAINT FK_compra FOREIGN KEY (compra) REFERENCES cat_compra (cod_compra)
)
GO

CREATE TABLE tbl_estadocompra
(
id_estadocompra int identity(1,1) PRIMARY KEY,
detalle_compra int not null,
fecharegistro date default getdate(),
estado char(1) check (estado in ('P','R'))not null, --Pedido, Recibido
CONSTRAINT FK_detallecompra FOREIGN KEY (detalle_compra) REFERENCES tbl_detalle_compra (cod_detalle_compra)
)
GO

Create Table cat_cuentaxpagar
(
NumCuentaxPagar int PRIMARY KEY not null,
Compra int not null,
Monto float not null,
TipoPago nvarchar(50) not null, --Mensual, Quincenal
TasaInteres varchar(50) not null,
Prima float not null,
Cuotas_Pagar int  not null,
Total_Pagar float not null,
FechaInicio date default getdate()
CONSTRAINT FK_cuentacompra FOREIGN KEY (compra) REFERENCES cat_compra (cod_compra)
)
go

CREATE TABLE tbl_DetalleCuentaxPagar
(
id_detallecuentaxpagar int IDENTITY(1,1) primary key not null,
cuentaxpagar int not null,
ultimafechapago date not null,
proximafechapago date not null,
saldoinicial float not null,
montoproximo float not null,
cuotas_pagadas int not null,
cuotasrestantes int not null,
montopagototal float not null,
saldorestante float not null
CONSTRAINT FK_detallecuenta FOREIGN KEY (cuentaxpagar) REFERENCES cat_cuentaxpagar (NumCuentaxPagar)
)
go

CREATE TABLE tbl_estadocuenta
(
id_estadocuentaxpagar int IDENTITY(1,1) PRIMARY KEY not null,
detallecuenta int not null,
FechaInicio date default getdate() not null,
FechaCancelacion varchar(20) null,
EstadoCuenta varchar(10) not null  -- Pendiente, Pagada
CONSTRAINT FK_detallepagar FOREIGN KEY (detallecuenta) REFERENCES tbl_DetalleCuentaxPagar (id_detallecuentaxpagar)
)
go

Create table cat_venta
(
cod_venta int PRIMARY KEY NOT NULL,
cod_empleado int NOT NULL,
forma_pago varchar(20) not null, -- pago x tarjeta o contado
cliente int NOT NULL,
subtotal float NOT NULL,
descuento float  NOT NULL,
IVA float NOT NULL,
total float NOT NULL,
fecharegistro date default getdate(),
estado char(1)check (estado in ('A','I'))not null,
CONSTRAINT FK_venta_empleado FOREIGN KEY (cod_empleado) REFERENCES  cat_empleado (cod_empleado),
CONSTRAINT FK_venta_cliente FOREIGN KEY (cliente) REFERENCES cat_cliente (cod_cliente)
)
GO

CREATE TABLE tbl_detalle_venta
(
cod_detalle_venta int IDENTITY(1,1)PRIMARY KEY NOT NULL,
cod_venta int NOT NULL,
articulo int NOT NULL,
cantidad int NOT NULL,
precio_venta money NOT NULL,
descuento money NOT NULL,
CONSTRAINT FK_venta FOREIGN KEY (cod_venta) REFERENCES cat_venta (cod_venta),
CONSTRAINT FK_articulo FOREIGN KEY (articulo) REFERENCES cat_articulo (cod_articulo)
)
GO

CREATE TABLE tbl_inventario
(	
id_inventario	 int PRIMARY KEY,
articulo		 int not null,
existencia		 int not null,
disponibilidad	 int not null,
cantidadminima	 int not null,
cantidadmaxima	 int not null,
fecharegistro	 date default getdate(), 
estado			 char(1)check (estado in ('A','I'))not null,
CONSTRAINT FK_articuloinventario FOREIGN KEY (articulo) REFERENCES cat_articulo (cod_articulo)
)
GO

CREATE TABLE tblMovimientoInventario
(
	IdMovInvent	INT IDENTITY(1,1) PRIMARY KEY,
	numInventario	INT FOREIGN KEY REFERENCES tbl_inventario(id_inventario),
	tipoMov	CHAR(1) CHECK (tipoMov in('E', 'S')),
	numDoc	INT NOT NULL,
	flCantidad	FLOAT NOT NULL,
	fechaRegisto	DATETIME DEFAULT GETDATE()
)
GO

------------------------------------------Tablas de Seguridad------------------------------------------

--usar
CREATE TABLE tbl_rolacceso
(
id_rolacceso int identity(1,1) primary key,
rol varchar(50) not null,
descripcion varchar(120) not null,
registrado varchar(40) not null,
fechaing date default getdate(),
estado char(1) check(Estado in ('A','I')) --Si el registro se mantiene A, I si no se mantiene
)
GO

--usar
-------------punto 10
CREATE TABLE cat_usuario
(
cod_usuario int primary key,
empleado	 int not null,
rolacceso int not null,
usuario varchar(100) unique not null,
pass  varchar(100) unique not null,
autorizado varchar(100) not null,
fechaing DATE DEFAULT GETDATE(),
estado char(1) check(Estado in ('A','I')), --Si el registro se mantiene A, I si no se mantiene
CONSTRAINT FK_empleado FOREIGN KEY (empleado) REFERENCES cat_empleado (cod_empleado),
CONSTRAINT FK_rolacceso FOREIGN KEY (rolacceso) REFERENCES tbl_rolacceso (id_rolacceso)
)
GO

----------------------punto 11
CREATE TABLE tbl_control_acceso
(
id_control_acceso	int identity(1,1) primary key,
usuario				int not null,
estadoacceso		char(1) check (estadoacceso in ('c','d','b')) not null, --CONTROLA SI EL USUARIO ESTA CONECTADO, DESCONECTADO, BLOQUEADO
dtConexion			date default getdate(),
dtDesconexion		datetime null
)
GO


----------------------------------------------Control de funcionalidad al sistema-------------------------------------------------------------------
--------------------punto 12
CREATE TABLE cat_bitacora
(   
cod_bitacora	int identity(1,1) primary key,
usuario			int not null,
tipoActividad	char(1), --R = registro, E= edicion, L=Lectura
tabla			varchar(50) not null,
ip_maquina		varchar(50) not null,
actividad		varchar(50) not null,
fechaRegis		datetime default getdate(),
estado			char(1) check(Estado in ('A','I')), --Controla si se lleva o no seguimiento a los registros de un usuario
CONSTRAINT FK_usuario FOREIGN KEY (usuario) REFERENCES cat_usuario (cod_usuario)
)
GO

create table fecha_vencimiento
(
cod_vencimiento int primary key not null,
cod_articulo int foreign key references cat_articulo(cod_articulo),
fecha date, 
)
GO

CREATE TABLE tbl_detallebitacora
(   
id_detallebitacora int IDENTITY(1,1) primary key,
cod_bitacora int not null,
tablaafectada varchar(50) not null,
numcamposafectados int not null,
tipomovimiento varchar(50) null, --ingreso, actualizacion
horamovimiento time default getdate(),
registroanterior varchar(50) null,
registronuevo varchar(50) NOT NULL,
CONSTRAINT FK_bitacora1 FOREIGN KEY (cod_bitacora) REFERENCES cat_bitacora_acceso (cod_bitacora)
)
GO



-------------CAJA--------------------------

--usar
CREATE TABLE tblTasaCambio
(
	
	IdTasaCambio		INT PRIMARY KEY,
	flValorCambio		FLOAT NOT NULL,
	dtFechaVigencia		DATETIME NOT NULL,
	dtFechaRegistro		DATETIME DEFAULT GETDATE()

)
GO

CREATE TABLE catCaja
(
numCaja					INT PRIMARY KEY not null,
strNombre				VARCHAR(25) not null,
strDescripcion			VARCHAR(100) null,
saldo					MONEY NOT NULL,
registrado				VARCHAR(40) NOT NULL,
autorizado				VARCHAR(40) NOT NULL,
fechaRegistro			DATETIME DEFAULT GETDATE(),
chrEstado				CHAR(1) CHECK (chrEstado IN ('A', 'C'))
)
GO

CREATE TABLE tblAperturaCaja
(
idApertura				INT PRIMARY KEY NOT NULL,
codCaja					INT FOREIGN KEY REFERENCES catCaja(numCaja),
strUsuario				VARCHAR(40) NOT NULL,
monto					FLOAT NOT NULL,
fechaRegistro			DATETIME DEFAULT GETDATE(),
strObservacion			VARCHAR(100) NULL,	
)
GO

CREATE TABLE tblMovimientoCaja
(
idMovCaja				INT PRIMARY KEY NOT NULL,
codCaja					INT FOREIGN KEY REFERENCES catCaja(numCaja), 					
chrTipoMov				CHAR(1) CHECK (chrTipoMov IN ('E','I')),
strConcepto				VARCHAR(40) NOT NULL,
codComprobante			VARCHAR(20) NOT NULL,
monto					FLOAT NOT NULL,
fechaRegistro			DATETIME DEFAULT GETDATE()
)
CREATE TABLE tblCierreCaja
(
idCierre				INT PRIMARY KEY NOT NULL,
codCaja					INT FOREIGN KEY REFERENCES catCaja(numCaja),
usuarioEntrega			INT FOREIGN KEY REFERENCES cat_usuario(cod_usuario),
usuarioAutoriza			INT FOREIGN KEY REFERENCES cat_usuario(cod_usuario),
flMontoRecuento			FLOAT NOT NULL,
flMontoCierre			FLOAT NOT NULL,
flSaldo					FLOAT NOT NULL,
fechaRegistro			DATETIME DEFAULT GETDATE()
)

