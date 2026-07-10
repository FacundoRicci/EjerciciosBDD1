select EMP.cuit
	,EMP.razon_social
    ,ROUND(AVG(importe_comision),2) "Comision Promedio"  
	FROM agencia_personal.comisiones COM
		JOIN agencia_personal.contratos CON 
			ON COM.nro_contrato = CON.nro_contrato
		JOIN agencia_personal.empresas EMP
			ON CON.cuit = EMP.cuit
		GROUP BY EMP.cuit
        HAVING AVG(importe_comision) > (
			SELECT AVG(importe_comision) 
				FROM agencia_personal.comisiones COM
					JOIN agencia_personal.contratos CON 
						ON COM.nro_contrato = CON.nro_contrato
					JOIN agencia_personal.empresas EMP
						ON CON.cuit = EMP.cuit
				WHERE razon_social = "Tráigame Eso")
                        