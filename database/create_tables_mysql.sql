/*	---------------------------------------	*/
/*	SOFTALA I --- TIETOKANNAN LUONTILAUSEET */
/*	---------------------------------------	*/

/**
 * 
 * Tämä skripti sisältää Softalaprojekti I -toteutuksen 11 kurssityötä varten
 * mietityn tietokannan luontilauseet.
 * 
 * @author Atte Valtonen, Markus Kiili
 * @version v1.4
 * 
 */

DROP TABLE IF EXISTS hops_suunniteltu_kurssi;
DROP TABLE IF EXISTS hops_suunniteltu_toteutus;
DROP TABLE IF EXISTS suuntautumisen_kurssi;
DROP TABLE IF EXISTS perusopintolinjan_kurssi;
DROP TABLE IF EXISTS vastuuopettaja;
DROP TABLE IF EXISTS lahtotasovaatimus;
DROP TABLE IF EXISTS kurssipalaute;
DROP TABLE IF EXISTS osallistuminen;
DROP TABLE IF EXISTS arvosana;
DROP TABLE IF EXISTS lahiopetuskerta;
DROP TABLE IF EXISTS toteutus;
DROP TABLE IF EXISTS kurssi;
DROP TABLE IF EXISTS opiskelija;
DROP TABLE IF EXISTS henkilokunta;
DROP TABLE IF EXISTS periodi;
DROP TABLE IF EXISTS periodityyppi;
DROP TABLE IF EXISTS suoritustila;
DROP TABLE IF EXISTS suoritustapa;
DROP TABLE IF EXISTS tyohuone;
DROP TABLE IF EXISTS luokkatila;
DROP TABLE IF EXISTS toimipiste;
DROP TABLE IF EXISTS opintotyyppi;
DROP TABLE IF EXISTS opintotaso;
DROP TABLE IF EXISTS suuntautuminen;
DROP TABLE IF EXISTS perusopintolinja;
DROP TABLE IF EXISTS koulutusohjelma;
DROP TABLE IF EXISTS kieli;
DROP TABLE IF EXISTS aloitusaika;


/*	YLEISIÄ TAULUJA */

/**
 * aloitusaika-taulu sisältää tiedot opiskelijoiden aloitusajankohdasta.
 * 
 * @param	ID (PK)	Automaattisesti kasvava pääavain.
 * @param	pvm	Päivämäärä, jolloin opiskelija on aloittanut opiskelunsa.
 * @param	kuvaus	Tekstimuotoinen esitystapa, esim. Syksy 2013.
 */
DROP TABLE IF EXISTS aloitusaika;
CREATE TABLE aloitusaika (
	ID     SMALLINT    NOT NULL AUTO_INCREMENT,
	pvm    DATE        NOT NULL,
	kuvaus VARCHAR(10) NOT NULL,
	PRIMARY KEY	(ID)
);

/**
 * kieli-taulu sisältää kurssien opetuksen ja koulutusohjelmien kielet.
 * 
 * @param	nimi (PK)	Kielen nimi.
 */
DROP TABLE IF EXISTS kieli;
CREATE TABLE kieli (
	nimi VARCHAR(255) NOT NULL,
	PRIMARY KEY (nimi)
);

/**
 * koulutusohjelma-taulu sisältää Haaga-Helian eri koulutusohjelmat.
 * 
 * @param	ID (PK)		Automaattisesti kasvava pääavain.
 * @param	nimi		Koulutusohjelman koko nimi.
 * @param	tunnus		Koulutusohjelman lyhennetunnus (esim. TIKO).
 * @param	kieli (FK)	Koulutusohjelman opetuskieli (suomi/englanti/muita?).
 */
DROP TABLE IF EXISTS koulutusohjelma;
CREATE TABLE koulutusohjelma (
	ID     TINYINT      NOT NULL AUTO_INCREMENT,
	nimi   VARCHAR(255) NOT NULL,
	tunnus VARCHAR(10)  NOT NULL, /* voisi pidentääkin */
	kieli  VARCHAR(255) NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (kieli) REFERENCES kieli(nimi) ON DELETE RESTRICT ON UPDATE CASCADE
);

