# M3-Integrador
Examen integrador del módulo 3 sobre SQL

### INTRODUCCIÓN:

Este repositorio contiene todos los archivos de SQL diseñados para el examen integrador\
del módulo 3 de la plataforma de Canvas, por lo que al ejecutarlos se puede crear\
una base de datos destinada a la gestión básica de una clínica médica, con tablas, relaciones\
entre las mismas, datos de ejemplo, consultas y procedimientos definidos por el usuario.

**(Todos los elementos dentro de este repositorio fueron diseñados y puestos a prueba en\
SQL Server Management Studio version 19.3)**

### BREVE EXPLICACIÓN:

El script para crear la base de datos junto a todos sus elementos está separado en varios querys\
con la finalidad de evitar conflictos entre sus diversas partes y para una mejor organización\
y legibilidad. Para un desempeño óptimo los querys han de ejecutarse en el siguiente orden:

1- Database.sql (Crea la base de datos)\
2- Tablas.sql (Crea todas las tablas y sus relaciones)\
3- Archivos que empiezan en PRCD (Son los archivos con los procedimientos definidos por el\
usario. El orden en que se ejecuten no importan)\
4- Consultas.sql (Es el archivo que contiene todas las consultas solicitadas)*

***Antes de ejecutar las consultas, sin embargo, se deben insertar datos en las tablas, los**\
**cuales están incluidos en el archivo Tablas.sql y más adelante en este archivo README.**

En cuanto a la estructura de la base de datos, esta cuenta con las tablas mínimas requeridas\
(Paciente, Medico, Turno, Historia, Pago) asi como con tablas extra destinadas a manejar las\
relaciones entre tablas apropiadamente (TurnoPaciente, HistoriaPaciente, PagoPaciente, Especialidad,\
MedicoEspecialidad, Concepto, TurnoEstado). En el query encargado de crear las tablas también\
se incluye la creación de diversas restricciones como claves primarias, claves foráneas, etc.\
para facilitar el acceso a los datos y preservar la integridad de los mismos.

Respecto a los procedimientos, el funcionamiento de los mismos se explica en comentarios\
dentro de los archivos, por lo que aquí simplemente se ofrece una explicación general:

Los procedimientos creados permiten al usuario:\
1- Ver la historía clínica de un paciente\
2- Añadir los datos de un médico\
3- Añadir los datos de un paciente\
4- Agendar un turno\
5- Realizar un pago\
6- Actualizar los datos de un paciente\
Todos estos procedimientos comparten un estructura similar que, en líneas generales, consiste\
en una o múltiples estructuras condicionales encargadas de evaluar si los datos ingresados por\
el usuario son válidos, y en caso de serlo, realizar la consulta apropiada (SELECT en caso de\
tener que mostrar datos, INSERT en caso de tener que añadir datos y UPDATE en caso de tener que\
actualizar datos).

### EJEMPLOS DE USO PARA LOS PROCEDIMIENTOS:

A continuación se muestran ejemplos de uso para cada uno de los procedimientos:

1- Consultar Historia del Paciente:\
`EXEC ConsultarHistorial '46285108'`

2- Añadir Datos de un Médico:\
`EXEC InsertarMedico '58930410', 'Ezequiel', 'Gutierrez', 4, 'Sin Observaciones'`

3- Añadir Datos de un Paciente:\
`EXEC InsertarPaciente '37399852', 'Silvia', 'Suarez', 'Calle 12 1478', '45129800', 'silvia.suarez@gmail.com', '1972-06-22', 'Sin Observaciones'`

4- Agendar un Turno:\
`EXEC InsertarTurno '2025-02-06', 0, '50200139', '39312094', 'Sin Observaciones'`

5- Realizar un Pago:\
`EXEC RealizarPago 1, 20000, '2025-01-07', '50200139', 2, 'Sin Observaciones'`

6- Actualizar Datos de un Paciente:\
**NOTA: Para ejecutar apropiadamente el procedimiento se deben especificar los parámetros junto a sus valores**\
**correspondientes, de lo contrario los valores serán asignados a los parámetros en el orden en que fueron**\
**especificados al crear el procedimiento**

`EXEC UPD_Paciente @DNI_Paciente = '46285108', @nuevoDNI = '46285100', @apellido = 'Marquez', @direccion = 'Calle 12 1458'`

### EJEMPLOS DE USO PARA LAS CONSULTAS:

A continuación se muestran ejemplos de uso para las consultas:

Turnos de un Paciente en un Rango de Fechas:\
`WHERE P.DNI = '46285108' AND T.fechaTurno BETWEEN '2024-12-01' AND '2025-01-07'`

Calcular el Total de Pagos Realizados por un Paciente:\
`WHERE P.DNI = '38105211'`

Obtener la Especialidad de un Médico Específico:\
`WHERE M.DNI = '37816750'`

Listar Pacientes que aún no han Pagado sus Turnos:\
`WHERE PP.idPago IS NULL`

### VALORES DE EJEMPLO PARA LAS TABLAS:

A continuación se muestran los comandos para insertar datos de ejemplo en las tablas, los\
cuales serán útiles para comprobar la funcionalidad de los procedimientos y las consultas\
**(Estos comandos también se encuentran en el archivo Tablas.sql)**\
**(Se recomienda ejecutar los comandos en orden para evitar conflictos con las restricciones)**

