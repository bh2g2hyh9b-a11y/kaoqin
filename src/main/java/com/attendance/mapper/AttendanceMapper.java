package com.attendance.mapper;

import com.attendance.entity.Attendance;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface AttendanceMapper {
    
    Attendance findById(@Param("id") Integer id);
    
    List<Attendance> findAll();
    
    List<Attendance> findByStudentId(@Param("studentId") Integer studentId);
    
    List<Attendance> findByCourseId(@Param("courseId") Integer courseId);
    
    List<Attendance> findByCourseIdAndDate(@Param("courseId") Integer courseId, @Param("attendanceDate") Date attendanceDate);
    
    Attendance findByStudentIdAndCourseIdAndDate(@Param("studentId") Integer studentId, 
                                                  @Param("courseId") Integer courseId, 
                                                  @Param("attendanceDate") Date attendanceDate);
    
    int insert(Attendance attendance);
    
    int update(Attendance attendance);
    
    int deleteById(@Param("id") Integer id);
}
