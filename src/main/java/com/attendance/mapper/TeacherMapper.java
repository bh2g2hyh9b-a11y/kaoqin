package com.attendance.mapper;

import com.attendance.entity.Teacher;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TeacherMapper {
    // 根据 id 查询教师
    Teacher findById(@Param("id") Integer id);
    // 根据教师工号查询
    Teacher findByTeacherNo(@Param("teacherNo") String teacherNo);
    // 查询所有教师
    List<Teacher> findAll();
    // 新增教师
    int insert(Teacher teacher);
    
    int update(Teacher teacher);
    
    int deleteById(@Param("id") Integer id);
}
