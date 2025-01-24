--PROCEDIMIENTOS: Consultar Historial de un Paciente

USE ExamenIntegrador

GO

CREATE PROCEDURE ConsultarHistorial
	@DNI_Paciente char(10)

AS
BEGIN
	
	--Se verifica si el paciente buscado existe
	IF EXISTS (SELECT 1 FROM Paciente P
				INNER JOIN HistoriaPaciente HP
				ON HP.idPaciente = P.idPaciente
				INNER JOIN Historia H
				ON H.idHistoria = HP.idHistoria
				INNER JOIN MedicoEspecialidad ME
				ON ME.idMedico = HP.idMedico
				INNER JOIN Medico M
				ON M.idMedico = ME.idMedico
				WHERE P.DNI = @DNI_Paciente)
		BEGIN

			--De ser así, se muestran los datos clave de la historia del paciente
			SELECT P.idPaciente, P.DNI, P.nombre, P.apellido, P.observacion, HP.idHistoria, H.fechaHistoria, H.observacion, M.idMedico, M.nombre, M.apellido FROM Paciente P
			INNER JOIN HistoriaPaciente HP
			ON HP.idPaciente = P.idPaciente
			INNER JOIN Historia H
			ON H.idHistoria = HP.idHistoria
			INNER JOIN MedicoEspecialidad ME
			ON ME.idMedico = HP.idMedico
			INNER JOIN Medico M
			ON M.idMedico = ME.idMedico
			WHERE P.DNI = @DNI_Paciente

		END

	ELSE
		--De lo contrario, se muestra una advertencia
		PRINT 'NO SE ENCONTRÓ LA HISTORIA DEL PACIENTE'
END

--EXEC ConsultarHistorial '46285108'
