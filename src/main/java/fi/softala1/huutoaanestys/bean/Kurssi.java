package fi.softala1.huutoaanestys.bean;

public interface Kurssi {

	public abstract String getTunnus();

	public abstract String getNimi();

	public abstract int getKoulutusohjelma_ID();

	public abstract int getLaajuus();

	public abstract int getAjoitus();

	public abstract String getKuvaus();

	public abstract void setTunnus(String tunnus);

	public abstract void setNimi(String nimi);

	public abstract void setKoulutusohjelma_ID(int koulutusohjelma_ID);

	public abstract void setLaajuus(int laajuus);

	public abstract void setAjoitus(int ajoitus);

	public abstract void setKuvaus(String kuvaus);

}