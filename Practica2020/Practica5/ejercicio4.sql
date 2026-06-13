#Ejercicio 4 Practica Nº 5: Subconsultas, Tablas Temporales y Variables
#Seleccionar las comisiones pagadas que tengan un importe menor al promedio de todas las
#comisiones(pagas y no pagas), mostrando razón social de la empresa contratante, mes
#contrato, año contrato , nro. contrato, nombre y apellido del empleado.



SET @comision_promedio = (
	SELECT AVG(importe_comision)
		FROM agencia_personal.comisiones
);
#SELECT @comision_promedio

SELECT 
	EMP.razon_social "Razon Social"
    , PER.nombre "Nombre"
    , PER.apellido "Apellido"
    , CON.nro_contrato "Numero de Contrato"
    , COM.mes_contrato "Mes"
    , COM.anio_contrato "Año"
    , COM.importe_comision "Importe Comision"
	FROM agencia_personal.comisiones COM
		JOIN agencia_personal.contratos CON
			ON COM.nro_contrato = CON.nro_contrato
		JOIN agencia_personal.empresas EMP
			ON CON.cuit = EMP.cuit
		JOIN agencia_personal.personas PER
			ON CON.dni = PER.dni
	WHERE COM.fecha_pago IS NOT NULL and COM.importe_comision < @comision_promedio
