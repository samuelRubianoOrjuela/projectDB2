# Proyecto Bases de Datos #1
### Consultas sobre una tabla
---

1. Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
	```sql
    SELECT apellido1, apellido2, nombre_alumno
    FROM alumno
    ORDER BY apellido1 ASC;

    +-----------+-----------+---------------+
	| apellido1 | apellido2 | nombre_alumno |
	+-----------+-----------+---------------+
	| Díaz      | Martínez  | Carlos        |
	| García    | Martínez  | Luis          |
	| García    | Martínez  | Lucía         |
	| Gómez     | Pérez     | Daniel        |
	| Hernández | García    | Laura         |
	| López     | Fernández | Ana           |
	| López     | Fernández | Javier        |
	| Martín    | Gómez     | Pablo         |
	| Martín    | Gómez     | Paula         |
	| Muñoz     | López     | María         |
	| Paniagua  | Pérez     | Andres        |
	| Ruiz      | Fernández | Alejandro     |
	| Sánchez   | Rodríguez | Elena         |
	| Sánchez   | Rodríguez | Andrea        |
	| Torres    | Sánchez   | Sara          |
	+-----------+-----------+---------------+
	```
	---
2. Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
	```sql
    SELECT apellido1, apellido2, nombre_alumno
    FROM alumno
    WHERE id_telefono IS NOT NULL;

	+-----------+-----------+---------------+
	| apellido1 | apellido2 | nombre_alumno |
	+-----------+-----------+---------------+
	| García    | Martínez  | Luis          |
	| López     | Fernández | Ana           |
	| Martín    | Gómez     | Pablo         |
	| Sánchez   | Rodríguez | Elena         |
	| Gómez     | Pérez     | Daniel        |
	| Hernández | García    | Laura         |
	| Díaz      | Martínez  | Carlos        |
	| Muñoz     | López     | María         |
	| Torres    | Sánchez   | Sara          |
	| Ruiz      | Fernández | Alejandro     |
	| García    | Martínez  | Lucía         |
	| López     | Fernández | Javier        |
	| Martín    | Gómez     | Paula         |
	| Sánchez   | Rodríguez | Andrea        |
	| Paniagua  | Pérez     | Andres        |
	+-----------+-----------+---------------+
	```
	---
3. Devuelve el listado de los alumnos que nacieron en 2000.
	```sql
    SELECT apellido1, apellido2, nombre_alumno
    FROM alumno
    WHERE YEAR(fecha_nacimiento) = 2000;

	+-----------+-----------+---------------+
	| apellido1 | apellido2 | nombre_alumno |
	+-----------+-----------+---------------+
	| García    | Martínez  | Luis          |
	| Martín    | Gómez     | Pablo         |
	| Gómez     | Pérez     | Daniel        |
	| Díaz      | Martínez  | Carlos        |
	| Torres    | Sánchez   | Sara          |
	| García    | Martínez  | Lucía         |
	| Martín    | Gómez     | Paula         |
	| Paniagua  | Pérez     | Andres        |
	+-----------+-----------+---------------+
	```
	---
4. Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.
	```sql
    SELECT apellido1, apellido2, nombre_profesor
    FROM profesor
    WHERE id_telefono IS NOT NULL 
    AND nif LIKE '%K';

	+-----------+-----------+-----------------+
	| apellido1 | apellido2 | nombre_profesor |
	+-----------+-----------+-----------------+
	| Gómez     | Fernández | Carlos          |
	| Díaz      | Martín    | Elena           |
	+-----------+-----------+-----------------+
	```
	---
5. Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
	```sql
    SELECT id_asignatura, nombre_asignatura
    FROM asignatura
    WHERE cuatrimestre = 1 
    AND curso = 3;

	+---------------+--------------------+
	| id_asignatura | nombre_asignatura  |
	+---------------+--------------------+
	|             1 | Matemáticas I      |
	|             8 | Psicología General |
	+---------------+--------------------+
	```
	---
    
### Consultas multitabla (Composición interna)
---
1. Devuelve un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática.
	```sql
    SELECT DISTINCT a.id_alumno, a.nombre_alumno, CONCAT(a.apellido1, ' ', a.apellido2) AS apellidos
    FROM alumno a
    JOIN alumno_se_matricula_asignatura aa ON a.id_alumno = aa.id_alumno
    JOIN asignatura ag ON aa.id_asignatura = ag.id_asignatura
    JOIN grado g ON ag.id_grado = g.id_grado
    WHERE a.sexo = 'M'
    AND g.nombre_grado = 'Ingeniería Informática';

	+-----------+---------------+-----------------+
	| id_alumno | nombre_alumno | apellidos       |
	+-----------+---------------+-----------------+
	|         1 | Alejandra     | García Martínez |
	|         5 | Daniela       | Gómez Pérez     |
	+-----------+---------------+-----------------+
	```
	---
2. Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática.
	```sql
    SELECT DISTINCT ag.id_asignatura, ag.nombre_asignatura
    FROM asignatura ag
    JOIN grado g ON ag.id_grado = g.id_grado
    WHERE g.nombre_grado = 'Ingeniería Informática';

    +---------------+---------------------+
	| id_asignatura | nombre_asignatura   |
	+---------------+---------------------+
	|             1 | Matemáticas I       |
	|             2 | Programación        |
	|             9 | Cálculo II          |
	|            10 | Estructura de Datos |
	|            17 | Álgebra Lineal      |
	|            18 | Bases de Datos      |
	|            25 | Estadística         |
	|            26 | Sistemas Operativos |
	+---------------+---------------------+
	```
	---
3. Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados. El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.
	```sql
    SELECT p.apellido1, p.apellido2, p.nombre_profesor, GROUP_CONCAT(d.nombre_departamento SEPARATOR ', ') AS departamentos
    FROM profesor p
    JOIN departamento d 
    GROUP BY p.apellido1, p.apellido2, p.nombre_profesor
    ORDER BY p.apellido1 ASC;

    +-----------+-----------+-----------------+-------------------------------------------------------------------------------------------------------------------------------+
	| apellido1 | apellido2 | nombre_profesor | departamentos                                                                                                                 |
	+-----------+-----------+-----------------+-------------------------------------------------------------------------------------------------------------------------------+
	| Díaz      | Martín    | Elena           | Departamento de Matemáticas, Departamento de Historia, Departamento de Ciencias de la Computación, Departamento de Literatura |
	| Fernández | Díaz      | Javier          | Departamento de Matemáticas, Departamento de Literatura, Departamento de Historia, Departamento de Ciencias de la Computación |
	| García    | Pérez     | Juan            | Departamento de Ciencias de la Computación, Departamento de Historia, Departamento de Matemáticas, Departamento de Literatura |
	| Gómez     | Fernández | Carlos          | Departamento de Matemáticas, Departamento de Historia, Departamento de Ciencias de la Computación, Departamento de Literatura |
	| Hernández | García    | David           | Departamento de Literatura, Departamento de Ciencias de la Computación, Departamento de Historia, Departamento de Matemáticas |
	| López     | Martínez  | María           | Departamento de Literatura, Departamento de Ciencias de la Computación, Departamento de Historia, Departamento de Matemáticas |
	| Martín    | Sánchez   | Ana             | Departamento de Literatura, Departamento de Matemáticas, Departamento de Historia, Departamento de Ciencias de la Computación |
	| Pérez     | López     | Laura           | Departamento de Ciencias de la Computación, Departamento de Historia, Departamento de Matemáticas, Departamento de Literatura |
	| Rodríguez | Gómez     | Pedro           | Departamento de Literatura, Departamento de Ciencias de la Computación, Departamento de Historia, Departamento de Matemáticas |
	| Ruiz      | Hernández | Sara            | Departamento de Literatura, Departamento de Ciencias de la Computación, Departamento de Historia, Departamento de Matemáticas |
	+-----------+-----------+-----------------+-------------------------------------------------------------------------------------------------------------------------------+
	```
	---
4. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con nif 23456789Y.
	```sql
    SELECT ag.nombre_asignatura, c.anyo_inicio, c.anyo_fin
    FROM alumno_se_matricula_asignatura aa
    JOIN asignatura ag ON aa.id_asignatura = ag.id_asignatura
    JOIN alumno al ON aa.id_alumno = al.id_alumno
    JOIN curso_escolar c ON aa.id_curso_escolar = c.id_curso_escolar
    WHERE al.nif = '23456789Y';

    +------------------------+-------------+----------+
	| nombre_asignatura      | anyo_inicio | anyo_fin |
	+------------------------+-------------+----------+
	| Historia Contemporánea |        2023 |     2024 |
	| Literatura Española    |        2023 |     2024 |
	+------------------------+-------------+----------+
	```
	---
5. Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Programación.
	```sql
    SELECT d.nombre_departamento
    FROM profesor p
    JOIN departamento d ON p.id_departamento = d.id_departamento
    JOIN asignatura ag ON p.id_profesor = ag.id_profesor
    WHERE ag.nombre_asignatura = 'Programación';

	+--------------------------------------------+
	| nombre_departamento                        |
	+--------------------------------------------+
	| Departamento de Ciencias de la Computación |
	+--------------------------------------------+
	```
	---
6. Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2023/2024. 
	```sql
    SELECT DISTINCT a.id_alumno, a.nombre_alumno, CONCAT(a.apellido1, ' ', a.apellido2) AS apellidos
    FROM alumno a
    JOIN alumno_se_matricula_asignatura aa ON a.id_alumno = aa.id_alumno
    JOIN curso_escolar c ON aa.id_curso_escolar = c.id_curso_escolar
    WHERE c.anyo_inicio = '2023' AND c.anyo_fin = '2024';

    +-----------+---------------+-------------------+
	| id_alumno | nombre_alumno | apellidos         |
	+-----------+---------------+-------------------+
	|         1 | Alejandra     | García Martínez   |
	|         2 | Ana           | López Fernández   |
	|         3 | Pablo         | Martín Gómez      |
	|         4 | Elena         | Sánchez Rodríguez |
	|         5 | Daniela       | Gómez Pérez       |
	|         6 | Laura         | Hernández García  |
	|         7 | Carlos        | Díaz Martínez     |
	|         8 | María         | Muñoz López       |
	+-----------+---------------+-------------------+
	```
	---
    
### Consultas multitabla (Composición externa) Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
---
1. Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.
	```sql
    SELECT d.nombre_departamento, p.apellido1, p.apellido2, p.nombre_profesor
    FROM profesor p
    LEFT JOIN departamento d ON p.id_departamento = d.id_departamento
    ORDER BY d.nombre_departamento ASC;

	+--------------------------------------------+-----------+-----------+-----------------+
	| nombre_departamento                        | apellido1 | apellido2 | nombre_profesor |
	+--------------------------------------------+-----------+-----------+-----------------+
	| NULL                                       | Gómez     | Fernández | Carlos          |
	| NULL                                       | Fernández | Díaz      | Javier          |
	| Departamento de Ciencias de la Computación | Rodríguez | Gómez     | Pedro           |
	| Departamento de Ciencias de la Computación | Hernández | García    | David           |
	| Departamento de Historia                   | López     | Martínez  | María           |
	| Departamento de Historia                   | Pérez     | López     | Laura           |
	| Departamento de Literatura                 | Martín    | Sánchez   | Ana             |
	| Departamento de Literatura                 | Díaz      | Martín    | Elena           |
	| Departamento de Matemáticas                | García    | Pérez     | Juan            |
	| Departamento de Matemáticas                | Ruiz      | Hernández | Sara            |
	+--------------------------------------------+-----------+-----------+-----------------+
	```
	---
2. Devuelve un listado con los profesores que no están asociados a un departamento.
	```sql
    SELECT d.nombre_departamento, p.apellido1, p.apellido2, p.nombre_profesor
    FROM profesor p
    LEFT JOIN departamento d ON p.id_departamento = d.id_departamento
    WHERE p.id_departamento IS NULL
    ORDER BY d.nombre_departamento ASC;

	+---------------------+-----------+-----------+-----------------+
	| nombre_departamento | apellido1 | apellido2 | nombre_profesor |
	+---------------------+-----------+-----------+-----------------+
	| NULL                | Gómez     | Fernández | Carlos          |
	| NULL                | Fernández | Díaz      | Javier          |
	+---------------------+-----------+-----------+-----------------+
	```
	---
3. Devuelve un listado con los departamentos que no tienen profesores asociados.
	```sql
    SELECT d.id_departamento, d.nombre_departamento, p.id_profesor
    FROM profesor p
    RIGHT JOIN departamento d ON p.id_departamento = d.id_departamento
    WHERE p.id_profesor IS NULL
    ORDER BY d.nombre_departamento ASC;

	+-----------------+----------------------------+-------------+
	| id_departamento | nombre_departamento        | id_profesor |
	+-----------------+----------------------------+-------------+
	|               5 | Departamento de Idiomas    |        NULL |
	|               6 | Departamento de Literatura |        NULL |
	+-----------------+----------------------------+-------------+
	```
	---
4. Devuelve un listado con los profesores que no imparten ninguna asignatura.
	```sql
    SELECT p.id_profesor, p.apellido1, p.apellido2, p.nombre_profesor, a.id_asignatura
    FROM profesor p
    LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
    WHERE a.id_asignatura IS NULL;

    +-------------+-----------+-----------+-----------------+---------------+
	| id_profesor | apellido1 | apellido2 | nombre_profesor | id_asignatura |
	+-------------+-----------+-----------+-----------------+---------------+
	|           4 | Martín    | Sánchez   | Ana             |          NULL |
	+-------------+-----------+-----------+-----------------+---------------+
	```
	---
