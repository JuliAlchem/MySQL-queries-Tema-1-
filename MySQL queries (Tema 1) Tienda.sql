/* Base de dades Tienda */

/* 1.Llista el nom de tots els productos que hi ha en la taula producto. */
SELECT nombre FROM tienda.producto;
/* 2.Llista els noms i els preus de tots els productos de la taula producto. */
SELECT nombre, precio FROM tienda.producto;
/* 3.Llista totes les columnes de la taula producto.  */
SHOW COLUMNS FROM tienda.producto;
/* 4.Llista el nom dels productos, el preu en euros i el preu en dòlars nord-americans (USD). */
SELECT nombre, precio, precio*0.89
AS precioUSD FROM tienda.producto; 
/* 5.Llista el nom dels productos, el preu en euros i el preu en dòlars nord-americans. 
Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars nord-americans. */
SELECT nombre AS nombreDeProducto, precio AS EUR, precio*0.89
AS USD FROM tienda.producto; 
/* 6.Llista els noms i els preus de tots els productos de la taula producto, 
convertint els noms a majúscula. */
SELECT UPPER(nombre) AS nombre, precio
FROM tienda.producto;
/* 7.Llista els noms i els preus de tots els productos de la taula producto, 
convertint els noms a minúscula. */
SELECT LOWER(nombre) AS nombre, precio
FROM tienda.producto;
/* 8.Llista el nom de tots els fabricants en una columna,
i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.*/
SELECT nombre, UPPER(LEFT(nombre, 2)) AS abrev
FROM fabricante; 
/* 9.Llista els noms i els preus de tots els productos de la taula producto,
arrodonint el valor del preu.*/
SELECT nombre, precio
FROM producto
ORDER BY precio;
/* 10.Llista els noms i els preus de tots els productos de la taula producto, 
truncant el valor del preu per a mostrar-lo sense cap xifra decimal. */
SELECT nombre, TRUNCATE(precio, 0) 
FROM producto;
/* 11.Llista el codi dels fabricants que tenen productos en la taula producto. */
SELECT codigo_fabricante
FROM producto;
/* 12.Llista el codi dels fabricants que tenen productos en la taula producto,
eliminant els codis que apareixen repetits. */
SELECT DISTINCT codigo_fabricante
FROM producto;
/* 13.Llista els noms dels fabricants ordenats de manera ascendent. */
SELECT nombre FROM tienda.fabricante
ORDER BY nombre;
/* 14.Llista els noms dels fabricants ordenats de manera descendent. */
SELECT nombre FROM tienda.fabricante
ORDER BY nombre DESC;
/* 15.Llista els noms dels productos ordenats en primer lloc pel nom de manera ascendent 
i en segon lloc pel preu de manera descendent. */
SELECT nombre FROM tienda.producto
ORDER BY nombre, precio DESC; 
/* 16.Retorna una llista amb les 5 primeres files de la taula fabricante. */
SELECT * FROM tienda.fabricante
LIMIT 5;
/* 17.Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante.
La quarta fila també s'ha d'incloure en la resposta. */
SELECT * FROM tienda.fabricante 
LIMIT 2 OFFSET 3;
/* 18.Llista el nom i el preu del producto més barat. 
(Utilitzi solament les clàusules ORDER BY i LIMIT). 
NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY*/
SELECT nombre, precio 
FROM producto 
ORDER BY precio LIMIT 1; 
/* 19.Llista el nom i el preu del producto més car. 
(Utilitzi solament les clàusules ORDER BY i LIMIT). 
NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY. */
SELECT nombre, precio 
FROM producto 
ORDER BY precio DESC LIMIT 1; 
/* 20.Llista el nom de tots els productos del fabricant el codi de fabricant del qual és igual a 2.*/
SELECT nombre
FROM producto 
WHERE codigo_fabricante = 2;
/* 21.Retorna una llista amb el nom del producte, 
preu i nom de fabricant de tots els productes de la base de dades.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto INNER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo;
/* 22.Retorna una llista amb el nom del producte, 
preu i nom de fabricant de tots els productes de la base de dades. 
Ordeni el resultat pel nom del fabricant, per ordre alfabètic.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto INNER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante;
/* 23.Retorna una llista amb el codi del producte, nom del producte, 
codi del fabricant i nom del fabricant, 
de tots els productes de la base de dades.*/
SELECT producto.codigo AS codigoProducto, producto.nombre AS nombreProducto, 
fabricante.codigo AS codigoFabricante, fabricante.nombre AS nombreFabricante
FROM producto LEFT OUTER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo;
/* 24.Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.*/
SELECT producto.nombre, MIN(producto.precio), fabricante.nombre AS fabricante
FROM producto INNER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo;
/* 25.Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.*/
SELECT producto.nombre, MAX(producto.precio), fabricante.nombre AS fabricante
FROM producto INNER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo;
/* 26.Retorna una llista de tots els productes del fabricant Lenovo.*/
SELECT  producto.nombre, fabricante.nombre AS fabricante
FROM producto LEFT OUTER JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre='Lenovo';
/* 27.Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200€. */
SELECT producto.codigo, producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre='Crucial'
AND producto.precio>200;
/* 28.Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. 
Sense utilitzar l'operador IN.*/
SELECT producto.nombre
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo 
AND (fabricante.nombre = 'Asus' OR fabricante.nombre = 'Seagate' OR fabricante.nombre = 'Hewlett-Packard');
/* 29.Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate.
 Utilitzant l'operador IN.*/
 SELECT producto.nombre
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre IN ('Asus', 'Seagate', 'Hewlett-Packard');
/* 30.Retorna un llistat amb el nom i el preu de tots els productes dels fabricants 
el nom dels quals acabi per la vocal e.*/
SELECT producto.nombre, producto.precio
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre LIKE '%e';
/* 31.Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant 
dels quals contingui el caràcter w en el seu nom.*/
SELECT producto.nombre, producto.precio
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre LIKE '%w%';
/* 32.Retorna un llistat amb el nom de producte, preu i nom de fabricant, 
de tots els productes que tinguin un preu major o igual a 180€. 
Ordeni el resultat en primer lloc pel preu (en ordre descendent) i en segon lloc pel nom (en ordre ascendent)*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND precio >= 180
ORDER BY precio DESC, nombre;
/* 33.Retorna un llistat amb el codi i el nom de fabricant, 
solament d'aquells fabricants que tenen productes associats en la base de dades.*/
SELECT DISTINCT fabricante.codigo, fabricante.nombre 
FROM fabricante, producto
WHERE producto.codigo_fabricante = fabricante.codigo;
/* 34.Retorna un llistat de tots els fabricants que existeixen en la base de dades, 
juntament amb els productes que té cadascun d'ells. 
El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.*/
SELECT fabricante.nombre AS fabricante , producto.nombre AS producto
FROM fabricante  LEFT OUTER JOIN producto
ON fabricante.codigo = producto.codigo_fabricante;
/* 35.Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.*/
SELECT fabricante.nombre AS fabricante
FROM fabricante  LEFT OUTER JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.nombre IS NULL;
/* 36.Retorna tots els productes del fabricant Lenovo. (Sense utilitzar INNER JOIN).*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre='Lenovo';
/* 37.Retorna totes les dades dels productes que tenen el mateix preu 
que el producte més car del fabricant Lenovo. (Sense utilitzar INNER JOIN).*/
SELECT *
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND producto.precio = (SELECT MAX(producto.precio) FROM producto, fabricante 
WHERE producto.codigo_fabricante = fabricante.codigo 
AND fabricante.nombre='Lenovo');
/* 38.Llista el nom del producte més car del fabricant Lenovo */
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre='Lenovo'
ORDER BY precio DESC LIMIT 1;
/* 39.Llista el nom del producte més barat del fabricant Hewlett-Packard.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre='Hewlett-Packard'
ORDER BY precio LIMIT 1;
/* 40.Retorna tots els productes de la base de dades que tenen un preu major o 
igual al producte més car del fabricant Lenovo.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND producto.precio >= (SELECT MAX(producto.precio) FROM producto, fabricante 
WHERE producto.codigo_fabricante = fabricante.codigo 
AND fabricante.nombre='Lenovo');
/* 41.Llesta tots els productes del fabricant Asus que 
tenen un preu superior al preu mitjà de tots els seus productes.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre = 'Asus'
AND producto.precio >= (SELECT AVG(producto.precio) FROM producto, fabricante 
WHERE producto.codigo_fabricante = fabricante.codigo 
AND fabricante.nombre='Asus');