/**
 * suuntautuminen-taulu sisältää eri koulutusohjelmien suuntautumisvaihtoehdot.
 * 
 * @param	ID (PK)					Automaattisesti kasvava pääavain.
 * @param	nimi					Suuntautumisen nimi.
 * @param	koulutusohjelma_ID		        Koulutusohjelma, johon viitataan.
 * @param	kuvaus					Vapaamuotoinen kuvaus suuntautumisvaihtoehdon sisällöstä.
 */

DROP TABLE IF EXISTS perusopintolinja;
CREATE TABLE perusopintolinja (
	nimi                 VARCHAR(255) NOT NULL,
	koulutusohjelma_ID   TINYINT      NOT NULL,
	kuvaus               TEXT         NOT NULL,
	PRIMARY KEY (nimi, koulutusohjelma_ID),
	FOREIGN KEY (koulutusohjelma_ID) REFERENCES koulutusohjelma(ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE IF EXISTS suuntautuminen;
CREATE TABLE suuntautuminen (
	nimi                  VARCHAR(255)    NOT NULL,
	koulutusohjelma_ID    TINYINT         NOT NULL,
    perusopintolinja      VARCHAR(255)    NOT NULL,
	kuvaus                TEXT            NOT NULL,
	PRIMARY KEY (nimi, koulutusohjelma_ID, perusopintolinja),
	FOREIGN KEY (koulutusohjelma_ID) REFERENCES perusopintolinja(koulutusohjelma_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (perusopintolinja) REFERENCES perusopintolinja(nimi)
);

/**
 * opintotaso-taulu sisältää tiedot eritasoisista opinnoista.
 * 
 * @param	nimi (PK)	Opintotason tyyppi (perusopinnot, ammattiopinnot yms).
 */
DROP TABLE IF EXISTS opintotaso;
CREATE TABLE opintotaso (
	nimi VARCHAR(255) NOT NULL,
	PRIMARY KEY (nimi)
);

/**
 * opintotyyppi-taulu sisältää tiedot erityyppisistä opinnoista.
 * 
 * @param	nimi	Opintotyypin kuvaus (pakollinen, valinnainen yms).
 */
DROP TABLE IF EXISTS opintotyyppi;
CREATE TABLE opintotyyppi (
	nimi VARCHAR(255) NOT NULL,
	PRIMARY KEY (nimi)
);

/**
 * toimipiste-taulusta löytyvät Haaga-Helian eri toimipisteet osoitetietoineen.
 * 
 * @param	ID (PK)		Automaattisesti kasvava pääavain.
 * @param	nimi		Toimipisteen nimi (Pasila, Vallila yms).
 * @param	osoite		Toimipisteen hallinnollinen osoite.
 * @param	postinro	Toimipisteen postinumero.
 * @param	postitmp	Toimipisteen postitoimipaikka.
 */
DROP TABLE IF EXISTS toimipiste;
CREATE TABLE toimipiste (
	ID       TINYINT      NOT NULL AUTO_INCREMENT,
	nimi     VARCHAR(255) NOT NULL,
	osoite   VARCHAR(255) NOT NULL,
	postinro SMALLINT     NOT NULL,
	postitmp SMALLINT     NOT NULL,
	PRIMARY KEY (ID)
);

/**
 * luokkatila-taulu sisältää tiedot toimipisteiden opetustiloista.
 * 
 * @param	tunnus (PK)			Luokan tunnus (esim. 5008M).
 * @param	toimipiste_ID (PK,FK)	        Haaga-Helian toimipiste, josta luokkatila löytyy.
 */
DROP TABLE IF EXISTS luokkatila;
CREATE TABLE luokkatila (
	tunnus        VARCHAR(5) NOT NULL,
	toimipiste_ID TINYINT    NOT NULL,
	PRIMARY KEY (tunnus, toimipiste_ID),
	FOREIGN KEY (toimipiste_ID) REFERENCES toimipiste(ID) ON DELETE RESTRICT ON UPDATE CASCADE
);
/**
 * tyohuone-taulu sisältää tiedot henkilökunnan työtiloista.
 * 
 * @param	tunnus (PK)		Työhuoneen tunnus.
 * @param	toimipiste (PK,FK)	Haaga-Helian toimipiste, josta työtila löytyy.
 */
DROP TABLE IF EXISTS tyohuone;
CREATE TABLE tyohuone (
	tunnus     VARCHAR(5) NOT NULL,
	toimipiste_ID TINYINT    NOT NULL,
	PRIMARY KEY (tunnus, toimipiste_ID),
	FOREIGN KEY (toimipiste_ID) REFERENCES toimipiste(ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

/**
 * suoritustapa-taulu määrittelee kurssitoteutuksen eri toteutustavat.
 * 
 * @param	nimi		Suoritustyyppi (päivä, ilta, monimuoto yms).
 */
DROP TABLE IF EXISTS suoritustapa;
CREATE TABLE suoritustapa (
	nimi VARCHAR(255) NOT NULL,
	PRIMARY KEY (nimi)
);

/**
 * suoritustila-taulussa on lueteltu "vaiheet", jossa opiskelija on menossa jollain kurssitoteutuksella.
 * 
 * @param       symboli         Suoritustilan symboli I/H/S
 * @param	kuvaus		Suoritustilan kuvaus: Ilmoittautunut/Hyväksytty/Suorittanut yms.		
 */
DROP TABLE IF EXISTS suoritustila;
CREATE TABLE suoritustila (
        symboli char(1) NOT NULL,
	kuvaus VARCHAR(255) NOT NULL,
	PRIMARY KEY (symboli)
);

/**
 * periodityyppi-taulusta löytyvät lukuvuoden periodien tyypit.
 * 
 * @param	nimi (PK)	Periodin tyyppi (normaali, intensiivi, loma, yms).
 */
DROP TABLE IF EXISTS periodityyppi;
CREATE TABLE periodityyppi (
	nimi VARCHAR(255) NOT NULL,
	PRIMARY KEY (nimi)
);
/**
 * periodi-taulu sisältää lukuvuoden periodit ja intensiiviviikot.
 * 
 * @param	nimi (PK)	Periodin nimi.
 * @param	tyyppi (FK)	Periodin tyyppi.
 * @param	alkupvm		Päivämäärä, jolloin periodi alkaa.
 * @param	loppupvm	Päivämäärä, jolloin periodi loppuu.
 */
DROP TABLE IF EXISTS periodi;
CREATE TABLE periodi (
	nimi     VARCHAR(255) NOT NULL,
	tyyppi   VARCHAR(255) NOT NULL,
	alkupvm  DATE         NOT NULL,
	loppupvm DATE         NOT NULL,
	PRIMARY KEY (nimi),
	FOREIGN KEY (tyyppi) REFERENCES periodityyppi(nimi) ON DELETE RESTRICT ON UPDATE CASCADE
	/* muuta? */
);


/* KÄYTTÄJÄT */

/**
 * henkilokunta-taulussa on tiedot Haaga-Helian henkilökunnasta.
 * 
 * @param	hlokuntanro (PK)	Työntekijän henkilökuntanumero, joka on viisinumeroinen.
 * @param	tyonalkupvm			Työsuhteen alkamispäivä.
 * @param	tyohuone (FK)		Työntekijälle mahdollisesti osoitettu työtila. Voi olla tyhjä.
 * @param	etunimet			Työntekijän etunimet, jos niitä on useampia.
 * @param	kutsumanimi			Työntekijän kutsumanimi.
 * @param	sukunimi			Työntekijän sukunimi.
 * @param	osoite				Työntekijän (koti)osoite.
 * @param	postinro 		Työntekijän postinumero.
 * @param	postitmp 		Työntekijän postitoimipaikka.
 * @param	kotipuhelin			Työntekijän henkilökohtainen puhelinnumero. Voi olla tyhjä.
 * @param	tyopuhelin			Työntekijän työpuhelimen numero.
 * @param	kotiemail			Työntekijän henkilökohtainen sähköpostiosoite. Voi olla tyhjä.
 * @param	tyoemail			Työntekijän työsähköpostin osoite.
 */
DROP TABLE IF EXISTS henkilokunta;
CREATE TABLE henkilokunta (
	hlokuntanro CHAR(5)       NOT NULL, /* EI GENEROIDA! */
	tyonalkupvm DATE          NOT NULL,
	tyohuone_tunnus    VARCHAR(5),
	toimipiste_id	   TINYINT,     
	etunimet    VARCHAR(255)  NOT NULL,
	kutsumanimi VARCHAR(255)  NOT NULL,
	sukunimi    VARCHAR(255)  NOT NULL,
	osoite      VARCHAR(255)  NOT NULL,
	postinro    SMALLINT      NOT NULL,
	postitmp    SMALLINT      NOT NULL,
	kotipuhelin VARCHAR(10),
	tyopuhelin  CHAR(10)      NOT NULL,
	kotiemail   VARCHAR(255),
	tyoemail    VARCHAR(255)  NOT NULL,
	PRIMARY KEY (hlokuntanro),
	FOREIGN KEY (tyohuone_tunnus) REFERENCES tyohuone(tunnus) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (toimipiste_id) REFERENCES tyohuone(toimipiste_ID) ON DELETE SET NULL ON UPDATE CASCADE
);

/**
 * opiskelija-taulussa on tiedot Haaga-Helian opiskelijoista.
 * 
 * @param	opiskelijanro (PK)	Opiskelijan opiskelijanumero, seitsemännumeroinen.
 * @param	aloitusaika (FK)	Ajankohta, jolloin opiskelija on aloittanut opintonsa.
 * @param	koulutusohjelma (FK)		Koulutusohjelma, jota opiskelija opiskelee.
 * @param	etunimet			Opiskelijan etunimet, jos niitä on useampia.
 * @param	kutsumanimi			Opiskelijan kutsumanimi.
 * @param	sukunimi			Opiskelijan sukunimi.
 * @param	osoite				Opiskelijan postiosoite.
 * @param	postinro			Opiskelijan postinumero.
 * @param	postitmp			Opiskelijan postitoimipaikka.
 * @param	puhnro				Opiskelijan puhelinnumero.
 * @param	sahkoposti			Opiskelijan sähköpostiosoite.
 */
DROP TABLE IF EXISTS opiskelija;
CREATE TABLE opiskelija (
	opiskelijanro 		CHAR(7)      NOT NULL, /* EI GENEROIDA! */
	aloitusaika   		SMALLINT     NOT NULL,
        koulutusohjelma_ID      TINYINT      NOT NULL,
	perusopintolinja        VARCHAR(255) NOT NULL,
	/* ryhma      		VARCHAR(10)  NOT NULL */
	etunimet      		VARCHAR(255) NOT NULL,
	kutsumanimi   		VARCHAR(255) NOT NULL,
	sukunimi      		VARCHAR(255) NOT NULL,
	osoite        		VARCHAR(255) NOT NULL,
	postinro      		SMALLINT     NOT NULL,
	postitmp      		SMALLINT     NOT NULL,
	puhnro        		CHAR(10)     NOT NULL,
	sahkoposti   	        VARCHAR(255) NOT NULL,
	PRIMARY KEY (opiskelijanro),
	FOREIGN KEY (aloitusaika) REFERENCES aloitusaika(ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (koulutusohjelma_ID) REFERENCES perusopintolinja(koulutusohjelma_ID),
    FOREIGN KEY (perusopintolinja) REFERENCES perusopintolinja(nimi)
);
	

/* KURSSIT JA TOTEUTUKSET */

/**
 * kurssi-taulussa on tiedot kaikista opetettavista kursseista.
 * 
 * @param	tunnus	(PK)	Kurssin lyhennetty tunnus, esim. ICT1TN003.
 * @param	nimi			Kurssin virallinen nimi.
 * @param	laajuus			Kurssin opintopistemäärä.
 * @param	ajoitus			Lukukausi, jona kurssi on ajateltu suoritettavaksi.
 * @param	kuvaus			Kurssin kuvaus. TÄMÄN ON TÄRKEÄÄ OLLA LAADUKAS!
 */
DROP TABLE IF EXISTS kurssi;
CREATE TABLE kurssi (
    tunnus             CHAR(9)      NOT NULL,
	nimi               VARCHAR(255) NOT NULL,
	koulutusohjelma_ID TINYINT      NOT NULL,
	laajuus            TINYINT      NOT NULL,
	ajoitus            TINYINT      NOT NULL,
	kuvaus             TEXT         NOT NULL,
	PRIMARY KEY (tunnus),
	FOREIGN KEY (koulutusohjelma_ID) REFERENCES koulutusohjelma(ID)
);


/**
 * toteutus-taulussa on listattuna kaikki kurssitoteutukset ja niiden tarkemmat tiedot.
 * 
 * @param	kurssi_tunnus (PK,FK)			Toteutettava kurssi.
 * @param	toteutusnro (PK)			Toteutuksen järjestysnumero.
 * @param	periodi (FK)				Periodi, jona toteutus järjestetään.
 * @param	suoritustapa (FK)			Toteutuksen suoritustapa (lähi, etä, monimuoto yms).
 * @param	kieli (FK)				Toteutuksella käytettävä opetuskieli.
 * @param	lisatiedot				Toteutuksen mahdolliset erityispiirteet. Voi olla tyhjä.
 */
DROP TABLE IF EXISTS toteutus;
CREATE TABLE toteutus (
	ID                  SMALLINT      NOT NULL AUTO_INCREMENT,
    kurssi_tunnus       CHAR(9)       NOT NULL,
	toteutusnro         SMALLINT      NOT NULL,
	periodi      	    VARCHAR(255)  NOT NULL,
    toimipiste_ID       TINYINT       NOT NULL,
	suoritustapa        VARCHAR(255)  NOT NULL,
	kieli               VARCHAR(255)  NOT NULL,
	lisatiedot          TEXT,
	PRIMARY KEY (ID),
	FOREIGN KEY (kurssi_tunnus) REFERENCES kurssi(tunnus),
	FOREIGN KEY (periodi)       REFERENCES periodi(nimi)      ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (toimipiste_ID) REFERENCES toimipiste(ID),
	FOREIGN KEY (suoritustapa)  REFERENCES suoritustapa(nimi) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (kieli)         REFERENCES kieli(nimi)        ON DELETE RESTRICT ON UPDATE CASCADE
);

/**
 * lahiopetuskerta-taulun yksi rivi on aina yksi oppitunti.
 * 
 * @param	ID (PK)			Automaattisesti kasvava pääavain.
 * @param	pvm				Opetuskerran päivämäärä.
 * @param	alkuklo			Opetuskerran alkukellonaika.
 * @param	loppuklo		Opetuskerran loppukellonaika.
 * @param	luokkatila (FK)	Luokkatila, jossa tunti pidetään.
 * @param	lisatiedot		Mahdolliset lisätiedot oppitunnista.
 */

DROP TABLE IF EXISTS lahiopetuskerta;
CREATE TABLE lahiopetuskerta (
	ID                SMALLINT     NOT NULL AUTO_INCREMENT,
    toteutus_ID       SMALLINT     NOT NULL,
    luokkatila_tunnus VARCHAR(5)   NOT NULL,               /* jos esim. virtuaalikurssi, luokkatilaa ei tietenkään ole */
    toimipiste_ID     TINYINT      NOT NULL,               /* jos esim. virtuaalikurssi, luokkatilaa ei tietenkään ole */
	pvm               DATE         NOT NULL,
	alkuklo           TIME         NOT NULL,
	loppuklo          TIME         NOT NULL,
	lisatiedot TINYTEXT,                                    /* voi jättää tyhjäksi jos ilmoitettavaa ei ole, huom. max 255 merkkiä! */
	PRIMARY KEY (ID),
	FOREIGN KEY (toteutus_ID)       REFERENCES toteutus(ID),
	FOREIGN KEY (luokkatila_tunnus) REFERENCES luokkatila(tunnus),
    FOREIGN KEY (toimipiste_ID)     REFERENCES luokkatila(toimipiste_ID)
);

DROP TABLE IF EXISTS arvosana;
CREATE TABLE arvosana (
    symboli char(1) NOT NULL,
	kuvaus VARCHAR(255) ,
	PRIMARY KEY (symboli)
);


/**
 * osallistuminen-taulussa on tiedot toteutukselle osallistuvista opiskelijoista.
 * 
 * @param	toteutus (FK)		Kurssitoteutus, jolle osallistutaan.
 * @param	opiskelijanro (FK)	Osallistuvan opiskelijan opiskelijanumero.
 * @param	suoritustila (FK)	Onko ilmoittauduttu, vai jo huolittu mukaan kurssille?
 * @param	arvosana			Kurssin suorittamisen jälkeen merkittävä kurssiarvosana. Aluksi tyhjä.
 */
DROP TABLE IF EXISTS osallistuminen;
CREATE TABLE osallistuminen (
    opiskelijanro CHAR(7)  NOT NULL,
	toteutus_ID   SMALLINT NOT NULL,
	suoritustila  CHAR(1)  NOT NULL,
	arvosana      CHAR(1),             /* Arvosana on null, kunnes opettaja merkitsee sen */
	PRIMARY KEY (opiskelijanro, toteutus_ID), 
    FOREIGN KEY (opiskelijanro) REFERENCES opiskelija(opiskelijanro),
    FOREIGN KEY (toteutus_ID)   REFERENCES toteutus(ID), 
	FOREIGN KEY (suoritustila)  REFERENCES suoritustila(symboli),
    FOREIGN KEY (arvosana)      REFERENCES arvosana(symboli) 
);

/**
 * arvosana-taulussa on lueteltu sallitut arvosanat.
 * 
 * @param       symboli         Arvosanan symboli 1,2,3,4,5,H.
 * @param	kuvaus		Arvosanan kuvaus: 1=Välttävä,...,5=Erinomainen,H=Hyväksytty.		
 */


/**
 * kurssipalaute-tauluun tallentuvat opiskelijoiden toteutuksista antamat numeeriset ja sanalliset palautteet.
 * 
 * @param	toteutus (PK,FK)		Arvosteltava kurssitoteutus.
 * @param	opiskelijanro (PK,FK)	        Palautteen antaneen opiskelijan opiskelijanumero.
 * @param	arvosana			Toteutuksesta annettu arvosana yhdestä viiteen.
 * @param	palaute				Tekstimuotoinen, vapaa, RAKENTAVA palaute.
 */
DROP TABLE IF EXISTS kurssipalaute;
CREATE TABLE kurssipalaute (
	toteutus_ID      SMALLINT     NOT NULL,
	opiskelijanro    CHAR(7)      NOT NULL,
	arvosana         TINYINT      NOT NULL CHECK(arvosana BETWEEN 1 AND 5),
	/* Erilaisia arvosanoja voisi olla enemmänkin, mutta mennään yksinkertaisella
	kaavalla jossa toteutukselle voi antaa ainoastaan yleisarvosanan */
	palaute          TEXT         NOT NULL,
    PRIMARY KEY (toteutus_ID, opiskelijanro), 
	FOREIGN KEY (toteutus_ID) REFERENCES toteutus(ID), 
	FOREIGN KEY (opiskelijanro) REFERENCES opiskelija(opiskelijanro) 
);

/* MUITA VÄLITAULUJA */

/**
 * lahtotasovaatimus-taulu on välitaulu jonkin kurssin ja sille osallistumista edellyttävien
 * edeltävien suoritettujen kurssien välille.
 * 
 * @param	kurssi (FK)		Kurssi, jolle haluttaisiin osallistua.
 * @param	vaadittava (FK)	Kurssi, josta vaaditaan (tai mielellään vaadittaisiin) suoritus.
 */
DROP TABLE IF EXISTS lahtotasovaatimus;
CREATE TABLE lahtotasovaatimus (
	kurssi_tunnus            CHAR(9) NOT NULL,
	vaadittava_kurssi_tunnus CHAR(9) NOT NULL,
    PRIMARY KEY (kurssi_tunnus, vaadittava_kurssi_tunnus),
	FOREIGN KEY (kurssi_tunnus)            REFERENCES kurssi(tunnus) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (vaadittava_kurssi_tunnus) REFERENCES kurssi(tunnus) ON DELETE CASCADE ON UPDATE CASCADE
);

/**
 * vastuuopettaja-taulu on välitaulu jonkin kurssin ja sen vastuuopettajien välille.
 * 
 * @param	kurssi (PK,FK)			Kurssi, jonka vastuuopettajia haetaan.
 * @param	vastuuopettaja (FK)      	Henkilökunnan jäsen, joka kurssin vastuuopettajana toimii.
 */
DROP TABLE IF EXISTS vastuuopettaja;
CREATE TABLE vastuuopettaja (
	kurssi_tunnus        CHAR(9) NOT NULL,
	vastuuopettaja_nro   CHAR(5) NOT NULL,
    PRIMARY KEY (kurssi_tunnus),
	FOREIGN KEY (kurssi_tunnus)      REFERENCES kurssi(tunnus)                 ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (vastuuopettaja_nro) REFERENCES henkilokunta(hlokuntanro)      ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS perusopintolinjan_kurssi;
CREATE TABLE perusopintolinjan_kurssi (
	perusopintolinja   VARCHAR(255)   NOT NULL,
	koulutusohjelma_ID TINYINT        NOT NULL,
	kurssi_tunnus      CHAR(9)        NOT NULL,
	opintotaso         VARCHAR(255)   NOT NULL,
	opintotyyppi       VARCHAR(255)   NOT NULL,
	ajoitus            TINYINT        NOT NULL,
	PRIMARY KEY (perusopintolinja, koulutusohjelma_ID, kurssi_tunnus),
	FOREIGN KEY (perusopintolinja)   REFERENCES perusopintolinja(nimi),
	FOREIGN KEY (koulutusohjelma_ID) REFERENCES perusopintolinja(koulutusohjelma_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (kurssi_tunnus)      REFERENCES kurssi(tunnus)                       ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (opintotaso)         REFERENCES opintotaso(nimi)                     ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (opintotyyppi)       REFERENCES opintotyyppi(nimi)                   ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE IF EXISTS suuntautumisen_kurssi;
CREATE TABLE suuntautumisen_kurssi (
	suuntautuminen     VARCHAR(255)   NOT NULL,
	koulutusohjelma_ID TINYINT        NOT NULL,
	perusopintolinja   VARCHAR(255)   NOT NULL,
	kurssi_tunnus      CHAR(9)        NOT NULL,
	opintotaso         VARCHAR(255)   NOT NULL,
	opintotyyppi       VARCHAR(255)   NOT NULL,
	ajoitus            TINYINT        NOT NULL,
	PRIMARY KEY (suuntautuminen, koulutusohjelma_ID, perusopintolinja, kurssi_tunnus),
	FOREIGN KEY (suuntautuminen)     REFERENCES suuntautuminen(nimi),
	FOREIGN KEY (koulutusohjelma_ID) REFERENCES suuntautuminen(koulutusohjelma_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (perusopintolinja)   REFERENCES suuntautuminen(perusopintolinja)   ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (kurssi_tunnus)      REFERENCES kurssi(tunnus)                     ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (opintotaso)         REFERENCES opintotaso(nimi)                   ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (opintotyyppi)       REFERENCES opintotyyppi(nimi)                 ON DELETE RESTRICT ON UPDATE CASCADE
);

DROP TABLE IF EXISTS hops_suunniteltu_toteutus;
CREATE TABLE hops_suunniteltu_toteutus (
	opiskelijanro   CHAR(7)   NOT NULL,
	kurssi_tunnus   CHAR(9)   NOT NULL,
	toteutus_ID     SMALLINT  NOT NULL,
	PRIMARY KEY (opiskelijanro, kurssi_tunnus, toteutus_ID),
	FOREIGN KEY (opiskelijanro) REFERENCES opiskelija(opiskelijanro),
	FOREIGN KEY (kurssi_tunnus) REFERENCES toteutus(kurssi_tunnus),
	FOREIGN KEY (toteutus_ID)   REFERENCES toteutus(ID)
);

DROP TABLE IF EXISTS hops_suunniteltu_kurssi;
CREATE TABLE hops_suunniteltu_kurssi (
	opiskelijanro   CHAR(7)   NOT NULL,
	kurssi_tunnus   CHAR(9)   NOT NULL,
	ajoitus         TINYINT   NOT NULL,
	PRIMARY KEY (opiskelijanro, kurssi_tunnus),
	FOREIGN KEY (opiskelijanro) REFERENCES opiskelija(opiskelijanro),
	FOREIGN KEY (kurssi_tunnus) REFERENCES kurssi(tunnus)
);

/*	----------------------	*/
/*	MIETITTÄVIÄ ASIOITA	 	*/
/*	----------------------	*/

/* 	- Pitäisikö opiskelijalle merkitä ryhmä näkyviin? Opiskelija ei välttämättä seuraa "omalle" ryhmälleen
	suunniteltua lukujärjestystä.
	- En osaa yhtään sanoa, onko koko suuntautumiskurssi-taulu hyödyllinen. Jos on, kurssi-taulussa saattaa
	olla vähän liikaa tavaraa.
	- Käsittääkö lähiopetuskerta-taulu ainoastaan toteutukset, joilla on lähiopetusta? Onko virtuaalikursseille
	määritelty lukujärjestykseen jotain oppitunnin ajankohtaa, vaikkei sellaista oikeasti olekaan?
	- Tarvitseeko scriptin lopussa oleviin tauluihin lisätä erillistä autoinkrementoivaa pääavainta?
	Kasvavatko taulut niin isoiksi, että siitä olisi hyötyä suorituskyvyn kannalta?
	- Jokaisen viiteavaimen poisto- ja päivitysehdot voi tietysti vielä miettiä erikseen.
	- Tietokanta tarvitsee vielä ainakin käyttäjätasot/roolit Spring Securityä varten.
	- Muuta?
*/

/*	----------------------	*/
/*	POISTETTUJA LAUSEITA 	*/
/*	----------------------	*/
/*
DROP TABLE IF EXISTS kurssitaulukko;
CREATE TABLE kurssitaulukko (
	ID              INTEGER   NOT NULL AUTO_INCREMENT,
	koulutusohjelma TINYINT   NOT NULL,
	opintotaso      TINYINT   NOT NULL,
	opintotyyppi    TINYINT   NOT NULL,
	suuntautuminen  SMALLINT,
	kurssi          SMALLINT  NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (koulutusohjelma) REFERENCES koulutusohjelma(ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (opintotaso) REFERENCES opintotaso(ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (opintotyyppi) REFERENCES opintotyyppi(ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (suuntautuminen) REFERENCES suuntautuminen(ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (kurssi) REFERENCES kurssi(ID) ON DELETE RESTRICT ON UPDATE CASCADE
);
*/
/**
 * suuntautumiskurssi-taulu on välitaulu eri suuntautumisvaihtoehdoille, mikäli esimerkiksi
 * jokin kurssi olisi jossakin suuntautumisessa pakollinen ja jossain toisessa valinnainen.
 * 
 * @param	ID (PK)				Automaattisesti kasvava pääavain.
 * @param	suuntautuminen (FK)	Suuntautumisvaihtoehto, johon viitataan.
 * @param	kurssi (FK)			Kurssi, johon viitataan.
 * @param	tyyppi (FK)			Opintotyyppi, johon viitataan.
 */
/* DROP TABLE IF EXISTS suuntautumiskurssi;
CREATE TABLE suuntautumiskurssi (
	ID				SMALLINT		NOT NULL AUTO_INCREMENT,
	suuntautuminen	SMALLINT		NOT NULL,
	kurssi			SMALLINT		NOT NULL,
	tyyppi			TINYINT			NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (suuntautuminen) REFERENCES suuntautuminen(ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (kurssi) REFERENCES kurssi(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (tyyppi) REFERENCES opintotyyppi(ID) ON DELETE RESTRICT ON UPDATE CASCADE
); */

/**
 * kurssinsuoritustapa-taulu on välitaulu jonkin kurssin ja sen erilaisten suoritustapojen välille.
 * 
 * @param	kurssi (FK)			Kurssi, jonka suoritustapavaihtoehtoja haetaan.
 * @param	suoritustapa (FK)	Suoritustapa, jona kurssia toteutetaan.
 
DROP TABLE IF EXISTS kurssinsuoritustapa;
CREATE TABLE kurssinsuoritustapa (
	kurssi       SMALLINT  NOT NULL,
	suoritustapa TINYINT   NOT NULL,
	FOREIGN KEY (kurssi) REFERENCES kurssi(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (suoritustapa) REFERENCES suoritustapa(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

/**
 * kurssinopetuspaikka-taulu on välitaulu jonkin kurssin ja niiden toimipisteiden, joissa
 * kurssia opetetaan, välille.
 * 
 * @param	kurssi (FK)		Kurssi, jonka toimipisteitä haetaan.
 * @param	toimipiste (FK)	Toimipiste, jossa kurssia opetetaan.
 */
DROP TABLE IF EXISTS kurssinopetuspaikka;
CREATE TABLE kurssinopetuspaikka (
	kurssi     SMALLINT NOT NULL,
	toimipiste TINYINT  NOT NULL,
	FOREIGN KEY (kurssi) REFERENCES kurssi(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (toimipiste) REFERENCES toimipiste(ID) ON DELETE CASCADE ON UPDATE CASCADE
);
*/