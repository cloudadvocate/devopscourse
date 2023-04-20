package com.cloudadvocate.bookmanager.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cloudadvocate.bookmanager.model.Book;

public interface BookManagerRepository extends JpaRepository<Book, Long> {
  
  List<Book> findByPublished(boolean published);

  List<Book> findByTitleContaining(String title);

}
