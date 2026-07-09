package com.attendance.service;

import com.attendance.entity.Teacher;

import java.util.List;

public interface TeacherService {
    
    Teacher findById(Integer id);
    
    Teacher login(String teacherNo, String password);
    
    List<Teacher> findAll();
    
    void add(Teacher teacher);
    
    void update(Teacher teacher);
    
    void deleteById(Integer id);
}
