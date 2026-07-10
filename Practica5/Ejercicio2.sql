SELECT CON.dni
    , concat(nombre, " ", apellido) "Nombre y apellido"
    , sueldo  
    FROM agencia_personal.contratos CON
		JOIN agencia_personal.personas PER
			ON CON.dni = PER.dni
		WHERE CON.sueldo < 
			(SELECT MAX(CON.sueldo) FROM agencia_personal.contratos CON
				JOIN agencia_personal.empresas EMP ON CON.cuit = EMP.cuit
                WHERE EMP.razon_social = "Viejos Amigos")