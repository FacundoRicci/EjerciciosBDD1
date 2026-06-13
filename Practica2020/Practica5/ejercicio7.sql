#Ejercicio 7 Practica Nº 5: Subconsultas, Tablas Temporales y Variables
#Mostrar los empleados cuyo salario supere al promedio de sueldo de la empresa que los
#contrató.

DROP TEMPORARY TABLE IF EXISTS tt_sueldos_promedio_por_empresa;

CREATE TEMPORARY TABLE tt_sueldos_promedio_por_empresa
SELECT 
	cuit
	, AVG(sueldo) "sueldo_promedio"
	FROM agencia_personal.contratos CON
    GROUP BY CON.cuit
    ;
#SELECT * FROM tt_sueldos_promedio_por_empresa;

SELECT 
	CON.cuit "CUIT"
    ,PER.dni "D.N.I"
    ,CON.sueldo "Sueldo"
    ,SPE.sueldo_promedio "Sueldo Promedio"
	FROM agencia_personal.contratos CON
		JOIN agencia_personal.personas PER
			ON CON.dni = PER.dni
		JOIN tt_sueldos_promedio_por_empresa SPE
			ON SPE.cuit = CON.cuit
		WHERE CON.sueldo > SPE.sueldo_promedio
;

DROP TEMPORARY TABLE tt_sueldos_promedio_por_empresa;