5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.
	```sql
    SELECT a.id_asignatura, a.nombre_asignatura, p.id_profesor
    FROM profesor p
    RIGHT JOIN asignatura a ON p.id_profesor = a.id_profesor
    WHERE p.id_profesor IS NULL;

	+---------------+---------------------+-------------+
	| id_asignatura | nombre_asignatura   | id_profesor |
	+---------------+---------------------+-------------+
	|             1 | Matemáticas I       |        NULL |
	|             4 | Literatura Española |        NULL |
	|            11 | Historia del Arte   |        NULL |
	|            13 | Microeconomía       |        NULL |
	|            14 | Fisiología          |        NULL |
	+---------------+---------------------+-------------+    
	```
	---
6. Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca. Consultas resumen
	```sql
    SELECT d.id_departamento, d.nombre_departamento
    FROM departamento d
    LEFT JOIN profesor p ON d.id_departamento = p.id_departamento
    LEFT JOIN asignatura ag ON p.id_profesor = ag.id_asignatura
    LEFT JOIN alumno_se_matricula_asignatura aa ON ag.id_asignatura = aa.id_asignatura
    LEFT JOIN curso_escolar c ON aa.id_curso_escolar = c.id_curso_escolar
    WHERE c.id_curso_escolar IS NULL;

    +-----------------+----------------------------+
	| id_departamento | nombre_departamento        |
	+-----------------+----------------------------+
	|               5 | Departamento de Idiomas    |
	|               6 | Departamento de Literatura |
	+-----------------+----------------------------+
	```
	---
    
### Consultas resumen
---
1. Devuelve el número total de alumnas que hay.
	```sql
    SELECT COUNT(id_alumno) AS cant_alumnas
    FROM alumno 
    WHERE sexo = 'M';

    +--------------+
	| cant_alumnas |
	+--------------+
	|           10 |
	+--------------+
	```
	---
2. Calcula cuántos alumnos nacieron en 2000.
	```sql
    SELECT COUNT(id_alumno) AS alumnos_2000
    FROM alumno 
    WHERE YEAR(fecha_nacimiento) = 2000;

    +--------------+
	| alumnos_2000 |
	+--------------+
	|            8 |
	+--------------+
	```
	---
3. Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.
	```sql
    SELECT d.nombre_departamento, COUNT(id_profesor) AS cant_profesores
    FROM departamento d
    JOIN profesor p ON d.id_departamento = p.id_departamento
    GROUP BY d.nombre_departamento
    ORDER BY cant_profesores DESC;

    +--------------------------------------------+-----------------+
	| nombre_departamento                        | cant_profesores |
	+--------------------------------------------+-----------------+
	| Departamento de Matemáticas                |               2 |
	| Departamento de Historia                   |               2 |
	| Departamento de Ciencias de la Computación |               2 |
	| Departamento de Ciencias Naturales         |               2 |
	+--------------------------------------------+-----------------+
	```
	---
4. Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también tienen que aparecer en el listado.
	```sql
    SELECT d.nombre_departamento, COUNT(id_profesor) AS cant_profesores
    FROM departamento d
    LEFT JOIN profesor p ON d.id_departamento = p.id_departamento
    GROUP BY d.nombre_departamento
    ORDER BY cant_profesores DESC;

    +--------------------------------------------+-----------------+
	| nombre_departamento                        | cant_profesores |
	+--------------------------------------------+-----------------+
	| Departamento de Idiomas                    |               0 |
	| Departamento de Literatura                 |               0 |
	| Departamento de Matemáticas                |               2 |
	| Departamento de Historia                   |               2 |
	| Departamento de Ciencias de la Computación |               2 |
	| Departamento de Ciencias Naturales         |               2 |
	+--------------------------------------------+-----------------+
	```
	---
5. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
	```sql
    SELECT g.nombre_grado, COUNT(a.id_asignatura) AS cant_asignaturas
    FROM grado g
    LEFT JOIN asignatura a ON g.id_grado = a.id_grado
    GROUP BY g.nombre_grado
    ORDER BY cant_asignaturas DESC;

    +----------------------------+------------------+
	| nombre_grado               | cant_asignaturas |
	+----------------------------+------------------+
	| Ingeniería Informática     |                8 |
	| Administración de Empresas |                8 |
	| Medicina                   |                8 |
	| Derecho                    |                7 |
	| Psicología                 |                0 |
	+----------------------------+------------------+
	```
	---
6. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.
	```sql
    SELECT g.nombre_grado, COUNT(a.id_asignatura) AS cant_asignaturas
    FROM grado g
    LEFT JOIN asignatura a ON g.id_grado = a.id_grado
    GROUP BY g.nombre_grado
    HAVING COUNT(a.id_asignatura) > 7
    ORDER BY cant_asignaturas DESC;

    +----------------------------+------------------+
	| nombre_grado               | cant_asignaturas |
	+----------------------------+------------------+
	| Ingeniería Informática     |                8 |
	| Administración de Empresas |                8 |
	| Medicina                   |                8 |
	+----------------------------+------------------+
	```
	---
7. Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo. Ordene el resultado de mayor a menor por el número total de crédidos.
	```sql
    SELECT g.nombre_grado, SUM(a.creditos) AS sum_creditos, t.nombre_tipo_asignatura
    FROM grado g
    JOIN asignatura a ON g.id_grado = a.id_grado
    LEFT JOIN tipo_asignatura t ON a.id_tipo_asignatura = t.id_tipo_asignatura
    GROUP BY g.nombre_grado, t.nombre_tipo_asignatura
    ORDER BY sum_creditos DESC;

    +----------------------------+--------------+------------------------+
	| nombre_grado               | sum_creditos | nombre_tipo_asignatura |
	+----------------------------+--------------+------------------------+
	| Ingeniería Informática     |           48 | Obligatoria            |
	| Administración de Empresas |           48 | Obligatoria            |
	| Medicina                   |           48 | Obligatoria            |
	| Derecho                    |           42 | Obligatoria            |
	+----------------------------+--------------+------------------------+
	```
	---
8. Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.
	```sql
    SELECT c.anyo_inicio, c.anyo_fin, COUNT(a.id_alumno) AS cant_alumnos
    FROM curso_escolar c
    LEFT JOIN alumno_se_matricula_asignatura aa ON c.id_curso_escolar = aa.id_curso_escolar
    LEFT JOIN alumno a ON aa.id_alumno = a.id_alumno
    GROUP BY c.anyo_inicio, c.anyo_fin
    ORDER BY cant_alumnos DESC;

	+-------------+----------+--------------+
	| anyo_inicio | anyo_fin | cant_alumnos |
	+-------------+----------+--------------+
	|        2023 |     2024 |           15 |
	|        2024 |     2025 |            0 |
	|        2025 |     2026 |            0 |
	|        2026 |     2027 |            0 |
	+-------------+----------+--------------+
	```
	---
9. Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas. Subconsultas
	```sql
    SELECT p.apellido1, p.apellido2, p.nombre_profesor, COUNT(a.id_asignatura) AS cant_asignaturas
    FROM profesor p
    LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
    GROUP BY p.apellido1, p.apellido2, p.nombre_profesor
    ORDER BY cant_asignaturas DESC;

    +-----------+-----------+-----------------+------------------+
	| apellido1 | apellido2 | nombre_profesor | cant_asignaturas |
	+-----------+-----------+-----------------+------------------+
	| Rodríguez | Gómez     | Pedro           |                4 |
	| Pérez     | López     | Laura           |                4 |
	| Gómez     | Fernández | Carlos          |                3 |
	| Hernández | García    | David           |                3 |
	| Díaz      | Martín    | Elena           |                3 |
	| Ruiz      | Hernández | Sara            |                3 |
	| Fernández | Díaz      | Javier          |                3 |
	| García    | Pérez     | Juan            |                2 |
	| López     | Martínez  | María           |                1 |
	| Martín    | Sánchez   | Ana             |                0 |
	+-----------+-----------+-----------------+------------------+
	```
	---

### Subconsultas
---
1. Devuelve todos los datos del alumno más joven.
	```sql
    SELECT id_alumno, nif, nombre_alumno, apellido1, apellido2, id_direccion, id_telefono, fecha_nacimiento, sexo
    FROM alumno
    WHERE fecha_nacimiento = (
        SELECT fecha_nacimiento
        FROM alumno
        ORDER BY fecha_nacimiento DESC
        LIMIT 1
    );

	+-----------+-----------+---------------+-----------+-----------+--------------+-------------+------------------+------+
	| id_alumno | nif       | nombre_alumno | apellido1 | apellido2 | id_direccion | id_telefono | fecha_nacimiento | sexo |
	+-----------+-----------+---------------+-----------+-----------+--------------+-------------+------------------+------+
	|        10 | 01234567Q | Alejandro     | Ruiz      | Fernández | 20           |          20 | 2001-11-28       | H    |
	+-----------+-----------+---------------+-----------+-----------+--------------+-------------+------------------+------+
	```
	---
2. Devuelve un listado con los profesores que no están asociados a un departamento.
	```sql
    SELECT apellido1, apellido2, nombre_profesor
	FROM profesor
	WHERE id_departamento IS NULL;
	```
	---
3. Devuelve un listado con los departamentos que no tienen profesores asociados.
	```sql
    SELECT id_departamento, nombre_departamento
    FROM departamento 
    WHERE NOT EXISTS (
        SELECT 1
        FROM profesor
        WHERE profesor.id_departamento = departamento.id_departamento
    );

	+-----------------+----------------------------+
	| id_departamento | nombre_departamento        |
	+-----------------+----------------------------+
	|               5 | Departamento de Idiomas    |
	|               6 | Departamento de Literatura |
	+-----------------+----------------------------+
	```
	---
4. Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.
	```sql
    SELECT apellido1, apellido2, nombre_profesor
    FROM profesor
    WHERE id_departamento IS NOT NULL
    AND id_profesor NOT IN (
        SELECT id_profesor
        FROM asignatura
        WHERE id_profesor IS NOT NULL
    );

	+-----------+-----------+-----------------+
	| apellido1 | apellido2 | nombre_profesor |
	+-----------+-----------+-----------------+
	| Martín    | Sánchez   | Ana             |
	+-----------+-----------+-----------------+
	```
	---
5. Devuelve un listado con las asignaturas que no tienen un profesor asignado.
	```sql
    SELECT nombre_asignatura
	FROM asignatura
	WHERE id_profesor IS NULL;

	+---------------------+
	| nombre_asignatura   |
	+---------------------+
	| Matemáticas I       |
	| Literatura Española |
	| Historia del Arte   |
	| Microeconomía       |
	| Fisiología          |
	+---------------------+
	```
	---
6. Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.
	```sql
	SELECT id_departamento, nombre_departamento
	FROM departamento
	WHERE id_departamento NOT IN (
		SELECT DISTINCT id_departamento
		FROM profesor
	);

	+-----------------+----------------------------+
	| id_departamento | nombre_departamento        |
	+-----------------+----------------------------+
	|               5 | Departamento de Idiomas    |
	|               6 | Departamento de Literatura |
	+-----------------+----------------------------+
	```
	---

### Vistas

1. Cree una vista que devuelva un listado con los profesores que no imparten ninguna asignatura.
	```sql
    CREATE VIEW profesores_no_asignatura AS
    SELECT p.id_profesor, p.apellido1, p.apellido2, p.nombre_profesor, a.id_asignatura
    FROM profesor p
    LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
    WHERE a.id_asignatura IS NULL;

    SELECT * FROM profesores_no_asignatura ;

    +-------------+-----------+-----------+-----------------+---------------+
	| id_profesor | apellido1 | apellido2 | nombre_profesor | id_asignatura |
	+-------------+-----------+-----------+-----------------+---------------+
	|           4 | Martín    | Sánchez   | Ana             |          NULL |
	+-------------+-----------+-----------+-----------------+---------------+
	```
	---

2. Cree una vista que devuelva un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática.
	```sql
    CREATE VIEW alumnas_informaticas AS
    SELECT DISTINCT a.id_alumno, a.nombre_alumno, CONCAT(a.apellido1, ' ', a.apellido2) AS apellidos
    FROM alumno a
    JOIN alumno_se_matricula_asignatura aa ON a.id_alumno = aa.id_alumno
    JOIN asignatura ag ON aa.id_asignatura = ag.id_asignatura
    JOIN grado g ON ag.id_grado = g.id_grado
    WHERE a.sexo = 'M'
    AND g.nombre_grado = 'Ingeniería Informática';

    SELECT * FROM alumnas_informaticas ;

	+-----------+---------------+-----------------+
	| id_alumno | nombre_alumno | apellidos       |
	+-----------+---------------+-----------------+
	|         1 | Alejandra     | García Martínez |
	|         5 | Daniela       | Gómez Pérez     |
	+-----------+---------------+-----------------+
	```
	---

3. Cree una vista que devuelva el listado de los alumnos que nacieron en 2000.
	```sql
    CREATE VIEW alumnos_2000 AS
    SELECT apellido1, apellido2, nombre_alumno
    FROM alumno
    WHERE YEAR(fecha_nacimiento) = 2000;

    SELECT * FROM alumnos_2000 ;

    +-----------+-----------+---------------+
	| apellido1 | apellido2 | nombre_alumno |
	+-----------+-----------+---------------+
	| García    | Martínez  | Luis          |
	| Martín    | Gómez     | Pablo         |
	| Gómez     | Pérez     | Daniel        |
	| Díaz      | Martínez  | Carlos        |
	| Torres    | Sánchez   | Sara          |
	| García    | Martínez  | Lucía         |
	| Martín    | Gómez     | Paula         |
	| Paniagua  | Pérez     | Andres        |
	+-----------+-----------+---------------+
	```
	---

