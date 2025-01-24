--PROCEDIMIENTOS: Insertar Turno

USE ExamenIntegrador

GO

CREATE PROCEDURE InsertarTurno
	@fechaTurno date,
	@idEstado smallint,
	@DNI_Paciente char(10),
	@DNI_Medico char(10),
	@observacion varchar(1000) = 'Sin Observaciones'

AS
BEGIN
	
	--Se verifica si el médico introducido existe
	IF EXISTS (SELECT 1 FROM Medico WHERE DNI = @DNI_Medico)
	BEGIN
		
		--De ser así, se verifica si el paciente introducido existe
		IF EXISTS (SELECT 1 FROM Paciente WHERE DNI = @DNI_Paciente)
		BEGIN

			--Si se cumplen ambas condiciones, se insertan los datos
			--en las tablas pertinentes
			INSERT INTO Turno (fechaTurno, idEstado, observacion)
			VALUES (@fechaTurno, @idEstado, @observacion)

			INSERT INTO TurnoPaciente (idTurno, idPaciente, idMedico)
			VALUES (@@IDENTITY, (SELECT idPaciente FROM Paciente WHERE @DNI_Paciente = Paciente.DNI), (SELECT idMedico FROM Medico WHERE @DNI_Medico = Medico.DNI))

			PRINT 'TURNO AÑADIDO EXITOSAMENTE'

		END

		ELSE
			--Si el paciente no existe, se muestra una advertencia
			PRINT 'NO SE ENCONTRÓ AL PACIENTE'

	END

	ELSE
		--Si el médico no existe, se muestra una advertencia
		PRINT 'NO SE ENCONTRÓ AL MÉDICO'

END

--EXEC InsertarTurno '2025-02-06', 0, '50200139', '39312094', 'Sin Observaciones'
