# Huutoäänestys

Softala 1:n Huutoäänestys-projektin spring-ranka.

Repossa on toistaiseksi yksi mallitoiminnallisuus, kurssin tietojen noutaminen tietokannasta. Ideana tässä on seuraava:

- bean-kansio sisältää Java-beanien rajapintaluokat sekä niiden implementaatiot.
- controller-kansiossa on beaneja RESTin yli tarjoavat controller-luokat.
- dao-kansio sisältää tietokantametodien rajapintaluokat, niiden implementaatiot sekä tietokantahaun tulosten läpikäymiseen tarkoitetut RowMapperit.
- exception-kansio sisältää itsetehdyt poikkeusluokat, joita mahdollisesti tarvitaan.

Näiden lisäksi luodaan todennäköisesti myös service-kansio palveluluokille sekä utility-kansio lisäluokille, joita ei voi niputtaa yksiselitteisesti muihin kansioihin.

Todo:
- siirrä jsp-sivut secure kansioon kun login on hoidettu
