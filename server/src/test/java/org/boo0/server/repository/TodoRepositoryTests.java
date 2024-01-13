package org.boo0.server.repository;

import lombok.extern.log4j.Log4j2;
import org.boo0.server.domain.Todo;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.time.LocalDate;
import java.util.Optional;

@SpringBootTest
@Log4j2
public class TodoRepositoryTests {
    @Autowired
    private TodoRepository todoRepository;

    @Test
    public void test1(){
        Assertions.assertNotNull(todoRepository);

        log.info(todoRepository.getClass().getName());
    }

    @Test
    public void testInsert(){
        final Todo todo = Todo.builder()
                .title("Title")
                .content("Content...")
                .dueDate(LocalDate.of(2023,12, 30))
                .build();

        Todo result = todoRepository.save(todo);

        log.info(result);
    }

    @Test
    public void testRead(){
        Long tno = 1L;
        
//        Id에 해당하는 값이 없을 수도 있으니까
        Optional<Todo> result = todoRepository.findById(tno);

        Todo todo = result.orElseThrow();

        log.info(todo);
    }

    @Test
    public void testUpdate(){
        // 일단 레코드를 읽어온다. 그럼 그 레코드는 여기서는 객체 그럼 그 객체 변경하고 저장
//        JPA가 추구하는게 이런거라고 하네
//
        Long tno = 1L;

//        Id에 해당하는 값이 없을 수도 있으니까
        Optional<Todo> result = todoRepository.findById(tno);

        Todo todo = result.orElseThrow();

        todo.changeTitle("Updated Title");
        todo.changeContent("Updated Content");
        todo.changeComplete(true);
        todo.changeDueDate(LocalDate.of(2024, 1, 13));

        todoRepository.save(todo);
    }

    @Test
    public void testPaging(){
//        page 번호는 0부터 시작한다.
        Pageable pageable = PageRequest.of(0,10, Sort.by("tno").descending());

        Page<Todo> result = todoRepository.findAll(pageable);

        log.info(result.getTotalElements());

        log.info(result.getContent());

    }

//    @Test
//    public void testSearch1(){
//        todoRepository.search1();
//    }
}
