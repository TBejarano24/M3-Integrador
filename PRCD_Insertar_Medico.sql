--PROCEDIMIENTOS: Insertar Medico

USE ExamenIntegrador

GO

CREATE PROCEDURE InsertarMedico
	@DNI char(10),
	@nombre varchar(50),
	@apellido varchar(50),
	@ID_especialidad int,
	@descripcion varchar(50) = ''

AS
BEGIN
	
	--Se verifica si el médico que se quiere añadir ya existe
	IF NOT EXISTS (SELECT 1 FROM Medico WHERE DNI = @DNI)
	BEGIN
		
		--De no ser así, se introducen los datos
		INSERT INTO Medico (DNI, nombre, apellido)
		VALUES (@DNI, @nombre, @apellido)

	END

	ELSE
	BEGIN
		
		--Si el médico ya existe, se muestra una advertencia
		--y se detiene el proceso
		PRINT 'EL MEDICO YA EXISTE'
		RETURN

	END

	--Si el médico se introdujo exitosamente en la tabla Medico
	--También se lo añade a la tabla MedicoEspecialidad

	--Para eso, se verifica si el médico fue, en efecto, introducido
	IF EXISTS (SELECT 1 FROM Medico WHERE DNI = @DNI)
	BEGIN
		
		--De ser así, se verifica si la especialidad introducida existe
		IF @ID_especialidad IN (SELECT idEspecialidad FROM Especialidad)
		BEGIN
			
			--Si ambas condiciones se cumplen, se introducen los datos
			INSERT INTO MedicoEspecialidad (idMedico, idEspecialidad, descripcion)
			VALUES (@@IDENTITY, @ID_especialidad, @descripcion)

			PRINT 'MEDICO AÑADIDO EXITOSAMENTE'

		END

		ELSE
			--Si la especialidad introducida no existe, se muestra una advertencia
			PRINT 'NO SE ENCONTRÓ LA ID DE ESPECIALIDAD ESPECIFICADA'

	END

	ELSE
		--Si por encima de todo el proceso falla, se muestra una advertencia que sugiere revisar los datos
		PRINT 'HUBO UN ERROR DURANTE LA INSERCIÓN, REVISE LOS VALORES DE LOS PARÁMETROS O LA TABLA MEDICO'

END

--EXEC InsertarMedico '58930410', 'Ezequiel', 'Gutierrez', 4, 'Sin Observaciones'
