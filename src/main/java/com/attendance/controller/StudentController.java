package com.attendance.controller;

import com.attendance.entity.Attendance;
import com.attendance.entity.Course;
import com.attendance.entity.Student;
import com.attendance.service.AttendanceService;
import com.attendance.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private CourseService courseService;

    @Autowired
    private AttendanceService attendanceService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        List<Course> courses = courseService.findByStudentId(student.getId());
        model.addAttribute("courses", courses);
        return "student/dashboard";
    }

    @GetMapping("/attendance")
    public String attendanceRecords(HttpSession session, Model model) {
        Student student = (Student) session.getAttribute("user");
        if (student == null) {
            return "redirect:/login";
        }
        List<Attendance> attendances = attendanceService.findByStudentId(student.getId());
        model.addAttribute("attendances", attendances);
        return "student/attendance-records";
    }
}
