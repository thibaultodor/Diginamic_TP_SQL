-- a. Mettez en minuscules la désignation de l'article dont l'identifiant est 2
UPDATE article
SET DESIGNATION = LOWER(DESIGNATION)
WHERE ID = 2;

-- b. Mettez en majuscules les désignations de tous les articles dont le prix est strictement supérieur à 10€
UPDATE article
SET DESIGNATION = UPPER(DESIGNATION)
WHERE PRIX > 10;

-- c. Baissez de 10% le prix de tous les articles qui n'ont pas fait l'objet d'une commande.
UPDATE article a
SET a.PRIX = a.PRIX * 0.9
WHERE NOT EXISTS (SELECT *
                  FROM compo c
                  WHERE c.ID_ART = a.ID);

-- d. Une erreur s'est glissée dans les commandes concernant Française d'imports. Les chiffres en base ne sont pas bons. Il faut doubler les quantités de tous les articles commandés à cette société.
UPDATE compo c
SET c.QTE = c.QTE * 2
WHERE c.ID_ART IN (SELECT a.ID
                   FROM article a
                            JOIN fournisseur f ON a.ID_FOU = f.ID
                   WHERE f.NOM = 'Française d''imports');

-- e. Mettez au point une requête update qui permette de supprimer les éléments entre parenthèses dans les désignations. Il vous faudra utiliser des fonctions comme substring et position.
UPDATE article
SET DESIGNATION = trim(IF(position('(' in DESIGNATION) > 0,
                          substring(DESIGNATION FROM 1 FOR position('(' in DESIGNATION) - 1), DESIGNATION)
                  );
