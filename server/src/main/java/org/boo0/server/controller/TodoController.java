package org.boo0.server.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.boo0.server.dto.PageRequestDTO;
import org.boo0.server.dto.PageResponseDTO;
import org.boo0.server.dto.TodoDTO;
import org.boo0.server.service.TodoService;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/api/todo")
public class TodoController {

    private final TodoService todoService;

    @GetMapping("/{tno}")
    public TodoDTO get(@PathVariable("tno") Long tno){

        return todoService.get(tno);
    }

    @GetMapping("/list")
    public PageResponseDTO<TodoDTO> getList(PageRequestDTO pageRequestDTO){
        log.info("list.................." + pageRequestDTO);

        return todoService.getList(pageRequestDTO);
    }

    @PostMapping("/")
    public Map<String, Long> register(@RequestBody TodoDTO todoDTO){
        log.info("todoDTO: " + todoDTO);

        Long tno = todoService.register(todoDTO);

        return Map.of("TNO",tno);
    }

    @PutMapping("/{tno}")
    public Map<String, String> modify(@PathVariable("tno") Long tno, @RequestBody TodoDTO todoDTO){

        todoDTO.setTno(tno);

        todoService.modify(todoDTO);

        return Map.of("RESULT", "SUCCESS");
    }

    @DeleteMapping("/{tno}")
    public Map<String, String> remove(@PathVariable("tno") Long tno){
        todoService.remove(tno);

        return Map.of("RESULT", "SUCCESS");
    }
}
