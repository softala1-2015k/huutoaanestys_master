# Huutoäänestys master

### Softala 1:n Huutoäänestys-projektin back end ja front end yhdistettynä yhdeksi softaksi


Softala 1:n Huutoäänestys-projektin spring-ranka.

Repossa on toistaiseksi yksi mallitoiminnallisuus, kurssin tietojen noutaminen tietokannasta. Ideana tässä on seuraava:

- bean-kansio sisältää Java-beanien rajapintaluokat sekä niiden implementaatiot.
- controller-kansiossa on beaneja RESTin yli tarjoavat controller-luokat.
- dao-kansio sisältää tietokantametodien rajapintaluokat, niiden implementaatiot sekä tietokantahaun tulosten läpikäymiseen tarkoitetut RowMapperit.
- exception-kansio sisältää itsetehdyt poikkeusluokat, joita mahdollisesti tarvitaan.

Näiden lisäksi luodaan todennäköisesti myös service-kansio palveluluokille sekä utility-kansio lisäluokille, joita ei voi niputtaa yksiselitteisesti muihin kansioihin.

---

Repossa on myös angular-ranka, jossa on angularin routingilla toteutettu pari sivua.

Ajatuksena on, että front end:stä ja back end:stä on oma branch jotka edelleen branchataan featureiksi. 
Feature branchit yhdistetään siihen master-branchin haaraan mitä on työstetty ja lopulta front end ja back end branchit yhdistetään yhdeksi softaksi master-branchissä joka paketoidaan WAR-paketiksi ja pudotetaan protolle. 