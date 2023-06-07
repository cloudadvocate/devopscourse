package com.cloudadvocate.bookmanager.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import com.cloudadvocate.bookmanager.model.Book;
import com.cloudadvocate.bookmanager.repository.BookManagerRepository;

@Component
public class BookManagerService {

	@Autowired
	private BookManagerRepository bookManagerRepository;

	public static Logger log = LoggerFactory.getLogger(BookManagerService.class);

	@EventListener(ApplicationReadyEvent.class)
	public void addInitialBooks() {

		log.info("Bootstraping initial data");

		List<Book> books = new ArrayList<>();

		Book book1 = new Book("ABSALOM, ABSALOM! BY WILLIAM FAULKNER",
				"This quotation for Faulkner’s 1936 novel comes from the Books of Samuel – more specifically, 19:4 in 2 Samuel, which is in the Old Testament and relates some of the history of Israel",
				true);
		books.add(book1);

		Book book2 = new Book("A TIME TO KILL BY JOHN GRISHAM",
				"This one is from 3:3 in the Ecclesiastes, again part of the Old Testament. The anonymous author is a King of Jerusalem who relates and analyses events in his own life.",
				false);

		books.add(book2);

		this.bookManagerRepository.saveAll(books);

	}

}
