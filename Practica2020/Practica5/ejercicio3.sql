#Ejercicio 3 Practica Nº 5: Subconsultas, Tablas Temporales y Variables
#Mostrar empresas contratantes y sus promedios de comisiones pagadas o a pagar, pero sólo
#de aquellas cuyo promedio supere al promedio de Tráigame eso.

SELECT 
	EMP.cuit
    ,EMP.razon_social
    ,ROUND(AVG(importe_comision),2) "Importe Comision"
		FROM agencia_personal.comisiones COM
			JOIN agencia_personal.contratos CON
				ON COM.nro_contrato=CON.nro_contrato
			JOIN agencia_personal.empresas EMP
				ON CON.cuit=EMP.cuit
	GROUP BY EMP.cuit
    HAVING AVG(importe_comision) > (
		SELECT AVG(importe_comision)
			FROM agencia_personal.comisiones COM
			JOIN agencia_personal.contratos CON
				ON COM.nro_contrato=CON.nro_contrato
			JOIN agencia_personal.empresas EMP
				ON CON.cuit=EMP.cuit
			WHERE razon_social="Tráigame eso")
;