4. Cree una vista que averigüe el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
	```sql
    CREATE VIEW alumnos_telefono AS
    SELECT apellido1, apellido2, nombre_alumno
    FROM alumno
    WHERE id_telefono IS NOT NULL;

    SELECT * FROM alumnos_telefono ;

	+-----------+-----------+---------------+
	| apellido1 | apellido2 | nombre_alumno |
	+-----------+-----------+---------------+
	| García    | Martínez  | Luis          |
	| López     | Fernández | Ana           |
	| Martín    | Gómez     | Pablo         |
	| Sánchez   | Rodríguez | Elena         |
	| Gómez     | Pérez     | Daniel        |
	| Hernández | García    | Laura         |
	| Díaz      | Martínez  | Carlos        |
	| Muñoz     | López     | María         |
	| Torres    | Sánchez   | Sara          |
	| Ruiz      | Fernández | Alejandro     |
	| García    | Martínez  | Lucía         |
	| López     | Fernández | Javier        |
	| Martín    | Gómez     | Paula         |
	| Sánchez   | Rodríguez | Andrea        |
	| Paniagua  | Pérez     | Andres        |
	+-----------+-----------+---------------+
	```
	---

5. Cree una vista que devuelva un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019. 
	```sql
	CREATE VIEW alumnos_2023 AS
    SELECT DISTINCT a.id_alumno, a.nombre_alumno, CONCAT(a.apellido1, ' ', a.apellido2) AS apellidos
    FROM alumno a
    JOIN alumno_se_matricula_asignatura aa ON a.id_alumno = aa.id_alumno
    JOIN curso_escolar c ON aa.id_curso_escolar = c.id_curso_escolar
    WHERE c.anyo_inicio = '2023' AND c.anyo_fin = '2024';

    SELECT * FROM alumnos_2023 ;

    +-----------+---------------+-------------------+
	| id_alumno | nombre_alumno | apellidos         |
	+-----------+---------------+-------------------+
	|         1 | Alejandra     | García Martínez   |
	|         2 | Ana           | López Fernández   |
	|         3 | Pablo         | Martín Gómez      |
	|         4 | Elena         | Sánchez Rodríguez |
	|         5 | Daniela       | Gómez Pérez       |
	|         6 | Laura         | Hernández García  |
	|         7 | Carlos        | Díaz Martínez     |
	|         8 | María         | Muñoz López       |
	+-----------+---------------+-------------------+
	```
	---

6. Cree una vista que devuelva un listado con las asignaturas que no tienen un profesor asignado.
	```sql
    CREATE VIEW asignaturas_no_profesor AS
    SELECT a.id_asignatura, a.nombre_asignatura, p.id_profesor
    FROM profesor p
    RIGHT JOIN asignatura a ON p.id_profesor = a.id_profesor
    WHERE p.id_profesor IS NULL;

    SELECT * FROM asignaturas_no_profesor ;

	+---------------+---------------------+-------------+
	| id_asignatura | nombre_asignatura   | id_profesor |
	+---------------+---------------------+-------------+
	|             1 | Matemáticas I       |        NULL |
	|             4 | Literatura Española |        NULL |
	|            11 | Historia del Arte   |        NULL |
	|            13 | Microeconomía       |        NULL |
	|            14 | Fisiología          |        NULL |
	+---------------+---------------------+-------------+
	```
	---

7. Cree una vista que devuelva el listado de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.
	```sql
    CREATE VIEW termina_K AS
    SELECT apellido1, apellido2, nombre_profesor
    FROM profesor
    WHERE id_telefono IS NOT NULL 
    AND nif LIKE '%K';

    SELECT * FROM termina_K ;

	+-----------+-----------+-----------------+
	| apellido1 | apellido2 | nombre_profesor |
	+-----------+-----------+-----------------+
	| Gómez     | Fernández | Carlos          |
	| Díaz      | Martín    | Elena           |
	+-----------+-----------+-----------------+
	```
	---

8. Cree una vista que devuelva el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
	```sql
    CREATE VIEW asignaturas_cuatrimestre_1 AS
    SELECT id_asignatura, nombre_asignatura
    FROM asignatura
    WHERE cuatrimestre = 1 
    AND curso = 3;

    SELECT * FROM asignaturas_cuatrimestre_1 ;

	+---------------+--------------------+
	| id_asignatura | nombre_asignatura  |
	+---------------+--------------------+
	|             1 | Matemáticas I      |
	|             8 | Psicología General |
	+---------------+--------------------+
	```
	---

9. Cree una vista que devuelva un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con nif 23456789Y.
	```sql
    CREATE VIEW asignaturas_nif AS
    SELECT ag.nombre_asignatura, c.anyo_inicio, c.anyo_fin
    FROM alumno_se_matricula_asignatura aa
    JOIN asignatura ag ON aa.id_asignatura = ag.id_asignatura
    JOIN alumno al ON aa.id_alumno = al.id_alumno
    JOIN curso_escolar c ON aa.id_curso_escolar = c.id_curso_escolar
    WHERE al.nif = '23456789Y';

    SELECT * FROM asignaturas_nif ;

    +------------------------+-------------+----------+
	| nombre_asignatura      | anyo_inicio | anyo_fin |
	+------------------------+-------------+----------+
	| Historia Contemporánea |        2023 |     2024 |
	| Literatura Española    |        2023 |     2024 |
	+------------------------+-------------+----------+
	```
	---

