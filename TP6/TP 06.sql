-- a. Supprimer dans la table compo toutes les lignes concernant les bons de commande d'avril 2019
DELETE
FROM compo
WHERE ID_BON IN (SELECT bon.ID FROM bon WHERE YEAR(bon.DATE_CMDE) = 2019 AND MONTH(bon.DATE_CMDE) = 4);

-- b. Supprimer dans la table bon tous les bons de commande d'avril 2019.
DELETE
FROM bon
WHERE YEAR(DATE_CMDE) = 2019
  AND MONTH(DATE_CMDE) = 4;