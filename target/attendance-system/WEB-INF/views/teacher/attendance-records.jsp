<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>考勤记录 - 学生考勤管理系统</title>
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
        .breadcrumb {
            margin-bottom: 20px;
        }
        .breadcrumb a {
            color: #667eea;
            text-decoration: none;
        }
        .breadcrumb a:hover {
            text-decoration: underline;
        }
        .card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .card h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .btn {
            padding: 8px 20px;
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
        .btn-secondary {
            background: #95a5a6;
            color: white;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        th {
            background: #f8f9fa;
            color: #333;
            font-weight: 500;
        }
        tr:hover {
            background: #f8f9fa;
        }
        .status-normal {
            color: #27ae60;
            font-weight: 500;
        }
        .status-late {
            color: #f39c12;
            font-weight: 500;
        }
        .status-absent {
            color: #e74c3c;
            font-weight: 500;
        }
        .status-leave {
            color: #3498db;
            font-weight: 500;
        }
        .back-btn {
            margin-top: 20px;
            display: inline-block;
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
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/teacher/dashboard">首页</a> > ${course.courseName} > 考勤记录
        </div>
        <div class="card">
            <h2>${course.courseName} - 考勤记录</h2>
            <table>
                <thead>
                    <tr>
                        <th>日期</th>
                        <th>学号</th>
                        <th>姓名</th>
                        <th>状态</th>
                        <th>签到时间</th>
                        <th>备注</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${attendances}" var="attendance">
                        <tr>
                            <td><fmt:formatDate value="${attendance.attendanceDate}" pattern="yyyy-MM-dd"/></td>
                            <td>${attendance.studentNo}</td>
                            <td>${attendance.studentName}</td>
                            <td>
                                <span class="status-${attendance.status}">
                                    <c:choose>
                                        <c:when test="${attendance.status == 'normal'}">正常</c:when>
                                        <c:when test="${attendance.status == 'late'}">迟到</c:when>
                                        <c:when test="${attendance.status == 'absent'}">缺勤</c:when>
                                        <c:when test="${attendance.status == 'leave'}">请假</c:when>
                                    </c:choose>
                                </span>
                            </td>
                            <td><fmt:formatDate value="${attendance.attendanceTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>${attendance.remark}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty attendances}">
                        <tr>
                            <td colspan="6" style="text-align: center; color: #888;">暂无考勤记录</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
            <a href="${pageContext.request.contextPath}/teacher/dashboard" class="btn btn-secondary back-btn">返回</a>
        </div>
    </div>
</body>
</html>