10. Cree una vista que devuelva un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Programación.
	```sql
    CREATE VIEW departamentos_profesores_asignatura AS
    SELECT d.nombre_departamento
    FROM profesor p
    JOIN departamento d ON p.id_departamento = d.id_departamento
    JOIN asignatura ag ON p.id_profesor = ag.id_profesor
    WHERE ag.nombre_asignatura = 'Programación';

    SELECT * FROM departamentos_profesores_asignatura ;

	+--------------------------------------------+
	| nombre_departamento                        |
	+--------------------------------------------+
	| Departamento de Ciencias de la Computación |
	+--------------------------------------------+
	```
	---

### Procedimientos almacenados
1. Procedimiento para insertar un nuevo alumno
	```sql
    DELIMITER $$
    DROP PROCEDURE IF EXISTS InsertarAlumno;
    CREATE PROCEDURE InsertarAlumno (
        IN p_nif VARCHAR(9),
        IN p_nombre_alumno VARCHAR(25),
        IN p_apellido1 VARCHAR(50),
        IN p_apellido2 VARCHAR(50),
        IN p_id_direccion VARCHAR(5),
        IN p_id_telefono INT,
        IN p_fecha_nacimiento DATE,
        IN p_sexo ENUM('H','M')
    )
    BEGIN
        INSERT INTO alumno (nif, nombre_alumno, apellido1, apellido2, id_direccion, id_telefono, fecha_nacimiento, sexo)
        VALUES (p_nif, p_nombre_alumno, p_apellido1, p_apellido2, p_id_direccion, p_id_telefono, p_fecha_nacimiento, p_sexo);
    
        SELECT * 
        FROM alumno
        WHERE nif = p_nif;
    END $$
    DELIMITER ; $$

    CALL InsertarAlumno ('17844567Z', 'Pedro', 'García', 'Rubio', 10, 9, '2000-07-15', 'H');

	+-----------+-----------+---------------+-----------+-----------+--------------+-------------+------------------+------+
	| id_alumno | nif       | nombre_alumno | apellido1 | apellido2 | id_direccion | id_telefono | fecha_nacimiento | sexo |
	+-----------+-----------+---------------+-----------+-----------+--------------+-------------+------------------+------+
	|        19 | 17844567Z | Pedro         | García    | Rubio     | 10           |           9 | 2000-07-15       | H    |
	+-----------+-----------+---------------+-----------+-----------+--------------+-------------+------------------+------+
	```
	---

	```sql
    DELIMITER $$
    DROP PROCEDURE IF EXISTS ActualizarAlumno;
    CREATE PROCEDURE ActualizarAlumno (
        IN p_id_alumno INT,
        IN p_nif VARCHAR(9),
        IN p_nombre_alumno VARCHAR(25),
        IN p_apellido1 VARCHAR(50),
        IN p_apellido2 VARCHAR(50),
        IN p_id_direccion VARCHAR(5),
        IN p_id_telefono INT,
        IN p_fecha_nacimiento DATE,
        IN p_sexo ENUM('H','M')
    )
    BEGIN
        UPDATE alumno
        SET nif = p_nif, nombre_alumno = p_nombre_alumno, apellido1 = p_apellido1, apellido2 = p_apellido2, 
            id_direccion = p_id_direccion, id_telefono = p_id_telefono, fecha_nacimiento = p_fecha_nacimiento, sexo = p_sexo
        WHERE id_alumno = p_id_alumno;
    
        SELECT * 
        FROM alumno
        WHERE nif = p_nif;
    END $$
    DELIMITER ; $$

    CALL ActualizarAlumno (19, '17844567Z', 'Pablo', 'Lopez', 'Rubio', 11, 9, '2000-02-15', 'H');

	+-----------+-----------+---------------+-----------+-----------+--------------+-------------+------------------+------+
	| id_alumno | nif       | nombre_alumno | apellido1 | apellido2 | id_direccion | id_telefono | fecha_nacimiento | sexo |
	+-----------+-----------+---------------+-----------+-----------+--------------+-------------+------------------+------+
	|        19 | 17844567Z | Pablo         | Lopez     | Rubio     | 11           |           9 | 2000-02-15       | H    |
	+-----------+-----------+---------------+-----------+-----------+--------------+-------------+------------------+------+
	```
	---

	```sql
    
	```
	---

	```sql
    
	```
	---

	```sql
    
	```
	---

	```sql
    
	```
	---

	```sql
    
	```
	---

	```sql
    
	```

	```sql
    
	```
	---

	```sql
    
	```
	---