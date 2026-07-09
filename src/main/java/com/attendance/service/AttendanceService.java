package com.attendance.service;

import com.attendance.entity.Attendance;

import java.util.Date;
import java.util.List;

public interface AttendanceService {
    
    Attendance findById(Integer id);
    
    List<Attendance> findAll();
    
    List<Attendance> findByStudentId(Integer studentId);
    
    List<Attendance> findByCourseId(Integer courseId);
    
    List<Attendance> findByCourseIdAndDate(Integer courseId, Date attendanceDate);
    
    void takeAttendance(Integer studentId, Integer courseId, Date attendanceDate, String status, String remark);
    
    void update(Attendance attendance);
    
    void deleteById(Integer id);
}
