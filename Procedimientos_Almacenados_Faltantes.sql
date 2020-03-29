use dbventasProyectTer
GO

-----------------------procedimientos de compra--------------------
Create Proc spinsertar_Compra
(
@cod_compra			int output,
@cod_empleado		int,
@cod_proveedor	    int,
@tipo_compra	    char(4),
@subtotal			float,
@IVA				float,
@total				float,
@fecharegistro		date,
@estado				char(1)
)
As
INSERT INTO cat_compra(cod_empleado,cod_proveedor,tipo_compra,subtotal,IVA,total,fecharegistro,estado) 
values(@cod_empleado,@cod_proveedor,@tipo_compra,@subtotal,@IVA,@total,@fecharegistro,@estado)
GO

create proc speliminar_Compra
(@Cod_Compra int )
as 
delete from cat_compra where @Cod_Compra = cod_compra
go

create proc spmostrar_compra
as
select top 200 * from cat_compra
order by cod_compra desc 
go


create proc spbuscar_compra 
@textobuscar varchar(50)
as 
select * from cat_compra
where tipo_compra like @textobuscar + '%'
go

create proc speditar_Compra
@cod_compra			int output,
@cod_empleado		int,
@cod_proveedor	    int,
@tipo_compra	    char(4),
@subtotal			float,
@IVA				float,
@total				float,
@fecharegistro		date,
@estado				char(1)
as 
update cat_compra set cod_empleado=@cod_empleado,cod_proveedor=@cod_proveedor,tipo_compra=@tipo_compra,
subtotal=@subtotal,IVA=@IVA,total=@total,fecharegistro=@fecharegistro,estado=@estado
where cod_compra=@cod_compra
go

-----------------------Procedimiento de detalle de la compra-----------------

Create Proc spinsertar_DetalleCompra
(
@cod_detalle_compra int output,
@compra				int,
@articulo			int,
@cantidad			int,
@cantidad_rec		int,
@precio_compra		int,
@tasa_descuento		varchar(20),
@descuento			float,
@monto				float 
)
As
INSERT INTO tbl_detalle_compra(compra,articulo,cantidad,cantidad_rec,precio_compra,tasa_descuento,descuento,monto) 
values(@compra,@articulo,@cantidad,@cantidad_rec,@precio_compra,@tasa_descuento,@descuento,@monto)
GO

create proc speliminar_DetalleCompra
(@cod_detalle_compra int )
as 
delete from tbl_detalle_compra where @cod_detalle_compra = cod_detalle_compra
go

create proc spmostrar_Detallecompra
as
select top 200 * from tbl_detalle_compra
order by cod_detalle_compra desc 
go


create proc spbuscar_Detallecompra 
@textobuscar varchar(50)
as 
select * from tbl_detalle_compra
where cod_detalle_compra like @textobuscar + '%'
go

create proc speditar_DetalleCompra
@cod_detalle_compra int output,
@compra				int,
@articulo			int,
@cantidad			int,
@cantidad_rec		int,
@precio_compra		int,
@tasa_descuento		varchar(20),
@descuento			float,
@monto				float 
as 
update tbl_detalle_compra set compra=@compra,articulo=@articulo,cantidad=@cantidad,cantidad_rec=@cantidad_rec,precio_compra=@precio_compra,
tasa_descuento=@tasa_descuento,descuento=@descuento,monto=@monto
where cod_detalle_compra=@cod_detalle_compra
go

--------------------------Procedimiento del estado de la compra----------------------


Create Proc spinsertar_EstadoCompra
(
@id_estadocompra	int output,
@detalle_compra		int,
@fecharegistro		date,
@estado				char(1) 
)
As
INSERT INTO tbl_estadocompra(detalle_compra,fecharegistro,estado) 
values(@detalle_compra,@fecharegistro,@estado)
GO

create proc speliminar_EstadoCompra
(@id_estadocompra int )
as 
delete from tbl_estadocompra where @id_estadocompra= id_estadocompra
go

create proc spmostrar_Estadocompra
as
select top 200 * from tbl_estadocompra
order by id_estadocompra desc 
go


create proc spbuscar_Estadocompra 
@textobuscar varchar(50)
as 
select * from tbl_estadocompra
where estado like @textobuscar + '%'
go

create proc speditar_EstadoCompra
@id_estadocompra	int output,
@detalle_compra		int,
@fecharegistro		date,
@estado				char(1) 
as 
update tbl_estadocompra set detalle_compra=@detalle_compra,fecharegistro=@fecharegistro,estado=@estado
where id_estadocompra=@id_estadocompra
go

