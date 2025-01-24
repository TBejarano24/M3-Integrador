--NOTA: Las cláusulas WHERE contienen datos basados en los valores
--de ejemplo hallados en el archivo 'Tablas.sql', esto se hizo así
--a fin de probar la funcionalidad de las consultas

USE ExamenIntegrador

GO

--CONSULTAS: Turnos de un Paciente en un Rango de Fechas

SELECT P.idPaciente, P.DNI, P.nombre, P.apellido, T.idTurno, T.fechaTurno, T.idEstado FROM Paciente P
INNER JOIN TurnoPaciente TP
ON TP.idPaciente = P.idPaciente
INNER JOIN Turno T
ON T.idTurno = TP.idTurno
WHERE P.DNI = '46285108' AND T.fechaTurno BETWEEN '2024-12-01' AND '2025-01-07'

--CONSULTAS: Calcular el Total de Pagos Realizados por un Paciente

SELECT COUNT(PA.idPago) AS Total_Pagos FROM Paciente P
INNER JOIN PagoPaciente PP
ON PP.idPaciente = P.idPaciente
INNER JOIN Pago PA
ON PA.idPago = PP.idPago
WHERE P.DNI = '38105211'

--CONSULTAS: Obtener la Especialidad de un Médico Específico

SELECT M.idMedico, M.DNI, M.nombre, M.apellido, ME.idEspecialidad, E.Especialidad FROM Medico M
INNER JOIN MedicoEspecialidad ME
ON ME.idMedico = M.idMedico
INNER JOIN Especialidad E
ON E.idEspecialidad = ME.idEspecialidad
WHERE M.DNI = '37816750'

--CONSULTAS: Listar Pacientes que aún no han Pagado sus Turnos

SELECT P.idPaciente, P.DNI, P.nombre, P.apellido, PP.idPago FROM Paciente P
LEFT JOIN PagoPaciente PP
ON PP.idPaciente = P.idPaciente
WHERE PP.idPago IS NULL
