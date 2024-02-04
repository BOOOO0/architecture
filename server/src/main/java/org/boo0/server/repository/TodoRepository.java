package org.boo0.server.repository;

import org.boo0.server.repository.search.TodoSearch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.boo0.server.domain.Todo;

public interface TodoRepository extends JpaRepository<Todo, Long>, TodoSearch {

}
