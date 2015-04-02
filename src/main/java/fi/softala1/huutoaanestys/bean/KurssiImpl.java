package fi.softala1.huutoaanestys.bean;

/**
 * 
 * Kurssi-luokka säilöö järjestelmästä kaivettavan kurssin tiedot itseensä.
 * 
 * @param  tunnus              Kurssitunnus (esim. ICT1TN001).
 * @param  nimi                Kurssin nimi (Työasemat ja tietoverkot).
 * @param  koulutusohjelma_ID  Viittaus koulutusohjelmaan, johon kurssi kuuluu.
 * @param  laajuus             Opintopistemäärä, jonka kurssista nettoaa.
 * @param  ajoitus             Lukukausi, jona kurssi on suositeltavaa käydä.
 * @param  kuvaus              Kurssikuvaus (olisi suositeltavaa refaktoroida).
 * 
 * @author Atte Valtonen
 *
 */
public class KurssiImpl implements Kurssi {
	
	private String tunnus;
	private String nimi;
	private int koulutusohjelma_ID;
	private int laajuus;
	private int ajoitus;
	private String kuvaus;
	
	public KurssiImpl(String tunnus, String nimi, int koulutusohjelma_ID,
			int laajuus, int ajoitus, String kuvaus) {
		this.tunnus = tunnus;
		this.nimi = nimi;
		this.koulutusohjelma_ID = koulutusohjelma_ID;
		this.laajuus = laajuus;
		this.ajoitus = ajoitus;
		this.kuvaus = kuvaus;
	}
	
	public KurssiImpl() {
		this.tunnus = "";
		this.nimi = "";
		this.koulutusohjelma_ID = 0;
		this.laajuus = 0;
		this.ajoitus = 0;
		this.kuvaus = "";
	}

	public String getTunnus() {
		return tunnus;
	}

	public String getNimi() {
		return nimi;
	}

	public int getKoulutusohjelma_ID() {
		return koulutusohjelma_ID;
	}

	public int getLaajuus() {
		return laajuus;
	}

	public int getAjoitus() {
		return ajoitus;
	}

	public String getKuvaus() {
		return kuvaus;
	}


	public void setTunnus(String tunnus) {
		this.tunnus = tunnus;
	}

	public void setNimi(String nimi) {
		this.nimi = nimi;
	}

	public void setKoulutusohjelma_ID(int koulutusohjelma_ID) {
		this.koulutusohjelma_ID = koulutusohjelma_ID;
	}

	public void setLaajuus(int laajuus) {
		this.laajuus = laajuus;
	}

	public void setAjoitus(int ajoitus) {
		this.ajoitus = ajoitus;
	}

	public void setKuvaus(String kuvaus) {
		this.kuvaus = kuvaus;
	}
	
	@Override
	public String toString() {
		return "KURSSI: " + tunnus + " - " + nimi + " - " + laajuus + " OP";
	}

}
