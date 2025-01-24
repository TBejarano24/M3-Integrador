--PROCEDIMIENTOS: Insertar Paciente

USE ExamenIntegrador

GO

CREATE PROCEDURE InsertarPaciente
	@DNI char(10),
	@nombre varchar(50),
	@apellido varchar(50),
	@direccion varchar(70),
	@telefono varchar(20),
	@email varchar(30),
	@fNacimiento date,
	@observacion varchar(1000) = ''

AS
BEGIN
	
	--Se verifica si el paciente que se quiere insertar ya existe
	IF NOT EXISTS (SELECT 1 FROM Paciente WHERE DNI = @DNI)
	BEGIN
		
		--De no ser así, se introducen los datos
		INSERT INTO Paciente (DNI, nombre, apellido, direccion, telefono, email, fNacimiento, observacion)
		VALUES (@DNI, @nombre, @apellido, @direccion, @telefono, @email, @fNacimiento, @observacion)

		PRINT 'PACIENTE AÑADIDO EXITOSAMENTE'

	END

	ELSE
		--Si el paciente ya existe, se muestra una advertencia
		PRINT 'EL PACIENTE YA EXISTE'

END

--EXEC InsertarPaciente '37399852', 'Silvia', 'Suarez', 'Calle 12 1478', '45129800', 'silvia.suarez@gmail.com', '1972-06-22', 'Sin Observaciones'
