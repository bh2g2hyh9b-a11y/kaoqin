package com.attendance.service.impl;

import com.attendance.entity.Student;
import com.attendance.mapper.StudentMapper;
import com.attendance.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;

    @Override
    public Student findById(Integer id) {
        return studentMapper.findById(id);
    }

    @Override
    public Student login(String studentNo, String password) {
        Student student = studentMapper.findByStudentNo(studentNo);
        if (student != null && student.getPassword().equals(password)) {
            return student;
        }
        return null;
    }

    @Override
    public List<Student> findAll() {
        return studentMapper.findAll();
    }

    @Override
    public List<Student> findByCourseId(Integer courseId) {
        return studentMapper.findByCourseId(courseId);
    }

    @Override
    public void add(Student student) {
        studentMapper.insert(student);
    }

    @Override
    public void update(Student student) {
        studentMapper.update(student);
    }

    @Override
    public void deleteById(Integer id) {
        studentMapper.deleteById(id);
    }
}
