package com.attendance.mapper;

import com.attendance.entity.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudentMapper {
    
    Student findById(@Param("id") Integer id);
    
    Student findByStudentNo(@Param("studentNo") String studentNo);
    
    List<Student> findAll();
    
    List<Student> findByCourseId(@Param("courseId") Integer courseId);
    
    int insert(Student student);
    
    int update(Student student);
    
    int deleteById(@Param("id") Integer id);
}
