USE universidad;

CREATE VIEW informacion_relevante AS
	SELECT e.nombre AS "Nombre Estudiante"
		   ,e.documento AS "Documento Estudiante"
           ,m.nombre_materia AS "Nombre Materia"
           ,m.horario AS "Horario Materia"
           ,p.nombre AS "Nombre Profesor"
           ,i.estado AS "Estado Inscripcion"
	FROM inscripciones i
		INNER JOIN estudiantes e 
			ON e.documento = i.doc_estudiante
        INNER JOIN materias m
			ON i.cod_materia = m.codigo_materia
		INNER JOIN profesores p
			ON m.doc_profesor = p.documento;
            
SELECT * FROM informacion_relevante;	