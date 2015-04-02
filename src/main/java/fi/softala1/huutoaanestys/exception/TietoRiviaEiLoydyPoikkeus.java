package fi.softala1.huutoaanestys.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@SuppressWarnings("serial")
@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class TietoRiviaEiLoydyPoikkeus extends RuntimeException {
	
	public TietoRiviaEiLoydyPoikkeus(Exception aiheuttaja) {
		super(aiheuttaja);
	}

}
