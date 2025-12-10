-- CREATION DATABASE
DROP DATABASE IF EXISTS compta;
CREATE DATABASE compta;
USE compta;

-- CREATION DES TABLES
CREATE TABLE ARTICLE (
    ID int(11) AUTO_INCREMENT PRIMARY KEY,
    REF varchar(13) NOT NULL,
    DESIGNATION varchar(255) NOT NULL,
    PRIX decimal(7,2) NOT NULL,
    ID_FOU int(11) NOT NULL
);

CREATE TABLE FOURNISSEUR (
    ID int(11) PRIMARY KEY,
    NOM varchar(25) NOT NULL
);

CREATE TABLE BON (
    ID int(11) PRIMARY KEY,
    NUMERO int(11) NOT NULL,
    DATE_CMDE datetime NOT NULL,
    DELAI int(11) NOT NULL,
    ID_FOU int(11) NOT NULL
);

CREATE TABLE COMPO (
    ID int(11) PRIMARY KEY,
    ID_ART int(11) NOT NULL,
    ID_BON int(11) NOT NULL,
    QTE int(11) NOT NULL
);

ALTER TABLE ARTICLE ADD CONSTRAINT fk_id_fou_article FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID);
ALTER TABLE BON ADD CONSTRAINT fk_id_fou_bon FOREIGN KEY (ID_FOU) REFERENCES FOURNISSEUR(ID);
ALTER TABLE COMPO ADD CONSTRAINT fk_id_art FOREIGN KEY (ID_ART) REFERENCES ARTICLE(ID);
ALTER TABLE COMPO ADD CONSTRAINT fk_id_bon FOREIGN KEY (ID_BON) REFERENCES BON(ID);


-- INSERTION FOURNISSEUR
INSERT INTO FOURNISSEUR (ID, NOM) VALUES
(1,'Française d''imports'),
(2,'FDM SA'),
(3,'Dubois & Fils');

-- INSERTION ARTICLE
INSERT INTO ARTICLE (ID, REF, DESIGNATION, PRIX, ID_FOU) VALUES
(1, 'A01', 'Perceuse P1', 74.99, 1),
(2, 'F01', 'Boulon laiton 4 x 40 mm (sachet de 10)', 2.25, 2),
(3, 'F02', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.45, 2),
(4, 'D01', 'Boulon laiton 5 x 40 mm (sachet de 10)', 4.40, 3),
(5, 'A02', 'Meuleuse 125mm', 37.85, 1),
(6, 'D03', 'Boulon acier zingué 4 x 40mm (sachet de 10)', 1.80, 3),
(7, 'A03', 'Perceuse à colonne', 185.25, 1),
(8, 'D04', 'Coffret mêches à bois', 12.25, 3),
(9, 'F03', 'Coffret mêches plates', 6.25, 2),
(10, 'F04', 'Fraises d''encastrement', 8.14, 2);

-- INSERTION BON
INSERT INTO BON (ID, NUMERO, DATE_CMDE, DELAI, ID_FOU) VALUES
(1,1,current_date,3,1);
-- Insertion du bon de commande auprès du fournisseur "Française d'Imports"

-- INSERTION COMPO
INSERT INTO COMPO (ID, ID_ART, ID_BON, QTE) VALUES
(1,1,1,3),
(2,5,1,4),
(3,7,1,1);