1- VALORES DE EJEMPLO (Paciente):

`INSERT INTO Paciente (DNI, nombre, apellido, direccion, telefono, email, fNacimiento, observacion)
VALUES ('46285108', 'Jorge', 'Mendoza', 'Calle 13 2163', '1145303381', 'jorge.mendoza@gmail.com', '1995-07-10', '')`\
`INSERT INTO Paciente (DNI, nombre, apellido, direccion, telefono, email, fNacimiento, observacion)
VALUES ('38105211', 'Rodrigo', 'Esquivel', 'Calle 20 1882', '22401333', 'rodrigo.esquivel@gmail.com', '2005-06-30', '')`\
`INSERT INTO Paciente (DNI, nombre, apellido, direccion, telefono, email, fNacimiento, observacion)
VALUES ('50200139', 'Karina', 'Mendez', 'Calle 128 1095', '1140903881', 'karina.mendez@gmail.com', '1974-09-21', '')`

2- VALORES DE EJEMPLO (Especialidad):

`INSERT INTO Especialidad (especialidad) VALUES ('Neurología')`\
`INSERT INTO Especialidad (especialidad) VALUES ('Cardiología')`\
`INSERT INTO Especialidad (especialidad) VALUES ('Hematología')`\
`INSERT INTO Especialidad (especialidad) VALUES ('Dermatología')`\
`INSERT INTO Especialidad (especialidad) VALUES ('Gastroenterología')`\
`INSERT INTO Especialidad (especialidad) VALUES ('Ginecología')`

3- VALORES DE EJEMPLO (Medico):

`INSERT INTO Medico (DNI, nombre, apellido)
VALUES ('37816750', 'Patricia', 'Fernandez')`\
`INSERT INTO Medico (DNI, nombre, apellido)
VALUES ('41820319', 'Fernando', 'Mercado')`\
`INSERT INTO Medico (DNI, nombre, apellido)
VALUES ('39312094', 'Carlos', 'García')`

4- VALORES DE EJEMPLO (MedicoEspecialidad):

`INSERT INTO MedicoEspecialidad (idMedico, idEspecialidad, descripcion)
VALUES (1, 6, '')`\
`INSERT INTO MedicoEspecialidad (idMedico, idEspecialidad, descripcion)
VALUES (2, 1, '')`\
`INSERT INTO MedicoEspecialidad (idMedico, idEspecialidad, descripcion)
VALUES (3, 4, '')`

5- VALORES DE EJEMPLO (TurnoEstado):

`INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (0, 'Pendiente')`\
`INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (1, 'Realizado')`\
`INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (2, 'Cancelado')`\
`INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (3, 'Rechazado')`\
`INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (4, 'Postergado')`\
`INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (5, 'Anulado')`\
`INSERT INTO TurnoEstado (idEstado, Descripcion)
VALUES (6, 'Derivado')`

6- VALORES DE EJEMPLO (Turno):

`INSERT INTO Turno (fechaTurno, idEstado, observacion)
VALUES ('2024-12-11', 0, '')`\
`INSERT INTO Turno (fechaTurno, idEstado, observacion)
VALUES ('2024-12-20', 4, '')`\
`INSERT INTO Turno (fechaTurno, idEstado, observacion)
VALUES ('2025-01-02', 1, '')`

7- VALORES DE EJEMPLO (TurnoPaciente):

`INSERT INTO TurnoPaciente (idTurno, idPaciente, idMedico)
VALUES (1, 3, 3)`\
`INSERT INTO TurnoPaciente (idTurno, idPaciente, idMedico)
VALUES (2, 2, 1)`\
`INSERT INTO TurnoPaciente (idTurno, idPaciente, idMedico)
VALUES (3, 1, 2)`

8- VALORES DE EJEMPLO (Concepto):

`INSERT INTO Concepto (idConcepto, Descripcion)
VALUES (0, 'Consulta Neurología')`\
`INSERT INTO Concepto (idConcepto, Descripcion)
VALUES (1, 'Consulta Cardiología')`\
`INSERT INTO Concepto (idConcepto, Descripcion)
VALUES (2, 'Consulta Dermatología')`\
`INSERT INTO Concepto (idConcepto, Descripcion)
VALUES (3, 'Consulta Ginecología')`\
`INSERT INTO Concepto (idConcepto, Descripcion)
VALUES (4, 'Prácticas de Laboratorio')`\
`INSERT INTO Concepto (idConcepto, Descripcion)
VALUES (5, 'Prácticas Avanzadas')`

9- VALORES DE EJEMPLO (Pago):

`INSERT INTO Pago (idConcepto, fecha, monto, observacion)
VALUES (2, '2024-12-11', 6000, '')`

10- VALORES DE EJEMPLO (PagoPaciente):

`INSERT INTO PagoPaciente (idPago, idPaciente, idTurno)
VALUES (1, 2, 1)`

11- VALORES DE EJEMPLO (Historia)

`INSERT INTO Historia (fechaHistoria, observacion)
VALUES ('2025-01-05', '')`

12- VALORES DE EJEMPLO (HistoriaPaciente)

`INSERT INTO HistoriaPaciente (idHistoria, idPaciente, idMedico)
VALUES (1, 2, 2)`
