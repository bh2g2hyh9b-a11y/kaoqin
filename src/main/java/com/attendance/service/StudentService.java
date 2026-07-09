package com.attendance.service;

import com.attendance.entity.Student;

import java.util.List;

public interface StudentService {
    
    Student findById(Integer id);
    
    Student login(String studentNo, String password);
    
    List<Student> findAll();
    
    List<Student> findByCourseId(Integer courseId);
    
    void add(Student student);
    
    void update(Student student);
    
    void deleteById(Integer id);
}
