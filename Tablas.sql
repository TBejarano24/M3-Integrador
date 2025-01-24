/*
En este query se crean todas las tablas
con sus respectivas columnas, propiedades
y relaciones
*/

USE ExamenIntegrador

GO

--TABLAS: Paciente

CREATE TABLE Paciente (
	idPaciente int PRIMARY KEY IDENTITY(1,1),
	DNI char(10) NOT NULL,
	nombre varchar(50) NOT NULL,
	apellido varchar(50) NOT NULL,
	direccion varchar(70),
	telefono varchar(20) NOT NULL,
	email varchar(30) NOT NULL,
	fNacimiento date,
	observacion varchar(1000)
	)

/*
VALORES DE EJEMPLO (Paciente):

INSERT INTO Paciente (DNI, nombre, apellido, direccion, telefono, email, fNacimiento, observacion)
VALUES ('46285108', 'Jorge', 'Mendoza', 'Calle 13 2163', '1145303381', 'jorge.mendoza@gmail.com', '1995-07-10', '')

INSERT INTO Paciente (DNI, nombre, apellido, direccion, telefono, email, fNacimiento, observacion)
VALUES ('38105211', 'Rodrigo', 'Esquivel', 'Calle 20 1882', '22401333', 'rodrigo.esquivel@gmail.com', '2005-06-30', '')

INSERT INTO Paciente (DNI, nombre, apellido, direccion, telefono, email, fNacimiento, observacion)
VALUES ('50200139', 'Karina', 'Mendez', 'Calle 128 1095', '1140903881', 'karina.mendez@gmail.com', '1974-09-21', '')
*/

--TABLAS: Especialidad

CREATE TABLE Especialidad (
	idEspecialidad int PRIMARY KEY IDENTITY(1,1),
	especialidad varchar(30) NOT NULL
	)

/*
VALORES DE EJEMPLO (Especialidad):

INSERT INTO Especialidad (especialidad) VALUES ('Neurología')
INSERT INTO Especialidad (especialidad) VALUES ('Cardiología')
INSERT INTO Especialidad (especialidad) VALUES ('Hematología')
INSERT INTO Especialidad (especialidad) VALUES ('Dermatología')
INSERT INTO Especialidad (especialidad) VALUES ('Gastroenterología')
INSERT INTO Especialidad (especialidad) VALUES ('Ginecología')

*/

--TABLAS: Medico

CREATE TABLE Medico (
	idMedico int PRIMARY KEY IDENTITY(1,1),
	DNI char(10) NOT NULL,
	nombre varchar(50) NOT NULL,
	apellido varchar(50) NOT NULL
	)

/*
VALORES DE EJEMPLO (Medico):

INSERT INTO Medico (DNI, nombre, apellido)
VALUES ('37816750', 'Patricia', 'Fernandez')

INSERT INTO Medico (DNI, nombre, apellido)
VALUES ('41820319', 'Fernando', 'Mercado')

INSERT INTO Medico (DNI, nombre, apellido)
VALUES ('39312094', 'Carlos', 'García')

*/

--TABLAS: MedicoEspecialidad

CREATE TABLE MedicoEspecialidad (
	idMedico int,
	idEspecialidad int,
	descripcion varchar(50)
	CONSTRAINT PK_idEspecialidad PRIMARY KEY CLUSTERED(
	idMedico, idEspecialidad
	)
	CONSTRAINT FK_MedicoEspecialidad_Medico FOREIGN KEY (idMedico)
		REFERENCES Medico (idMedico)

	ON DELETE CASCADE
	ON UPDATE CASCADE
	)

ALTER TABLE MedicoEspecialidad ADD CONSTRAINT FK_MedicoEspecialidad_Especialidad FOREIGN KEY (idEspecialidad)
	REFERENCES Especialidad (idEspecialidad)

GO

/*
VALORES DE EJEMPLO (MedicoEspecialidad):

INSERT INTO MedicoEspecialidad (idMedico, idEspecialidad, descripcion)
VALUES (1, 6, '')

INSERT INTO MedicoEspecialidad (idMedico, idEspecialidad, descripcion)
VALUES (2, 1, '')

INSERT INTO MedicoEspecialidad (idMedico, idEspecialidad, descripcion)
VALUES (3, 4, '')

*/

--TABLAS: TurnoEstado

CREATE TABLE TurnoEstado (
	idEstado smallint PRIMARY KEY,
	Descripcion varchar(50) NOT NULL
	)

/*
VALORES DE EJEMPLO (TurnoEstado):

INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (0, 'Pendiente')

INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (1, 'Realizado')

INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (2, 'Cancelado')

INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (3, 'Rechazado')

INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (4, 'Postergado')

INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (5, 'Anulado')

INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (6, 'Derivado')

*/

--TABLAS: Turno

CREATE TABLE Turno (
	idTurno int PRIMARY KEY IDENTITY(1,1),
	fechaTurno date NOT NULL,
	idEstado smallint NOT NULL,
	observacion varchar(1000)

	CONSTRAINT FK_Turno_TurnoEstado FOREIGN KEY (idEstado)
		REFERENCES TurnoEstado (idEstado)
	)

/*
VALORES DE EJEMPLO (Turno):

INSERT INTO Turno (fechaTurno, idEstado, observacion)
VALUES ('2024-12-11', 0, '')

INSERT INTO Turno (fechaTurno, idEstado, observacion)
VALUES ('2024-12-20', 4, '')

INSERT INTO Turno (fechaTurno, idEstado, observacion)
VALUES ('2025-01-02', 1, '')

*/
	
--TABLAS: TurnoPaciente

