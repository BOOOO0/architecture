package org.boo0.server.repository.search;

import com.querydsl.jpa.JPQLQuery;
import lombok.extern.log4j.Log4j2;
import org.boo0.server.domain.QTodo;
import org.boo0.server.domain.Todo;
import org.boo0.server.dto.PageRequestDTO;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;

import java.util.List;
@Log4j2
public class TodoSearchImpl extends QuerydslRepositorySupport  implements TodoSearch{

    /**
     * Creates a new {@link QuerydslRepositorySupport} instance for the given domain type.
     *
     * @param domainClass must not be {@literal null}.
     */
    public TodoSearchImpl() {
        super(Todo.class);
    }

    @Override
    public Page<Todo> search1(PageRequestDTO pageRequestDTO) {

        log.info("search1......................");

//        query를 날리기 위한 객체?
        QTodo todo = QTodo.todo;
//        todo를 상속 받아서 쿼리를 날릴거다??
        JPQLQuery<Todo> query = from(todo);

        Pageable pageable = PageRequest.of(
                pageRequestDTO.getPage() -1,
                pageRequestDTO.getSize(),
                Sort.by("tno").descending());

        this.getQuerydsl().applyPagination(pageable, query);

//        목록 데이터 가져올 때 사용
        List<Todo> list = query.fetch();

//        fetch로 가져온 데이터 Count
        long total = query.fetchCount();

        return new PageImpl<>(list, pageable, total);
    }
}
