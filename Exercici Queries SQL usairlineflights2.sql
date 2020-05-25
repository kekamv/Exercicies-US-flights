USE usairlineflights2;
-- 1.	Quantitat de registres de la taula de vols:
SELECT COUNT(1) FROM flights;
-- alternatively
SELECT COUNT(*) FROM flights;
-- 2.	Retard promig de sortida i arribada segons l’aeroport origen.
SELECT IATA AS 'Origin', AVG(ArrDelay) AS 'prom_arribades', AVG(DepDelay) AS 'prom_sortides' FROM flights
INNER JOIN usairports
ON Origin = IATA
GROUP BY IATA;

/* 3.	Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen. 
A més, volen que els resultat es mostrin de la següent forma (fixa’t en l’ordre de les files): */
SELECT IATA AS 'Origin', colYear, colMonth, AVG(ArrDelay) AS 'prom_arribades' FROM flights
INNER JOIN usairports
ON Origin = IATA
GROUP BY IATA, colYear, colMonth
ORDER BY IATA ASC, colYear ASC, colMonth ASC;

/* 4.	Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen 
(mateixa consulta que abans i amb el mateix ordre). 
Però a més, ara volen que en comptes del codi de l’aeroport es mostri el nom de la ciutat. */
SELECT City, colYear, colMonth, AVG(ArrDelay) AS 'prom_arribades' FROM flights
INNER JOIN usairports
ON Origin = IATA
GROUP BY City, colYear, colMonth
ORDER BY City ASC, colYear ASC, colMonth ASC;

/*5.	Les companyies amb més vols cancelats, per mesos i any. 
A més, han d’estar ordenades de forma que les companyies amb més cancel•lacions apareguin les primeres. */
SELECT UniqueCarrier, colYear, colMonth, COUNT(Cancelled) AS total_cancelled FROM flights
WHERE Cancelled > 0
GROUP BY UniqueCarrier, colYear, colMonth
ORDER BY total_cancelled DESC;

-- 6.	L’identificador dels 10 avions que més distància han recorregut fent vols.
SELECT TailNum, SUM(Distance) AS total_Distance FROM flights
WHERE TailNum LIKE '%N%'
GROUP BY TailNum
ORDER BY total_Distance DESC
LIMIT 10;

/* 7.	Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben al seu destí 
amb un retràs promig major de 10 minuts. */

SELECT UniqueCarrier, AVG(ArrDelay) FROM flights
GROUP BY UniqueCarrier
HAVING AVG(ArrDelay) > 10
ORDER BY AVG(ArrDelay) DESC;