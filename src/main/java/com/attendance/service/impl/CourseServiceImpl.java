package com.attendance.service.impl;

import com.attendance.entity.Course;
import com.attendance.mapper.CourseMapper;
import com.attendance.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CourseServiceImpl implements CourseService {

    @Autowired
    private CourseMapper courseMapper;

    @Override
    public Course findById(Integer id) {
        return courseMapper.findById(id);
    }

    @Override
    public List<Course> findAll() {
        return courseMapper.findAll();
    }

    @Override
    public List<Course> findByTeacherId(Integer teacherId) {
        return courseMapper.findByTeacherId(teacherId);
    }

    @Override
    public List<Course> findByStudentId(Integer studentId) {
        return courseMapper.findByStudentId(studentId);
    }

    @Override
    public void add(Course course) {
        courseMapper.insert(course);
    }

    @Override
    public void update(Course course) {
        courseMapper.update(course);
    }

    @Override
    public void deleteById(Integer id) {
        courseMapper.deleteById(id);
    }
}