--------------------Procedimiento de cuentaXpagar------------------

Create Proc spinsertar_CuentaXpagar
(
@NumCuentaxPagar	int output,
@Compra				int,
@Monto				float,
@TipoPago			nvarchar(50),
@TasaInteres	    varchar(50),
@Prima				float,
@Cuotas_Pagar		int,
@Total_Pagar		float,
@FechaInicio		date
)
As
INSERT INTO cat_cuentaxpagar(Compra,Monto,TipoPago,TasaInteres,Prima,Cuotas_Pagar,Total_Pagar,FechaInicio)
values(@Compra,@Monto,@TipoPago,@TasaInteres,@Prima,@Cuotas_Pagar,@Total_Pagar,@FechaInicio)
GO

create proc speliminar_CuentaXpagar
(@NumCuentaxPagar int )
as 
delete from cat_cuentaxpagar where @NumCuentaxPagar=NumCuentaxPagar
go

create proc spmostrar_CuentaXpagar
as
select top 200 * from cat_cuentaxpagar
order by NumCuentaxPagar desc 
go


create proc spbuscar_CuentasXpagar 
@textobuscar varchar(50)
as 
select * from cat_cuentaxpagar
where NumCuentaxPagar like @textobuscar + '%'
go

create proc speditar_CuentasXpagar
@NumCuentaxPagar	int output,
@Compra				int,
@Monto				float,
@TipoPago			nvarchar(50),
@TasaInteres	    varchar(50),
@Prima				float,
@Cuotas_Pagar		int,
@Total_Pagar		float,
@FechaInicio		date
as 
update cat_cuentaxpagar set Compra=@Compra,Monto=@Monto,TipoPago=@TipoPago,TasaInteres=@TasaInteres,Prima=@Prima,
Cuotas_Pagar=@Cuotas_Pagar,Total_Pagar=@Total_Pagar,FechaInicio=@FechaInicio
where NumCuentaxPagar=@NumCuentaxPagar
go

------------------Procedimiento de Detalle de cuentaXpagar----------


Create Proc spinsertar_DetalleCuentaXpagar
(
@id_detallecuentaxpagar int output,
@cuentaxpagar			int,
@ultimafechapago		date,
@proximafechapago		date,
@saldoinicial			float,
@montoproximo			float,
@cuotas_pagadas			int,
@cuotasrestantes		int,
@montopagototal			float,
@saldorestante			float
)
As
INSERT INTO tbl_DetalleCuentaxPagar(cuentaxpagar,ultimafechapago,proximafechapago,saldoinicial,montoproximo,cuotas_pagadas,
cuotasrestantes,montopagototal,saldorestante)
values(@cuentaxpagar,@ultimafechapago,@proximafechapago,@saldoinicial,@montoproximo,@cuotas_pagadas,
@cuotasrestantes,@montopagototal,@saldorestante)
GO

create proc speliminar_DetalleCuentaXpagar
(@id_detallecuentaxpagar int )
as 
delete from tbl_DetalleCuentaxPagar where @id_detallecuentaxpagar=id_detallecuentaxpagar
go

create proc spmostrar_DetalleCuentaXpagar
as
select top 200 * from tbl_DetalleCuentaxPagar
order by id_detallecuentaxpagar desc 
go


create proc spbuscar_DetalleCuentasXpagar 
@textobuscar varchar(50)
as 
select * from tbl_DetalleCuentaxPagar
where cuotas_pagadas like @textobuscar + '%'
go

create proc speditar_DetalleCuentasXpagar
@id_detallecuentaxpagar int output,
@cuentaxpagar			int,
@ultimafechapago		date,
@proximafechapago		date,
@saldoinicial			float,
@montoproximo			float,
@cuotas_pagadas			int,
@cuotasrestantes		int,
@montopagototal			float,
@saldorestante			float

as 
update tbl_DetalleCuentaxPagar set cuentaxpagar=@cuentaxpagar,ultimafechapago=@ultimafechapago,proximafechapago=@proximafechapago,saldoinicial=@saldoinicial,montoproximo=@montoproximo,cuotas_pagadas=@cuotas_pagadas,
cuotasrestantes=@cuotasrestantes,montopagototal=@montopagototal,saldorestante=@saldorestante
where id_detallecuentaxpagar=@id_detallecuentaxpagar
go
--------------Procedure estado de cuenta------------
Create Proc spinsertar_EstadoCuenta
(
@id_estadocuentaxpagar  int output,
@detallecuenta			int,
@FechaInicio			date,
@FechaCancelacion		varchar(20),
@EstadoCuenta			varchar(10)
)
As
INSERT INTO tbl_estadocuenta(detallecuenta,FechaInicio,FechaCancelacion,EstadoCuenta)
values(@detallecuenta,@FechaInicio,@FechaCancelacion,@EstadoCuenta)
GO

