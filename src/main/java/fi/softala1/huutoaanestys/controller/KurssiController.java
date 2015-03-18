package fi.softala1.huutoaanestys.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import fi.softala1.huutoaanestys.bean.Kurssi;
import fi.softala1.huutoaanestys.dao.KurssiDAO;

@RestController
public class KurssiController {
	
	@Inject
	KurssiDAO kDao;
	
	@RequestMapping("kurssit.json")
	public List<Kurssi> haeKurssitJSON() {
		List<Kurssi> kurssit = kDao.haeKurssit();
		return kurssit;
	}

}
