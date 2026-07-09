package com.attendance.service.impl;

import com.attendance.entity.Teacher;
import com.attendance.mapper.TeacherMapper;
import com.attendance.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service  // 这是一个 Service，Spring 会自动管理
@Transactional
public class TeacherServiceImpl implements TeacherService {
    // 自动注入 Mapper
    @Autowired
    private TeacherMapper teacherMapper;

    @Override
    public Teacher findById(Integer id) {
        // 直接调用 Mapper 方法
        return teacherMapper.findById(id);
    }

    @Override
    public Teacher login(String teacherNo, String password) {
        Teacher teacher = teacherMapper.findByTeacherNo(teacherNo);
        if (teacher != null && teacher.getPassword().equals(password)) {
            return teacher;
        }
        return null;
    }

    @Override
    public List<Teacher> findAll() {

        return teacherMapper.findAll();
    }

    @Override
    public void add(Teacher teacher) {
        teacherMapper.insert(teacher);
    }

    @Override
    public void update(Teacher teacher) {
        teacherMapper.update(teacher);
    }

    @Override
    public void deleteById(Integer id) {
        teacherMapper.deleteById(id);
    }
}
