<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的考勤记录 - 学生考勤管理系统</title>
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
        .summary {
            display: flex;
            gap: 30px;
            margin-bottom: 30px;
        }
        .summary-item {
            background: #f8f9fa;
            padding: 20px 30px;
            border-radius: 8px;
            text-align: center;
        }
        .summary-item .number {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 8px;
        }
        .summary-item .label {
            color: #666;
            font-size: 14px;
        }
        .summary-item.normal .number { color: #27ae60; }
        .summary-item.late .number { color: #f39c12; }
        .summary-item.absent .number { color: #e74c3c; }
        .summary-item.leave .number { color: #3498db; }
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
            <span>欢迎，${user.name}同学</span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">退出登录</a>
        </div>
    </div>
    <div class="container">
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/student/dashboard">首页</a> > 我的考勤记录
        </div>
        <div class="card">
            <h2>我的考勤记录</h2>
            
            <c:set var="normalCount" value="0" />
            <c:set var="lateCount" value="0" />
            <c:set var="absentCount" value="0" />
            <c:set var="leaveCount" value="0" />
            <c:forEach items="${attendances}" var="attendance">
                <c:if test="${attendance.status == 'normal'}">
                    <c:set var="normalCount" value="${normalCount + 1}" />
                </c:if>
                <c:if test="${attendance.status == 'late'}">
                    <c:set var="lateCount" value="${lateCount + 1}" />
                </c:if>
                <c:if test="${attendance.status == 'absent'}">
                    <c:set var="absentCount" value="${absentCount + 1}" />
                </c:if>
                <c:if test="${attendance.status == 'leave'}">
                    <c:set var="leaveCount" value="${leaveCount + 1}" />
                </c:if>
            </c:forEach>
            
            <div class="summary">
                <div class="summary-item normal">
                    <div class="number">${normalCount}</div>
                    <div class="label">正常</div>
                </div>
                <div class="summary-item late">
                    <div class="number">${lateCount}</div>
                    <div class="label">迟到</div>
                </div>
                <div class="summary-item absent">
                    <div class="number">${absentCount}</div>
                    <div class="label">缺勤</div>
                </div>
                <div class="summary-item leave">
                    <div class="number">${leaveCount}</div>
                    <div class="label">请假</div>
                </div>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>日期</th>
                        <th>课程</th>
                        <th>状态</th>
                        <th>签到时间</th>
                        <th>备注</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${attendances}" var="attendance">
                        <tr>
                            <td><fmt:formatDate value="${attendance.attendanceDate}" pattern="yyyy-MM-dd"/></td>
                            <td>${attendance.courseName}</td>
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
                            <td colspan="5" style="text-align: center; color: #888;">暂无考勤记录</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
            <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-secondary back-btn">返回</a>
        </div>
    </div>
</body>
</html>
