<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>教师工作台 - 学生考勤管理系统</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background: #f5f5f5;
        }
        .header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            font-size: 24px;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .logout-btn {
            background: rgba(255,255,255,0.2);
            color: white;
            padding: 8px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .logout-btn:hover {
            background: rgba(255,255,255,0.3);
        }
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }
        .welcome {
            background: white;
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .welcome h2 {
            color: #333;
            margin-bottom: 10px;
        }
        .welcome p {
            color: #666;
        }
        .section-title {
            font-size: 20px;
            color: #333;
            margin-bottom: 20px;
        }
        .course-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        .course-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
        }
        .course-card h3 {
            color: #333;
            margin-bottom: 10px;
        }
        .course-card p {
            color: #666;
            margin-bottom: 15px;
            font-size: 14px;
        }
        .course-actions {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            transition: opacity 0.2s;
        }
        .btn:hover {
            opacity: 0.8;
        }
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-secondary {
            background: #95a5a6;
            color: white;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>学生考勤管理系统</h1>
        <div class="user-info">
            <span>欢迎，${user.name}老师</span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出登录</a>
        </div>
    </div>
    <div class="container">
        <div class="welcome">
            <h2>欢迎回来，${user.name}老师！</h2>
            <p>这里是您的工作台，您可以查看和管理您负责的课程。</p>
        </div>
        <h3 class="section-title">我的课程</h3>
        <div class="course-list">
            <c:forEach items="${courses}" var="course">
                <div class="course-card">
                    <h3>${course.courseName}</h3>
                    <p>课程编号：${course.courseNo}</p>
                    <p>学分：${course.credit} | 学时：${course.hours}</p>
                    <div class="course-actions">
                        <a href="${pageContext.request.contextPath}/teacher/course/${course.id}/attendance" class="btn btn-primary">考勤</a>
                        <a href="${pageContext.request.contextPath}/teacher/course/${course.id}/records" class="btn btn-secondary">查看记录</a>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty courses}">
                <p style="color: #888;">暂无课程</p>
            </c:if>
        </div>
    </div>
</body>
</html>
