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

	@Override
	public String getTunnus() {
		return tunnus;
	}
	@Override
	public String getNimi() {
		return nimi;
	}
	@Override
	public int getKoulutusohjelma_ID() {
		return koulutusohjelma_ID;
	}
	@Override
	public int getLaajuus() {
		return laajuus;
	}
	@Override
	public int getAjoitus() {
		return ajoitus;
	}
	@Override
	public String getKuvaus() {
		return kuvaus;
	}

	@Override
	public void setTunnus(String tunnus) {
		this.tunnus = tunnus;
	}
	@Override
	public void setNimi(String nimi) {
		this.nimi = nimi;
	}
	@Override
	public void setKoulutusohjelma_ID(int koulutusohjelma_ID) {
		this.koulutusohjelma_ID = koulutusohjelma_ID;
	}
	@Override
	public void setLaajuus(int laajuus) {
		this.laajuus = laajuus;
	}
	@Override
	public void setAjoitus(int ajoitus) {
		this.ajoitus = ajoitus;
	}
	@Override
	public void setKuvaus(String kuvaus) {
		this.kuvaus = kuvaus;
	}
	
	@Override
	public String toString() {
		return "KURSSI: " + tunnus + " - " + nimi + " - " + laajuus + " OP";
	}

}
