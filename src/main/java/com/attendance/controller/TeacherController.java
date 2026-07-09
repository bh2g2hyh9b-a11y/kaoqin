package com.attendance.controller;

import com.attendance.entity.Attendance;
import com.attendance.entity.Course;
import com.attendance.entity.Student;
import com.attendance.entity.Teacher;
import com.attendance.service.AttendanceService;
import com.attendance.service.CourseService;
import com.attendance.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/teacher")
public class TeacherController {

    @Autowired
    private CourseService courseService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private AttendanceService attendanceService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("user");
        if (teacher == null) {
            return "redirect:/login";
        }
        List<Course> courses = courseService.findByTeacherId(teacher.getId());
        model.addAttribute("courses", courses);
        return "teacher/dashboard";
    }

    @GetMapping("/course/{courseId}")
    public String courseDetail(@PathVariable Integer courseId, HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("user");
        if (teacher == null) {
            return "redirect:/login";
        }
        Course course = courseService.findById(courseId);
        List<Student> students = studentService.findByCourseId(courseId);
        model.addAttribute("course", course);
        model.addAttribute("students", students);
        return "teacher/course-detail";
    }

    @GetMapping("/course/{courseId}/attendance")
    public String attendancePage(@PathVariable Integer courseId,
                                 @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date date,
                                 HttpSession session,
                                 Model model) {
        Teacher teacher = (Teacher) session.getAttribute("user");
        if (teacher == null) {
            return "redirect:/login";
        }
        Course course = courseService.findById(courseId);
        List<Student> students = studentService.findByCourseId(courseId);
        
        if (date == null) {
            date = new Date();
        }
        
        List<Attendance> attendances = attendanceService.findByCourseIdAndDate(courseId, date);
        
        model.addAttribute("course", course);
        model.addAttribute("students", students);
        model.addAttribute("attendances", attendances);
        model.addAttribute("date", new SimpleDateFormat("yyyy-MM-dd").format(date));
        return "teacher/attendance";
    }

    @PostMapping("/course/{courseId}/attendance")
    public String saveAttendance(@PathVariable Integer courseId,
                                 @RequestParam("date") @DateTimeFormat(pattern = "yyyy-MM-dd") Date date,
                                 @RequestParam("studentId") List<Integer> studentIds,
                                 @RequestParam("status") List<String> statuses,
                                 @RequestParam(value = "remark", required = false) List<String> remarks,
                                 HttpSession session) {
        Teacher teacher = (Teacher) session.getAttribute("user");
        if (teacher == null) {
            return "redirect:/login";
        }
        
        for (int i = 0; i < studentIds.size(); i++) {
            String status = statuses.get(i);
            String remark = (remarks != null && i < remarks.size()) ? remarks.get(i) : "";
            attendanceService.takeAttendance(studentIds.get(i), courseId, date, status, remark);
        }
        
        return "redirect:/teacher/course/" + courseId + "/attendance?date=" + new SimpleDateFormat("yyyy-MM-dd").format(date);
    }

    @GetMapping("/course/{courseId}/records")
    public String attendanceRecords(@PathVariable Integer courseId, HttpSession session, Model model) {
        Teacher teacher = (Teacher) session.getAttribute("user");
        if (teacher == null) {
            return "redirect:/login";
        }
        Course course = courseService.findById(courseId);
        List<Attendance> attendances = attendanceService.findByCourseId(courseId);
        model.addAttribute("course", course);
        model.addAttribute("attendances", attendances);
        return "teacher/attendance-records";
    }
}
