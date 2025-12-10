-- a. Listez les articles dans l'ordre alphabétique des désignations
SELECT *
FROM article
ORDER BY DESIGNATION;

-- b. Listez les articles dans l'ordre des prix du plus élevé au moins élevé
SELECT *
FROM article
ORDER BY PRIX DESC;

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT *
FROM article
WHERE DESIGNATION LIKE '%boulon%'
ORDER BY PRIX;

-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT *
FROM article
WHERE DESIGNATION LIKE '%sachet%';

-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT *
FROM article
WHERE LOWER(DESIGNATION) LIKE '%sachet%';

-- f. Listez les articles avec les informations fournisseur correspondantes. Les résultats doivent être triées dans l'ordre alphabétique des fournisseurs et par article du prix le plus élevé au moins élevé.
SELECT a.*, f.*
FROM article a
         JOIN fournisseur f ON a.ID_FOU = f.ID
ORDER BY f.NOM, a.prix DESC;

-- g. Listez les articles de la société « Dubois & Fils »
SELECT *
FROM article
WHERE ID_FOU = (SELECT ID FROM fournisseur WHERE NOM = 'Dubois & Fils');

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT AVG(PRIX) AS MOYENNE_PRIX_DUBOIS_FILS
FROM article
WHERE ID_FOU = (SELECT ID FROM fournisseur WHERE NOM = 'Dubois & Fils');

-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT ID_FOU, AVG(PRIX) AS MOYENNE_PRIX
FROM article
GROUP BY ID_FOU;

-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT *
FROM bon
WHERE DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12:00:00'

-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT b.*
FROM bon b
         JOIN fournisseur f ON b.ID_FOU = f.ID
         JOIN article a ON f.ID = a.ID_FOU
WHERE a.DESIGNATION LIKE '%boulon%';

-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.
SELECT b.*, f.NOM NOM_FOURNISSEURS
FROM bon b
         JOIN fournisseur f ON b.ID_FOU = f.ID
         JOIN article a ON f.ID = a.ID_FOU
WHERE a.DESIGNATION LIKE '%boulon%';

-- m. Calculez le prix total de chaque bon de commande
SELECT b.*, SUM(c.QTE * a.PRIX) PRIX_TOTAL
FROM bon b
         JOIN compo c ON b.ID = c.ID_BON
         JOIN article a ON c.ID_ART = a.ID
GROUP BY b.ID;

-- n. Comptez le nombre d'articles de chaque bon de commande
SELECT b.*, SUM(c.QTE) NOMBRE_ARTICLES
FROM bon b
         JOIN compo c ON b.ID = c.ID_BON
GROUP BY b.ID;

-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d'articles de chacun de ces bons de commande
SELECT b.*, SUM(c.QTE) NOMBRE_ARTICLES
FROM bon b
         JOIN compo c ON b.ID = c.ID_BON
GROUP BY b.ID
HAVING SUM(c.QTE) > 25;

-- p. Calculez le coût total des commandes effectuées sur le mois d'avril
SELECT b.*, SUM(c.QTE * a.PRIX) PRIX_TOTAL
FROM bon b
         JOIN compo c ON b.ID = c.ID_BON
         JOIN article a ON c.ID_ART = a.ID
WHERE b.DATE_CMDE BETWEEN '2019-04-01 00:00:00' AND '2019-04-30 23:59:59'
GROUP BY b.ID;