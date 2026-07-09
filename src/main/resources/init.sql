-- 创建数据库
CREATE DATABASE IF NOT EXISTS attendance_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE attendance_system;

-- 教师表
CREATE TABLE IF NOT EXISTS teacher (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '教师ID',
    teacher_no VARCHAR(20) UNIQUE NOT NULL COMMENT '教师工号',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    password VARCHAR(100) NOT NULL COMMENT '密码',
    gender VARCHAR(10) COMMENT '性别',
    phone VARCHAR(20) COMMENT '电话',
    email VARCHAR(100) COMMENT '邮箱',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师表';

-- 学生表
CREATE TABLE IF NOT EXISTS student (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '学生ID',
    student_no VARCHAR(20) UNIQUE NOT NULL COMMENT '学号',
    name VARCHAR(50) NOT NULL COMMENT '姓名',
    password VARCHAR(100) NOT NULL COMMENT '密码',
    gender VARCHAR(10) COMMENT '性别',
    class_name VARCHAR(50) COMMENT '班级',
    major VARCHAR(100) COMMENT '专业',
    phone VARCHAR(20) COMMENT '电话',
    email VARCHAR(100) COMMENT '邮箱',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生表';

-- 课程表
CREATE TABLE IF NOT EXISTS course (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '课程ID',
    course_no VARCHAR(20) UNIQUE NOT NULL COMMENT '课程编号',
    course_name VARCHAR(100) NOT NULL COMMENT '课程名称',
    credit DECIMAL(3,1) COMMENT '学分',
    hours INT COMMENT '学时',
    teacher_id INT COMMENT '授课教师ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (teacher_id) REFERENCES teacher(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程表';

-- 学生选课表
CREATE TABLE IF NOT EXISTS student_course (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT 'ID',
    student_id INT NOT NULL COMMENT '学生ID',
    course_id INT NOT NULL COMMENT '课程ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    UNIQUE KEY uk_student_course (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生选课表';

-- 考勤记录表
CREATE TABLE IF NOT EXISTS attendance (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '考勤ID',
    student_id INT NOT NULL COMMENT '学生ID',
    course_id INT NOT NULL COMMENT '课程ID',
    attendance_date DATE NOT NULL COMMENT '考勤日期',
    attendance_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '签到时间',
    status VARCHAR(20) NOT NULL COMMENT '状态：normal(正常)/late(迟到)/absent(缺勤)/leave(请假)',
    remark VARCHAR(200) COMMENT '备注',
    FOREIGN KEY (student_id) REFERENCES student(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考勤记录表';

-- 插入测试数据
INSERT INTO teacher (teacher_no, name, password, gender, phone, email) VALUES
('T001', '张老师', '123456', '男', '13800138001', 'zhang@example.com'),
('T002', '李老师', '123456', '女', '13800138002', 'li@example.com');

INSERT INTO student (student_no, name, password, gender, class_name, major, phone, email) VALUES
('240904099', '张三', '123456', '男', '软工2班', '软件工程', '13900139001', 'zhangsan@example.com'),
('240909078', '李四', '123456', '女', '软工2班', '软件工程', '13900139002', 'lisi@example.com'),
('240906574', '王五', '123456', '男', '计科2班', '计算机科学与技术', '13900139003', 'wangwu@example.com'),
('240904088', '赵六', '123456', '女', '计科1班', '计算机科学与技术', '13900139004', 'zhaoliu@example.com');

INSERT INTO course (course_no, course_name, credit, hours, teacher_id) VALUES
('C001', 'Java程序设计', 4.0, 64, 1),
('C002', '数据库原理', 3.5, 56, 2),
('C003', '数据结构', 4.0, 64, 1);

INSERT INTO student_course (student_id, course_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 1), (2, 2),
(3, 1), (3, 3),
(4, 2), (4, 3);
