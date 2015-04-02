package fi.softala1.huutoaanestys.dao;

import java.util.List;

import fi.softala1.huutoaanestys.bean.Kurssi;

public interface KurssiDAO {

	/**
	 * Etsii tietokannasta jonkin tietyn kurssin.
	 * 
	 * @param  tunnus  Ottaa parametrina kurssin tunnuksen.
	 * @return Palauttaa halutun kurssin.
	 * 
	 * @author Atte Valtonen
	 */
	public abstract Kurssi etsiKurssi(String tunnus);

	/**
	 * Noutaa tietokannasta kaikki kurssit.
	 * 
	 * @return Palauttaa listauksen kaikista kursseista.
	 * 
	 * @author Atte Valtonen
	 */
	public abstract List<Kurssi> haeKurssit();

}