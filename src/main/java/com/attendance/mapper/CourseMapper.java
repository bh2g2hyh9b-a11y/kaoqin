package com.attendance.mapper;

import com.attendance.entity.Course;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CourseMapper {
    
    Course findById(@Param("id") Integer id);
    
    List<Course> findAll();
    
    List<Course> findByTeacherId(@Param("teacherId") Integer teacherId);
    
    List<Course> findByStudentId(@Param("studentId") Integer studentId);
    
    int insert(Course course);
    
    int update(Course course);
    
    int deleteById(@Param("id") Integer id);
}
