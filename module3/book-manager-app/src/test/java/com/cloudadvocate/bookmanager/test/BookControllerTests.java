package com.cloudadvocate.bookmanager.test;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import com.cloudadvocate.bookmanager.controller.BookManagerController;
import com.cloudadvocate.bookmanager.model.Book;
import com.cloudadvocate.bookmanager.repository.BookManagerRepository;
import com.fasterxml.jackson.databind.ObjectMapper;

@WebMvcTest(BookManagerController.class)
public class BookControllerTests {
	@MockBean
	private BookManagerRepository bookRepository;

	@Autowired
	private MockMvc mockMvc;

	@Autowired
	private ObjectMapper objectMapper;

	@Test
	void shouldCreatebook() throws Exception {
		Book book = new Book(1, "Spring Boot @WebMvcTest", "Description", true);

		mockMvc.perform(post("/api/books").contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(book))).andExpect(status().isCreated()).andDo(print());
	}

	@Test
	void shouldCreatebookException() throws Exception {
		Book book = new Book(1, "Spring Boot @WebMvcTest", "Description", true);

		when(bookRepository.save(any(Book.class))).thenThrow(new RuntimeException("Invalid Reposiotry"));

		mockMvc.perform(post("/api/books").contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(book))).andExpect(status().isInternalServerError());
	}

	@Test
	void shouldReturnbook() throws Exception {
		long id = 1L;
		Book book = new Book(id, "Spring Boot @WebMvcTest", "Description", true);

		when(bookRepository.findById(id)).thenReturn(Optional.of(book));
		mockMvc.perform(get("/api/books/{id}", id)).andExpect(status().isOk()).andExpect(jsonPath("$.id").value(id))
				.andExpect(jsonPath("$.title").value(book.getTitle()))
				.andExpect(jsonPath("$.description").value(book.getDescription()))
				.andExpect(jsonPath("$.published").value(book.isPublished())).andDo(print());
	}

	@Test
	void shouldReturnbooksByPublished() throws Exception {
		long id = 1L;
		Book book = new Book(id, "Spring Boot @WebMvcTest", "Description", true);
		List<Book> books = new ArrayList<>();
		books.add(book);
		when(bookRepository.findByPublished(true)).thenReturn(books);
		mockMvc.perform(get("/api/books/published")).andExpect(status().isOk());
	}

	@Test
	void shouldReturnbooksByPublishedException() throws Exception {
		when(bookRepository.findByPublished(true)).thenThrow(new RuntimeException("Invalid book repository"));
		mockMvc.perform(get("/api/books/published")).andExpect(status().isInternalServerError());
	}

	@Test
	void shouldReturnbooksByPublishedEmptyBookes() throws Exception {
		long id = 1L;
		List<Book> books = new ArrayList<>();
		when(bookRepository.findByPublished(true)).thenReturn(books);
		mockMvc.perform(get("/api/books/published")).andExpect(status().is(HttpStatus.NO_CONTENT.value()));
	}

	@Test
	void shouldReturnNotFoundbook() throws Exception {
		long id = 1L;

		when(bookRepository.findById(id)).thenReturn(Optional.empty());
		mockMvc.perform(get("/api/books/{id}", id)).andExpect(status().isNotFound()).andDo(print());
	}

	@Test
	void shouldReturnListOfbooks() throws Exception {
		List<Book> books = new ArrayList<>(
				Arrays.asList(new Book(1, "Spring Boot @WebMvcTest 1", "Description 1", true),
						new Book(2, "Spring Boot @WebMvcTest 2", "Description 2", true),
						new Book(3, "Spring Boot @WebMvcTest 3", "Description 3", true)));

		when(bookRepository.findAll()).thenReturn(books);
		mockMvc.perform(get("/api/books")).andExpect(status().isOk())
				.andExpect(jsonPath("$.size()").value(books.size())).andDo(print());
	}

	@Test
	void shouldReturnListOfbooksException() throws Exception {
		when(bookRepository.findAll()).thenThrow(new RuntimeException("Invalid repository"));
		mockMvc.perform(get("/api/books")).andExpect(status().isInternalServerError());
	}

	@Test
	void shouldReturnListOfbooksWithFilter() throws Exception {
		List<Book> books = new ArrayList<>(Arrays.asList(new Book(1, "Spring Boot @WebMvcTest", "Description 1", true),
				new Book(3, "Spring Boot Web MVC", "Description 3", true)));

		String title = "Boot";
		MultiValueMap<String, String> paramsMap = new LinkedMultiValueMap<>();
		paramsMap.add("title", title);

		when(bookRepository.findByTitleContaining(title)).thenReturn(books);
		mockMvc.perform(get("/api/books").params(paramsMap)).andExpect(status().isOk())
				.andExpect(jsonPath("$.size()").value(books.size())).andDo(print());
	}

	@Test
	void shouldReturnNoContentWhenFilter() throws Exception {
		String title = "BezKoder";
		MultiValueMap<String, String> paramsMap = new LinkedMultiValueMap<>();
		paramsMap.add("title", title);

		List<Book> books = Collections.emptyList();

		when(bookRepository.findByTitleContaining(title)).thenReturn(books);
		mockMvc.perform(get("/api/books").params(paramsMap)).andExpect(status().isNoContent()).andDo(print());
	}

	@Test
	void shouldUpdatebook() throws Exception {
		long id = 1L;

		Book book = new Book(id, "Spring Boot @WebMvcTest", "Description", false);
		Book updatedbook = new Book(id, "Updated", "Updated", true);

		when(bookRepository.findById(id)).thenReturn(Optional.of(book));
		when(bookRepository.save(any(Book.class))).thenReturn(updatedbook);

		mockMvc.perform(put("/api/books/{id}", id).contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(updatedbook))).andExpect(status().isOk())
				.andExpect(jsonPath("$.title").value(updatedbook.getTitle()))
				.andExpect(jsonPath("$.description").value(updatedbook.getDescription()))
				.andExpect(jsonPath("$.published").value(updatedbook.isPublished())).andDo(print());
	}

	@Test
	void shouldReturnNotFoundUpdatebook() throws Exception {
		long id = 1L;

		Book updatedbook = new Book(id, "Updated", "Updated", true);

		when(bookRepository.findById(id)).thenReturn(Optional.empty());
		when(bookRepository.save(any(Book.class))).thenReturn(updatedbook);

		mockMvc.perform(put("/api/books/{id}", id).contentType(MediaType.APPLICATION_JSON)
				.content(objectMapper.writeValueAsString(updatedbook))).andExpect(status().isNotFound()).andDo(print());
	}

	@Test
	void shouldDeletebook() throws Exception {
		long id = 1L;

		doNothing().when(bookRepository).deleteById(id);
		mockMvc.perform(delete("/api/books/{id}", id)).andExpect(status().isNoContent()).andDo(print());
	}

	@Test
	void shouldDeletebookException() throws Exception {
		long id = 1L;
		doThrow(new RuntimeException("Invalid Repository")).when(bookRepository).deleteById(id);
		mockMvc.perform(delete("/api/books/{id}", id)).andExpect(status().isInternalServerError()).andDo(print());
	}

	@Test
	void shouldDeleteAllbooks() throws Exception {
		doNothing().when(bookRepository).deleteAll();
		mockMvc.perform(delete("/api/books")).andExpect(status().isNoContent()).andDo(print());
	}

	@Test
	void shouldDeleteAllbooksException() throws Exception {
		doThrow(new RuntimeException("Invalid Repository")).when(bookRepository).deleteAll();
		mockMvc.perform(delete("/api/books")).andExpect(status().isInternalServerError()).andDo(print());
	}
}
