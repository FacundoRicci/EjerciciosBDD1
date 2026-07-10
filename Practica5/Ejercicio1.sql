# 1 )¿Qué personas fueron contratadas por las mismas empresas que Stefanía Lopez?
SELECT DISTINCT PER.dni, PER.nombre, PER.apellido
	FROM `agencia_personal`.`contratos` CON 
    JOIN `agencia_personal`.`personas` PER 
		ON CON.dni=PER.dni
	WHERE nombre NOT LIKE "Stefan_a" and apellido <> "Lopez"
		and 
			CON.cuit IN
				(SELECT 
					cuit
					FROM `agencia_personal`.`contratos` CON JOIN
						`agencia_personal`.`personas` PER ON CON.dni=PER.dni
					WHERE nombre LIKE "Stefan_a" and apellido = "Lopez")
;