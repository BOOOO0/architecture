package org.boo0.server.service;

import jakarta.transaction.Transactional;
import org.boo0.server.domain.Todo;
import org.boo0.server.dto.PageRequestDTO;
import org.boo0.server.dto.PageResponseDTO;
import org.boo0.server.dto.TodoDTO;

@Transactional
public interface TodoService {

    TodoDTO get(Long tno);
    Long register(TodoDTO dto);
    void modify(TodoDTO dto);
    void remove(Long tno);

    PageResponseDTO<TodoDTO> getList(PageRequestDTO pageRequestDTO);

    default TodoDTO entityToDTO(Todo todo){

        return TodoDTO.builder()
                .tno(todo.getTno())
                .title(todo.getTitle())
                .content(todo.getContent())
                .complete(todo.isComplete())
                .dueDate(todo.getDueDate())
                .build();

    }

    default Todo dtoToEntity(TodoDTO todoDTO){

        return Todo.builder()
                .tno(todoDTO.getTno())
                .title(todoDTO.getTitle())
                .content(todoDTO.getContent())
                .complete(todoDTO.isComplete())
                .dueDate(todoDTO.getDueDate())
                .build();
    }
}
