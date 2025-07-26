// Todo.java
package com.todoback.demo;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
public class Todo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private boolean completed = false;

    private LocalDateTime date = LocalDateTime.now();

    // Constructors
    public Todo() {}

    public Todo(String title) {
        this.title = title;
        this.date = LocalDateTime.now();
    }

    // Getters and setters
    public Long getId() { return id; }
    public String getTitle() { return title; }
    public boolean isCompleted() { return completed; }
    public LocalDateTime getDate() { return date; }

    public void setId(Long id) { this.id = id; }
    public void setTitle(String title) { this.title = title; }
    public void setCompleted(boolean completed) { this.completed = completed; }
    public void setDate(LocalDateTime date) { this.date = date; }
}
