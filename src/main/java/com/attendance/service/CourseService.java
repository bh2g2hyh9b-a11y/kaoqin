package com.attendance.service;

import com.attendance.entity.Course;

import java.util.List;

public interface CourseService {
    
    Course findById(Integer id);
    
    List<Course> findAll();
    
    List<Course> findByTeacherId(Integer teacherId);
    
    List<Course> findByStudentId(Integer studentId);
    
    void add(Course course);
    
    void update(Course course);
    
    void deleteById(Integer id);
}
