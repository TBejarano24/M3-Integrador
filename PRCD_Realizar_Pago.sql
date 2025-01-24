--PROCEDIMIENTOS: Realizar un Pago

USE ExamenIntegrador

GO

CREATE PROCEDURE RealizarPago
	@concepto smallint,
	@monto money,
	@fecha date,
	@DNI_Paciente char(10),
	@idTurno int,
	@observacion varchar(1000) = 'Sin Observaciones'

AS
BEGIN
	
	--Se verifica si el turno introducido existe
	IF EXISTS (SELECT 1 FROM Turno WHERE idTurno = @idTurno)
	BEGIN
		
		--De ser así, se verifica si el paciente introducido existe
		IF EXISTS (SELECT 1 FROM Paciente WHERE DNI = @DNI_Paciente)
		BEGIN
			
			--Finalmente, si ambas condiciones se cumplen, se verifica si
			--el concepto introducido existe
			IF EXISTS (SELECT 1 FROM Concepto WHERE idConcepto = @concepto)
			BEGIN
				
				--Entonces se insertan los datos sobre el pago en las tablas pertinentes
				INSERT INTO Pago (idConcepto, monto, fecha, observacion)
				VALUES (@concepto, @monto, @fecha, @observacion)

				INSERT INTO PagoPaciente (idPago, idPaciente, idTurno)
				VALUES (@@IDENTITY, (SELECT idPaciente FROM Paciente WHERE DNI = @DNI_Paciente), @idTurno)

				PRINT 'PAGO REGISTRADO EXITOSAMENTE'

			END

			ELSE
				--Si el concepto no existe, se muestra una advertencia
				PRINT'EL CONCEPTO INTRODUCIDO NO EXISTE'
		END

		ELSE
			--Si el paciente no existe, se muestra una advertencia
			PRINT'NO SE ENCONTRÓ EL PACIENTE'

	END

	ELSE
		--Si el turno no existe, se muestra una advertencia
		PRINT 'NO SE ENCONTRÓ EL TURNO'

END

--EXEC RealizarPago 1, 20000, '2025-01-07', '50200139', 2, 'Sin Observaciones'
