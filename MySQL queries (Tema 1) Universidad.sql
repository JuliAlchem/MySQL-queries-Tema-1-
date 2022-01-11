/* Base de dades Universidad */

/* 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. 
El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, 
segon cognom i nom.*/
SELECT apellido1, apellido2, nombre 
FROM persona
WHERE tipo = 'alumno'
ORDER BY apellido1, apellido2, nombre;
/* 2.Esbrina el nom i els dos cognoms dels alumnes 
que no han donat d'alta el seu número de telèfon en la base de dades.*/
SELECT nombre, apellido1, apellido2 
FROM persona
WHERE tipo = 'alumno'
AND telefono IS NULL;
/* 3.Retorna el llistat dels alumnes que van néixer en 1999.*/
SELECT * FROM persona
WHERE tipo = 'alumno'
 AND fecha_nacimiento BETWEEN '1999-1-1' AND '2000-1-1';
/* 4.Retorna el llistat de professors que no han donat d'alta el seu número de telèfon en la base de dades
i a més la seva nif acaba en K.*/
SELECT * FROM persona
WHERE tipo = 'profesor'
AND telefono IS NULL
AND nif LIKE '%K';
/* 5.Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre,
en el tercer curs del grau que té l'identificador 7.*/
SELECT * FROM asignatura
WHERE cuatrimestre = 1
AND curso = 3
AND id_grado =7;
/* 6.Retorna un llistat dels professors juntament amb el nom del departament al qual estan vinculats. 
El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.*/
SELECT * FROM persona
WHERE tipo = 'profesor';
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre AS departamento
FROM persona, departamento, profesor
WHERE persona.id = profesor.id_profesor
AND departamento.id = profesor.id_departamento
ORDER BY apellido1, apellido2, nombre;
/* 7.Retorna un llistat amb el nom de les assignatures,
any d'inici i any de fi del curs escolar de l'alumne amb nif 26902806M.*/
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin
FROM asignatura, persona, curso_escolar, alumno_se_matricula_asignatura
WHERE persona.id = alumno_se_matricula_asignatura.id_alumno
AND asignatura.id = alumno_se_matricula_asignatura.id_asignatura
AND curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
AND persona.nif = '26902806M';
/* 8.Retorna un llistat amb el nom de tots els departaments que tenen professors 
que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).*/
SELECT departamento.nombre FROM profesor, departamento, asignatura, grado
WHERE profesor.id_profesor = asignatura.id_profesor
AND profesor.id_departamento = departamento.id
AND grado.id = asignatura.id_grado
AND grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';
/* 9.Retorna un llistat amb tots els alumnes 
que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.*/
SELECT DISTINCT persona.nombre FROM persona, alumno_se_matricula_asignatura
WHERE persona.id = alumno_se_matricula_asignatura.id_alumno
AND alumno_se_matricula_asignatura.id_curso_escolar = (SELECT curso_escolar.id FROM universidad.curso_escolar
WHERE curso_escolar.anyo_inicio = '2018'
AND curso_escolar.anyo_fin = '2019'); 

/*
Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.
*/

/* 1. Retorna un llistat amb els noms de tots els professors i els departaments que tenen vinculats. 
El llistat també ha de mostrar aquells professors que no tenen cap departament associat.
El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor. 
El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom. */
SELECT departamento.nombre AS departamento, persona.apellido1, persona.apellido2, persona.nombre
FROM departamento JOIN profesor 
ON departamento.id = profesor.id_departamento
RIGHT OUTER JOIN persona 
ON persona.id = profesor.id_profesor
ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;
/* 2. Retorna un llistat amb els professors que no estan associats a un departament. */
SELECT departamento.nombre AS departamento, persona.apellido1, persona.apellido2, persona.nombre
FROM departamento JOIN profesor 
ON departamento.id = profesor.id_departamento
RIGHT OUTER JOIN persona 
ON persona.id = profesor.id_profesor
WHERE departamento.nombre IS NULL;
/* 3. Retorna un llistat amb els departaments que no tenen professors associats. */
SELECT departamento.nombre FROM departamento
LEFT OUTER JOIN profesor
ON departamento.id = profesor.id_departamento
WHERE id_profesor IS NULL;
/* 4. Retorna un llistat amb els professors que no imparteixen cap assignatura. */
SELECT persona.apellido1, persona.apellido2, persona.nombre /*, asignatura.nombre AS asignatura*/
FROM persona
LEFT OUTER JOIN asignatura
ON persona.id = asignatura.id_profesor
WHERE asignatura.nombre IS NULL;
/* 5. Retorna un llistat amb les assignatures que no tenen un professor assignat. */
SELECT asignatura.nombre
FROM persona
RIGHT OUTER JOIN asignatura
ON persona.id = asignatura.id_profesor
WHERE persona.id IS NULL;
/* 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar. */
SELECT DISTINCT d.nombre AS departamento FROM departamento d
LEFT OUTER JOIN profesor p
ON d.id = p.id_departamento
LEFT OUTER JOIN asignatura a 
ON p.id_profesor = a.id_profesor
LEFT OUTER JOIN curso_escolar c 
ON a.curso = c.id
WHERE a.id IS NULL
AND c.id IS NULL;

