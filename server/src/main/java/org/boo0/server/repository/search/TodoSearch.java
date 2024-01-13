package org.boo0.server.repository.search;

import org.boo0.server.domain.Todo;
import org.boo0.server.dto.PageRequestDTO;
import org.springframework.data.domain.Page;

public interface TodoSearch {

    Page<Todo> search1(PageRequestDTO pageRequestDTO);
}
