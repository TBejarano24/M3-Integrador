--PROCEDIMIENTOS: Actualizar los Datos de un Paciente

--NOTA: Los valores de todos los parámetros están puestos por defecto en NULL
--de modo que si no se desea actualizar algún campo, este permanece tal como estaba

USE ExamenIntegrador

GO

CREATE PROCEDURE UPD_Paciente
	@DNI_Paciente char(10),
	@nuevoDNI char(10) = NULL,
	@nombre varchar(50) = NULL,
	@apellido varchar(50) = NULL,
	@direccion varchar(70) = NULL,
	@telefono varchar(20) = NULL,
	@email varchar(30) = NULL,
	@fNacimiento date = NULL,
	@observacion varchar(1000) = NULL

AS
BEGIN
	
	--Se verifica si el paciente introducido existe
	IF EXISTS (SELECT 1 FROM Paciente WHERE DNI = @DNI_Paciente)
	BEGIN

		--ACTUALIZAR NOMBRE
		IF @nombre IS NOT NULL
		BEGIN
			UPDATE Paciente SET nombre = @nombre WHERE DNI = @DNI_Paciente
			PRINT 'NOMBRE ACTUALIZADO'
		END

		ELSE
			PRINT 'NOMBRE NO ACTUALIZADO'

		--ACTUALIZAR APELLIDO
		IF @apellido IS NOT NULL
		BEGIN
			UPDATE Paciente SET apellido = @apellido WHERE DNI = @DNI_Paciente
			PRINT 'APELLIDO ACTUALIZADO'
		END

		ELSE
			PRINT 'APELLIDO NO ACTUALIZADO'

		--ACTUALIZAR DIRECCION
		IF @direccion IS NOT NULL
		BEGIN
			UPDATE Paciente SET direccion = @direccion WHERE DNI = @DNI_Paciente
			PRINT 'DIRECCION ACTUALIZADA'
		END

		ELSE
			PRINT 'DIRECCION NO ACTUALIZADA'

		--ACTUALIZAR TELEFONO
		IF @telefono IS NOT NULL
		BEGIN
			UPDATE Paciente SET telefono = @telefono WHERE DNI = @DNI_Paciente
			PRINT 'TELEFONO ACTUALIZADO'
		END

		ELSE
			PRINT 'TELEFONO NO ACTUALIZADO'

		--ACTUALIZAR EMAIL
		IF @email IS NOT NULL
		BEGIN
			UPDATE Paciente SET email = @email WHERE DNI = @DNI_Paciente
			PRINT 'EMAIL ACTUALIZADO'
		END

		ELSE
			PRINT 'EMAIL NO ACTUALIZADO'

		--ACTUALIZAR FECHA DE NACIMIENTO
		IF @fNacimiento IS NOT NULL
		BEGIN
			UPDATE Paciente SET fNacimiento = @fNacimiento WHERE DNI = @DNI_Paciente
			PRINT 'FECHA DE NACIMIENTO ACTUALIZADA'
		END

		ELSE
			PRINT 'FECHA DE NACIMIENTO NO ACTUALIZADA'

		--ACTUALIZAR OBSERVACION
		IF @observacion IS NOT NULL
		BEGIN
			UPDATE Paciente SET observacion = @observacion WHERE DNI = @DNI_Paciente
			PRINT 'OBSERVACION ACTUALIZADA'
		END

		ELSE
			PRINT 'OBSERVACION NO ACTUALIZADA'

		--ACTUALIZAR DNI
		IF @nuevoDNI IS NOT NULL
		BEGIN
			UPDATE Paciente SET DNI = @nuevoDNI WHERE DNI = @DNI_Paciente
			PRINT 'DNI ACTUALIZADO'
		END

		ELSE
			PRINT 'DNI NO ACTUALIZADO'

	END

	ELSE
		--Si el paciente no existe, se muestra una advertencia
		PRINT 'NO SE ENCONTRÓ AL PACIENTE'

END

/*
NOTA: Para ejecutar apropiadamente el procedimiento se deben especificar los parámetros junto a sus valores
correspondientes, de lo contrario los valores serán asignados a los parámetros en el orden en que fueron
especificados al crear el procedimiento

EXEC UPD_Paciente @DNI_Paciente = '46285108', @nuevoDNI = '46285100', @apellido = 'Marquez', @direccion = 'Calle 12 1458'
*/