/*
Consultes resum:
*/

/* 1.Retorna el nombre total d'alumnes que hi ha. */
SELECT COUNT(*) AS totalAlumnos
FROM persona
WHERE tipo = 'alumno';
/* 2.Calcula quants alumnes van néixer en 1999. */
SELECT COUNT(*) FROM persona
WHERE tipo = 'alumno'
AND fecha_nacimiento BETWEEN '1999-01-01' AND '2000-01-01';
/* 3.Calcula quants professors hi ha en cada departament.
El resultat només ha de mostrar dues columnes, una amb el nom del departament 
i una altra amb el nombre de professors que hi ha en aquest departament. 
El resultat només ha d'incloure els departaments que tenen professors associats 
i haurà d'estar ordenat de major a menor pel nombre de professors. */
SELECT d.nombre AS departamento, COUNT(p.id_profesor) AS totalProf  FROM departamento d
JOIN profesor p
ON p.id_departamento = d.id
GROUP BY departamento
ORDER BY totalProf DESC;
/* 4. Retorna un llistat amb tots els departaments i el nombre de professors 
que hi ha en cadascun d'ells. 
Tingui en compte que poden existir departaments que no tenen professors associats.
Aquests departaments també han d'aparèixer en el llistat.*/
SELECT d.nombre AS departamento, COUNT(p.id_profesor) AS totalProf  FROM departamento d
LEFT OUTER JOIN profesor p
ON p.id_departamento = d.id
GROUP BY d.nombre;
/* 5.Retorna un llistat amb el nom de tots els graus existents en la base de dades
i el nombre d'assignatures que té cadascun. 
Tingui en compte que poden existir graus que no tenen assignatures associades.
Aquests graus també han d'aparèixer en el llistat. 
El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.*/
SELECT g.nombre AS grado, COUNT(a.nombre) AS totalAsignatura FROM grado g
LEFT OUTER JOIN asignatura a
ON g.id = a.id_grado
GROUP BY grado
ORDER BY totalAsignatura DESC;
/* 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades 
i el nombre d'assignatures que té cadascun, 
dels graus que tinguin més de 40 assignatures associades.*/
SELECT g.nombre AS grado, COUNT(a.nombre) AS totalAsignatura FROM grado g
LEFT OUTER JOIN asignatura a
ON g.id = a.id_grado
GROUP BY grado
HAVING totalAsignatura > 40;
/* 7.Retorna un llistat que mostri el nom dels graus 
i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. 
El resultat ha de tenir tres columnes: nom del grau, 
tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.*/
SELECT g.nombre, a.tipo, SUM(creditos) FROM asignatura a
JOIN grado g ON a.id_grado = g.id
WHERE id_grado = 4 AND tipo = 'básica'
UNION 
SELECT g.nombre, a.tipo, SUM(creditos) FROM asignatura a
JOIN grado g ON a.id_grado = g.id
WHERE id_grado = 4 AND tipo = 'obligatoria'
UNION 
SELECT g.nombre, a.tipo, SUM(creditos) FROM asignatura a
JOIN grado g ON a.id_grado = g.id
WHERE id_grado = 4 AND tipo = 'optativa'
UNION 
SELECT g.nombre, a.tipo, SUM(creditos) FROM asignatura a
JOIN grado g ON a.id_grado = g.id
WHERE id_grado = 7 AND tipo = 'básica'
UNION 
SELECT g.nombre, a.tipo, SUM(creditos) FROM asignatura a
JOIN grado g ON a.id_grado = g.id
WHERE id_grado = 7 AND tipo = 'obligatoria';
/* 8.Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. 
El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar 
i una altra amb el nombre d'alumnes matriculats.*/
SELECT c.anyo_inicio, COUNT(a.id_alumno) AS totalAlumnos FROM alumno_se_matricula_asignatura a
JOIN curso_escolar c 
ON a.id_curso_escolar = c.id
GROUP BY a.id_curso_escolar;
/* 9.Retorna un llistat amb el nombre d'assignatures que imparteix cada professor. 
El llistat ha de tenir en compte aquells professors que no imparteixen cap assignatura. 
El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. 
El resultat estarà ordenat de major a menor pel nombre d'assignatures.*/
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.nombre) AS totalAsignaturas
FROM persona LEFT OUTER JOIN asignatura 
ON persona.id = asignatura.id_profesor
GROUP BY persona.id
ORDER BY totalAsignaturas DESC;
/* 10.Retorna totes les dades de l'alumne més jove. */
SELECT * FROM persona 
WHERE tipo = 'alumno'
ORDER BY fecha_nacimiento DESC LIMIT 1;
/* 11.Retorna un llistat amb els professors que tenen un departament associat 
i que no imparteixen cap assignatura.*/
SELECT persona.nombre, persona.apellido1, persona.apellido2 FROM profesor p
LEFT OUTER JOIN asignatura a
   ON p.id_profesor = a.id_profesor
JOIN persona 
ON p.id_profesor = persona.id
WHERE a.nombre IS NULL;