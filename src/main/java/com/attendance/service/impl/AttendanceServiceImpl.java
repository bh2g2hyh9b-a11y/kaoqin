package com.attendance.service.impl;

import com.attendance.entity.Attendance;
import com.attendance.mapper.AttendanceMapper;
import com.attendance.service.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class AttendanceServiceImpl implements AttendanceService {

    @Autowired
    private AttendanceMapper attendanceMapper;

    @Override
    public Attendance findById(Integer id) {
        return attendanceMapper.findById(id);
    }

    @Override
    public List<Attendance> findAll() {
        return attendanceMapper.findAll();
    }

    @Override
    public List<Attendance> findByStudentId(Integer studentId) {
        return attendanceMapper.findByStudentId(studentId);
    }

    @Override
    public List<Attendance> findByCourseId(Integer courseId) {
        return attendanceMapper.findByCourseId(courseId);
    }

    @Override
    public List<Attendance> findByCourseIdAndDate(Integer courseId, Date attendanceDate) {
        return attendanceMapper.findByCourseIdAndDate(courseId, attendanceDate);
    }

    @Override
    public void takeAttendance(Integer studentId, Integer courseId, Date attendanceDate, String status, String remark) {
        Attendance existing = attendanceMapper.findByStudentIdAndCourseIdAndDate(studentId, courseId, attendanceDate);
        if (existing != null) {
            existing.setStatus(status);
            existing.setRemark(remark);
            attendanceMapper.update(existing);
        } else {
            Attendance attendance = new Attendance();
            attendance.setStudentId(studentId);
            attendance.setCourseId(courseId);
            attendance.setAttendanceDate(attendanceDate);
            attendance.setAttendanceTime(new Date());
            attendance.setStatus(status);
            attendance.setRemark(remark);
            attendanceMapper.insert(attendance);
        }
    }

    @Override
    public void update(Attendance attendance) {
        attendanceMapper.update(attendance);
    }

    @Override
    public void deleteById(Integer id) {
        attendanceMapper.deleteById(id);
    }
}
