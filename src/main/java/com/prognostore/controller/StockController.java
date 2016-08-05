package com.prognostore.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.bind.annotation.RequestParam;
import org.joda.time.LocalDate;

@Controller
@RequestMapping("/stock")
public class StockController {

    // Quandl webservice
	public static final String QUANDL_API_URI = "https://www.quandl.com/api/v3/datasets/WIKI/%s/data.json?column_index=4&sort_order=asc&start_date=%s&end_date=%s&api_key=owxk_SBg8-zzkVmU5noM";

	@RequestMapping(value={"/", "/home"})
	public String home() {
 		return "home";
 	}

 	@RequestMapping(value="/stockinfo", method = RequestMethod.GET)
    public ResponseEntity<String> stockinfo(@RequestParam(value="symbol", defaultValue="AAPL") String symbol) {

        // This calculates the first official day (Monday) of a given week
        LocalDate firstDayOfWeek = new LocalDate().weekOfWeekyear().roundFloorCopy();

        // Start Date = firstDayOfWeek - 7
    	LocalDate startDate = firstDayOfWeek.minusDays(7);
        
        // End Date = firstDayOfWeek - 3
    	LocalDate endDate = firstDayOfWeek.minusDays(3);

    	RestTemplate restTemplate = new RestTemplate();

        String results = restTemplate.getForObject(String.format(QUANDL_API_URI, symbol, startDate, endDate), String.class);

        return new ResponseEntity<String>(results, HttpStatus.OK);
    }
}