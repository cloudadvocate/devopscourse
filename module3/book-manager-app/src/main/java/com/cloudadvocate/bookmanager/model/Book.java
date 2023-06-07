package com.cloudadvocate.bookmanager.model;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
@Table(name = "book")
public class Book {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;

	@Column(name = "title")
	@NotBlank(message = "Title is mandatory")
	private String title;

	@Column(name = "description")
	@NotBlank(message = "Description is mandatory")
	private String description;

	@Column(name = "published")
	private boolean published = false;

	public Book() {

	}

	public Book(String title, String description, boolean published) {
		this.title = title;
		this.description = description;
		this.published = published;
	}

	public Book(long id, String title, String description, boolean published) {
		this.id = id;
		this.title = title;
		this.description = description;
		this.published = published;
	}

	public long getId() {
		return id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean isPublished() {
		return published;
	}

	public void setPublished(boolean isPublished) {
		this.published = isPublished;
	}

	@Override
	public String toString() {
		return "Tutorial [id=" + id + ", title=" + title + ", desc=" + description + ", published=" + published + "]";
	}

}
