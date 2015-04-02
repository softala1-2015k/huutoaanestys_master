package fi.softala1.huutoaanestys.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import fi.softala1.huutoaanestys.bean.Kurssi;
import fi.softala1.huutoaanestys.exception.TietoRiviaEiLoydyPoikkeus;

/**
 * KurssiDAO-luokka on vastuussa tietokantahauista, joiden tulokset tallennetaan
 * Kurssi-beaneihin.
 * 
 * @author Atte Valtonen
 *
 */
@Repository
public class KurssiDAOImpl implements KurssiDAO {
	
	@Inject
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	
	/**
	 * Etsii tietokannasta jonkin tietyn kurssin.
	 * 
	 * @param  tunnus  Ottaa parametrina kurssin tunnuksen.
	 * @return Palauttaa halutun kurssin.
	 * 
	 * @author Atte Valtonen
	 */

	public Kurssi etsiKurssi(String tunnus) {
		String sql = "SELECT tunnus, nimi, koulutusohjelma_ID, laajuus, "
				+ "ajoitus, kuvaus FROM kurssi WHERE tunnus = ?";
		
		Object[] parametrit = new Object[] { tunnus };
		RowMapper<Kurssi> mapper = new KurssiRowMapper();

		Kurssi k;
		try {
			k = jdbcTemplate.queryForObject(sql, parametrit, mapper);
		} catch (IncorrectResultSizeDataAccessException e) {
			throw new TietoRiviaEiLoydyPoikkeus(e);
		}
		return k;

	}
	
	/**
	 * Noutaa tietokannasta kaikki kurssit.
	 * 
	 * @return Palauttaa listauksen kaikista kursseista.
	 * 
	 * @author Atte Valtonen
	 */

	public List<Kurssi> haeKurssit() {

		String sql = "SELECT tunnus, nimi, koulutusohjelma_ID, laajuus, "
				+ "ajoitus, kuvaus FROM kurssi";
		
		RowMapper<Kurssi> mapper = new KurssiRowMapper();
		List<Kurssi> kurssit = jdbcTemplate.query(sql, mapper);

		return kurssit;
	}

}
