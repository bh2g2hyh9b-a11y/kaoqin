package com.attendance.controller;

import com.attendance.entity.Student;
import com.attendance.entity.Teacher;
import com.attendance.service.StudentService;
import com.attendance.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller  // 这个注解告诉 Spring：这是一个 Controller
@RequestMapping
public class LoginController {

    // 这里就是依赖注入！Spring 自动把 TeacherService 注入进来
    @Autowired
    private TeacherService teacherService;

    @Autowired
    private StudentService studentService;

    @GetMapping("/")
    public String index() {
        return "login";
    }

    // @GetMapping：处理 GET 请求，比如浏览器直接输入 /login
    @GetMapping("/login")
    public String loginPage() {
        return "login";
        // 返回 "login"，视图解析器变成 /WEB-INF/views/login.jsp
    }

    // @PostMapping：处理 POST 请求，比如表单提交
    @PostMapping("/login")
    public String login(@RequestParam("userType") String userType,
                        @RequestParam("username") String username,
                        @RequestParam("password") String password,
                        HttpSession session,  // Session 用来存用户信息
                        Model model) {
        // 判断是教师登录还是学生登录
        if ("teacher".equals(userType)) {
            // 调用 Service 查询教师
            Teacher teacher = teacherService.login(username, password);
            if (teacher != null) {
                // 登录成功，把教师信息存入 Session
                session.setAttribute("user", teacher);
                session.setAttribute("userType", "teacher");
                // 重定向到教师工作台
                return "redirect:/teacher/dashboard";
            }
        } else if ("student".equals(userType)) {
            // 学生登录逻辑类似
            Student student = studentService.login(username, password);
            if (student != null) {
                session.setAttribute("user", student);
                session.setAttribute("userType", "student");
                return "redirect:/student/dashboard";
            }
        }
        model.addAttribute("error", "用户名或密码错误");
        // 登录失败，回到登录页
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
