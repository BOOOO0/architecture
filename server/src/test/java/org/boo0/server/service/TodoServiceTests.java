package org.boo0.server.service;

import lombok.extern.log4j.Log4j2;
import org.boo0.server.dto.PageRequestDTO;
import org.boo0.server.dto.TodoDTO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;

@SpringBootTest
@Log4j2
public class TodoServiceTests {

    @Autowired
    TodoService todoService;

    @Test
    public void testGet(){
        Long tno = 1L;

        log.info(todoService.get(tno));
    }

    @Test
    public void testRegister(){
        TodoDTO todoDTO = TodoDTO.builder()
                .title("ALALALALALAL")
                .content("Content....asalskdjkl")
                .dueDate(LocalDate.of(2024,1,13))
                .build();

        log.info(todoService.register(todoDTO));
    }

    @Test void testGetList(){
        PageRequestDTO pageRequestDTO = PageRequestDTO.builder().build();

        log.info(todoService.getList(pageRequestDTO));
    }
}
