<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>考勤 - 学生考勤管理系统</title>
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
            margin-bottom: 30px;
        }
        .card h2 {
            color: #333;
            margin-bottom: 20px;
        }
        .date-selector {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .date-selector input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
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
        .btn-primary {
            background: #667eea;
            color: white;
        }
        .btn-secondary {
            background: #95a5a6;
            color: white;
        }
        table {
            width: 100%;
            border-collapse: collapse;
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
        select {
            padding: 6px 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        input[type="text"] {
            padding: 6px 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 150px;
        }
        .status-normal {
            color: #27ae60;
        }
        .status-late {
            color: #f39c12;
        }
        .status-absent {
            color: #e74c3c;
        }
        .status-leave {
            color: #3498db;
        }
        .actions {
            margin-top: 20px;
            display: flex;
            gap: 10px;
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
            <a href="${pageContext.request.contextPath}/teacher/dashboard">首页</a> > ${course.courseName} > 考勤
        </div>
        <div class="card">
            <h2>${course.courseName} - 考勤</h2>
            <form id="dateForm" method="get">
                <div class="date-selector">
                    <label>选择日期：</label>
                    <input type="date" name="date" value="${date}" id="dateInput">
                    <button type="submit" class="btn btn-secondary">查询</button>
                </div>
            </form>
            <form action="${pageContext.request.contextPath}/teacher/course/${course.id}/attendance" method="post">
                <input type="hidden" name="date" value="${date}">
                <table>
                    <thead>
                        <tr>
                            <th>学号</th>
                            <th>姓名</th>
                            <th>状态</th>
                            <th>备注</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${students}" var="student">
                            <c:set var="attendance" value="${null}" />
                            <c:forEach items="${attendances}" var="a">
                                <c:if test="${a.studentId == student.id}">
                                    <c:set var="attendance" value="${a}" />
                                </c:if>
                            </c:forEach>
                            <tr>
                                <td>${student.studentNo}</td>
                                <td>${student.name}</td>
                                <td>
                                    <input type="hidden" name="studentId" value="${student.id}">
                                    <select name="status">
                                        <option value="normal" ${attendance != null && attendance.status == 'normal' ? 'selected' : ''}>正常</option>
                                        <option value="late" ${attendance != null && attendance.status == 'late' ? 'selected' : ''}>迟到</option>
                                        <option value="absent" ${attendance != null && attendance.status == 'absent' ? 'selected' : ''}>缺勤</option>
                                        <option value="leave" ${attendance != null && attendance.status == 'leave' ? 'selected' : ''}>请假</option>
                                    </select>
                                </td>
                                <td>
                                    <input type="text" name="remark" value="${attendance != null ? attendance.remark : ''}" placeholder="备注">
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="actions">
                    <button type="submit" class="btn btn-primary">保存考勤</button>
                    <a href="${pageContext.request.contextPath}/teacher/dashboard" class="btn btn-secondary">返回</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