CREATE TABLE TurnoPaciente (
	idTurno int,
	idPaciente int,
	idMedico int
	CONSTRAINT PK_idTurno PRIMARY KEY CLUSTERED (idTurno, idPaciente, idMedico)
	CONSTRAINT FK_TurnoPaciente_Turno FOREIGN KEY (idTurno)
		REFERENCES Turno (idTurno)

	ON DELETE CASCADE
	ON UPDATE CASCADE
	)

ALTER TABLE TurnoPaciente ADD CONSTRAINT FK_TurnoPaciente_Paciente FOREIGN KEY (idPaciente)
	REFERENCES Paciente (idPaciente)

	ON DELETE CASCADE
	ON UPDATE CASCADE

GO

ALTER TABLE TurnoPaciente ADD CONSTRAINT FK_TurnoPaciente_Medico FOREIGN KEY (idMedico)
	REFERENCES Medico (idMedico)

	ON DELETE CASCADE
	ON UPDATE CASCADE

GO

/*
VALORES DE EJEMPLO (TurnoPaciente):

INSERT INTO TurnoPaciente (idTurno, idPaciente, idMedico)
VALUES (1, 3, 3)

INSERT INTO TurnoPaciente (idTurno, idPaciente, idMedico)
VALUES (2, 2, 1)

INSERT INTO TurnoPaciente (idTurno, idPaciente, idMedico)
VALUES (3, 1, 2)

*/

--TABLAS: Concepto

CREATE TABLE Concepto (
	idConcepto smallint PRIMARY KEY,
	Descripcion varchar(50) NOT NULL
	)

/*
VALORES DE EJEMPLO (Concepto):

INSERT INTO Concepto (idConcepto, Descripcion)
VALUES (0, 'Consulta Neurología')

INSERT INTO Concepto (idConcepto, Descripcion)
VALUES (1, 'Consulta Cardiología')

INSERT INTO Concepto (idConcepto, Descripcion)
VALUES (2, 'Consulta Dermatología')

INSERT INTO Concepto (idConcepto, Descripcion)
VALUES (3, 'Consulta Ginecología')

INSERT INTO Concepto (idConcepto, Descripcion)
VALUES (4, 'Prácticas de Laboratorio')

INSERT INTO Concepto (idConcepto, Descripcion)
VALUES (5, 'Prácticas Avanzadas')

*/

--TABLAS: Pago

CREATE TABLE Pago (
	idPago int PRIMARY KEY IDENTITY(1,1),
	idConcepto smallint NOT NULL,
	fecha date NOT NULL,
	monto money NOT NULL,
	observacion varchar(1000)
	CONSTRAINT FK_Pagos_Concepto FOREIGN KEY (idConcepto)
		REFERENCES Concepto (idConcepto)
	)

/*
VALORES DE EJEMPLO (Pago):

INSERT INTO Pago (idConcepto, fecha, monto, observacion)
VALUES (2, '2024-12-11', 6000, '')

*/

--TABLAS: PagoPaciente

CREATE TABLE PagoPaciente (
	idPago int,
	idPaciente int,
	idTurno int
	CONSTRAINT PK_idPago PRIMARY KEY CLUSTERED (idPago, idPaciente, idTurno)
	CONSTRAINT FK_idPago FOREIGN KEY (idPago)
		REFERENCES Pago (idPago)

	ON DELETE CASCADE
	ON UPDATE CASCADE
	)

ALTER TABLE PagoPaciente ADD CONSTRAINT FK_PagoPaciente_Paciente FOREIGN KEY (idPaciente)
	REFERENCES Paciente (idPaciente)

	ON DELETE CASCADE
	ON UPDATE CASCADE

GO

ALTER TABLE PagoPaciente ADD CONSTRAINT FK_PagoPaciente_Turno FOREIGN KEY(idTurno)
	REFERENCES Turno (idTurno)

	ON DELETE CASCADE
	ON UPDATE CASCADE

GO

/*
VALORES DE EJEMPLO (PagoPaciente):

INSERT INTO PagoPaciente (idPago, idPaciente, idTurno)
VALUES (1, 2, 1)

*/

--TABLAS: Historia

CREATE TABLE Historia (
	idHistoria int PRIMARY KEY IDENTITY(1,1),
	fechaHistoria date NOT NULL,
	observacion varchar(1000)
	)

/*
VALORES DE EJEMPLO (Historia)

INSERT INTO Historia (fechaHistoria, observacion)
VALUES ('2025-01-05', '')
*/

--TABLAS: HistoriaPaciente

CREATE TABLE HistoriaPaciente (
	idHistoria int,
	idPaciente int,
	idMedico int
	CONSTRAINT PK_idHistoria PRIMARY KEY CLUSTERED (idHistoria, idPaciente, idMedico)
	CONSTRAINT FK_HistoriaPaciente_Historia FOREIGN KEY (idHistoria)
		REFERENCES Historia (idHistoria)
	)

ALTER TABLE HistoriaPaciente ADD CONSTRAINT FK_HistoriaPaciente_Paciente FOREIGN KEY (idPaciente)
	REFERENCES Paciente (idPaciente)

	ON DELETE CASCADE
	ON UPDATE CASCADE

GO

ALTER TABLE HistoriaPaciente ADD CONSTRAINT FK_HistoriaPaciente_Medico FOREIGN KEY (idMedico)
	REFERENCES Medico (idMedico)

	ON DELETE CASCADE
	ON UPDATE CASCADE

GO

/*
VALORES DE EJEMPLO (HistoriaPaciente)

INSERT INTO HistoriaPaciente (idHistoria, idPaciente, idMedico)
VALUES (1, 2, 2)
*/
