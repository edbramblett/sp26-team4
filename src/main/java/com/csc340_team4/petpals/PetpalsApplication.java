package com.csc340_team4.petpals;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = "com.csc340_team4.petpals")
public class PetpalsApplication {

	public static void main(String[] args) {
		SpringApplication.run(PetpalsApplication.class, args);
	}

}
