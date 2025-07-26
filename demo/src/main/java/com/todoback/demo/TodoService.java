// TodoService.java
package com.todoback.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class TodoService {

    @Autowired
    private TodoRepository repository;

    public List<Todo> getAllTodos() {
        return repository.findAll();
    }

    public Todo createTodo(String title) {
        Todo todo = new Todo(title);
        todo.setCompleted(false);
        todo.setDate(LocalDateTime.now());
        return repository.save(todo);
    }

    public Todo updateTodo(Long id, boolean completed) {
        Optional<Todo> optionalTodo = repository.findById(id);
        if (optionalTodo.isPresent()) {
            Todo todo = optionalTodo.get();
            todo.setCompleted(completed);
            return repository.save(todo);
        } else {
            throw new RuntimeException("Todo not found with id " + id);
        }
    }

    public void deleteTodo(Long id) {
        repository.deleteById(id);
    }
}
