package fi.softala1.huutoaanestys.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import fi.softala1.huutoaanestys.bean.Kurssi;
import fi.softala1.huutoaanestys.bean.KurssiImpl;

/**
 * KurssiRowMapper-luokan tehtävänä on irrottaa sille annetusta ResultSet-
 * oliosta yhden rivin tietueet (sille annetun rivinumeron perustella) ja
 * asettaa ne Kurssi-luokan olioon, joka palautetaan käyttöön.
 * 
 * @author Atte Valtonen
 *
 */
public class KurssiRowMapper implements RowMapper<Kurssi> {

	public Kurssi mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		Kurssi k = new KurssiImpl();
		k.setTunnus(rs.getString("tunnus"));
		k.setNimi(rs.getString("nimi"));
		k.setKoulutusohjelma_ID(rs.getInt("koulutusohjelma_ID"));
		k.setLaajuus(rs.getInt("laajuus"));
		k.setAjoitus(rs.getInt("ajoitus"));
		k.setKuvaus(rs.getString("kuvaus"));
		
		return k;
	}

}