create proc speliminar_EstadoCuenta
(@id_estadocuentaxpagar int )
as 
delete from tbl_estadocuenta where @id_estadocuentaxpagar=id_estadocuentaxpagar
go

create proc spmostrar_EstadoCuenta
as
select top 200 * from tbl_estadocuenta
order by id_estadocuentaxpagar desc 
go


create proc spbuscar_EstadoCuenta 
@textobuscar varchar(50)
as 
select * from tbl_estadocuenta
where EstadoCuenta like @textobuscar + '%'
go

create proc speditar_EstadoCuenta
@id_estadocuentaxpagar  int output,
@detallecuenta			int,
@FechaInicio			date,
@FechaCancelacion		varchar(20),
@EstadoCuenta			varchar(10)

as 
update tbl_estadocuenta set detallecuenta=@EstadoCuenta,FechaInicio=@FechaInicio,FechaCancelacion=@FechaCancelacion,
EstadoCuenta=@EstadoCuenta
where id_estadocuentaxpagar=@id_estadocuentaxpagar
go


----------------------------Procedimeinto de venta--------------------
Create Proc spinsertar_venta
(
@cod_venta		int output,
@cod_empleado	int,
@forma_pago		varchar(20),
@cliente		int,
@subtotal		float,
@descuento		float,
@IVA			float,
@total			float,
@fecharegistro  date,
@estado			char(1)
)
As
INSERT INTO cat_venta(cod_empleado,forma_pago,cliente,subtotal,descuento,IVA,total,fecharegistro,estado)
values(@cod_empleado,@forma_pago,@cliente,@subtotal,@descuento,@IVA,@total,@fecharegistro,@estado)
GO

create proc speliminar_venta
(@cod_venta int )
as 
delete from cat_venta where @cod_venta=cod_venta
go

create proc spmostrar_venta
as
select top 200 * from cat_venta
order by cod_venta desc 
go


create proc spbuscar_venta
@textobuscar varchar(50)
as 
select * from cat_venta
where cod_venta like @textobuscar + '%'
go

create proc speditar_venta
@cod_venta		int output,
@cod_empleado	int,
@forma_pago		varchar(20),
@cliente		int,
@subtotal		float,
@descuento		float,
@IVA			float,
@total			float,
@fecharegistro  date,
@estado			char(1)

as 
update cat_venta set cod_empleado=@cod_empleado,forma_pago=@forma_pago,cliente=@cliente,subtotal=@cliente,descuento=@descuento,IVA=@IVA,total=@total,fecharegistro=@fecharegistro,estado=@estado
where cod_venta=@cod_venta
go

--------------------------Procedure Detalle Venta------------------
Create Proc spinsertar_Detalleventa
(
@cod_detalle_venta  int output,
@cod_venta			int,
@articulo			int,
@cantidad			int,
@precio_venta		money,
@descuento			money
)
As
INSERT INTO tbl_detalle_venta(cod_venta,articulo,cantidad,precio_venta,descuento)
values(@cod_venta,@articulo,@cantidad,@precio_venta,@descuento)
GO

create proc speliminar_Detalleventa
(@cod_detalle_venta int )
as 
delete from tbl_detalle_venta where @cod_detalle_venta=cod_detalle_venta
go

create proc spmostrar_Detalleventa
as
select top 200 * from tbl_detalle_venta
order by cod_detalle_venta desc 
go


create proc spbuscar_Detalleventa
@textobuscar varchar(50)
as 
select * from tbl_detalle_venta
where cod_detalle_venta like @textobuscar + '%'
go

create proc speditar_Detalleventa
@cod_detalle_venta  int output,
@cod_venta			int,
@articulo			int,
@cantidad			int,
@precio_venta		money,
@descuento			money

as 
update tbl_detalle_venta set cod_venta=@cod_venta,articulo=@articulo,cantidad=@cantidad,precio_venta=@precio_venta,descuento=@descuento
where cod_detalle_venta=@cod_detalle_venta
go
