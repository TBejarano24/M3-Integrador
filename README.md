# M3-Integrador
Examen integrador del módulo 3 sobre SQL

INTRODUCCIÓN:

Este repositorio contiene todos los archivos de SQL diseñados para el examen integrador
del módulo 3 de la plataforma de Canvas, por lo que al ejecutarlos se puede crear
una base de datos destinada a la gestión básica de una clínica médica, con tablas, relaciones
entre las mismas, datos de ejemplo, consultas y procedimientos definidos por el usuario.

(Todos los elementos dentro de este repositorio fueron diseñados y puestos a prueba en
SQL Server Management Studio 2019)

BREVE EXPLICACIÓN:

El script para crear la base de datos junto a todos sus elementos está separado en varios querys
con la finalidad de evitar conflictos entre sus diversas partes y para una mejor organización
y legibilidad. Para un desempeño óptimo los querys han de ejecutarse en el siguiente orden:

1- Database.sql (Crea la base de datos)
2- Tablas.sql (Crea todas las tablas y sus relaciones)
3- Archivos que empiezan en PRCD (Son los archivos con los procedimientos definidos por el
usario. El orden en que se ejecuten no importan)
4- Consultas.sql (Es el archivo que contiene todas las consultas solicitadas)*

*Antes de ejecutar las consultas, sin embargo, se deben insertar datos en las tablas, los
cuales están incluidos en el archivo Tablas.sql y más adelante en este archivo README.

En cuanto a la estructura de la base de datos, esta cuenta con las tablas mínimas requeridas
(Paciente, Medico, Turno, Historia, Pago) asi como con tablas extra destinadas a manejar las
relaciones entre tablas apropiadamente (TurnoPaciente, HistoriaPaciente, PagoPaciente, Especialidad,
MedicoEspecialidad, Concepto, TurnoEstado). En el query encargado de crear las tablas también
se incluye la creación de diversas restricciones como claves primarias, claves foráneas, etc.
para facilitar el acceso a los datos y preservar la integridad de los mismos.

Respecto a los procedimientos, el funcionamiento de los mismos se explica en comentarios
dentro de los archivos, por lo que aquí simplemente se ofrece una explicación general:

Los procedimientos creados permiten al usuario:
1- Ver la historía clínica de un paciente
2- Añadir los datos de un médico
3- Añadir los datos de un paciente
4- Agendar un turno
5- Realizar un pago
6- Actualizar los datos de un paciente
Todos estos procedimientos comparten un estructura similar que, en líneas generales, consiste
en una o múltiples estructuras condicionales encargadas de evaluar si los datos ingresados por
el usuario son válidos, y en caso de serlo, realizar la consulta apropiada (SELECT en caso de
tener que mostrar datos, INSERT en caso de tener que añadir datos y UPDATE en caso de tener que
actualizar datos).

EJEMPLOS DE USO PARA LOS PROCEDIMIENTOS:

A continuación se muestran ejemplos de uso para cada uno de los procedimientos:

1- Consultar Historia del Paciente:
EXEC ConsultarHistorial '46285108'

2- Añadir Datos de un Médico:
EXEC InsertarMedico '58930410', 'Ezequiel', 'Gutierrez', 4

3- Añadir Datos de un Paciente:
EXEC InsertarPaciente '37399852', 'Silvia', 'Suarez', 'Calle 12 1478', '45129800', 'silvia.suarez@gmail.com', '1972-06-22'

4- Agendar un Turno:
EXEC InsertarTurno '2025-02-06', 0, '50200139', '39312094'

5- Realizar un Pago:
EXEC RealizarPago 1, 20000, '2025-01-07', '50200139', 2

6- Actualizar Datos de un Paciente:
EXEC UPD_Paciente @DNI_Paciente = '46285108', @nuevoDNI = '46285100', @apellido = 'Marquez', @direccion = 'Calle 12 1458'

EJEMPLOS DE USO PARA LAS CONSULTAS:

A continuación se muestran ejemplos de uso para las consultas:

Turnos de un Paciente en un Rango de Fechas:
WHERE P.DNI = '46285108' AND T.fechaTurno BETWEEN '2024-12-01' AND '2025-01-07'

Calcular el Total de Pagos Realizados por un Paciente:
WHERE P.DNI = '38105211'

Obtener la Especialidad de un Médico Específico:
WHERE M.DNI = '37816750'

Listar Pacientes que aún no han Pagado sus Turnos:
WHERE PP.idPago IS NULL
