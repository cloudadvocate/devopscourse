package com.cloudadvocate.bookmanager.ui;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.cloudadvocate.bookmanager.controller.BookManagerController;

//https://www.geeksforgeeks.org/spring-boot-thymeleaf-with-example/

@Controller
public class BookManagerUIController {

	@Autowired
	private BookManagerController bookManagerController;

	@GetMapping("/")
	public String viewHomePage(Model model) {
		model.addAttribute("allbooks", this.bookManagerController.getAllbooks(null).getBody());
		return "index";
	}

}
