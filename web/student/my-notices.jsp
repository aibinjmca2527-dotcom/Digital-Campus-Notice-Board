<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.noticeboard.model.User, com.noticeboard.dao.NoticeDAO, java.util.List, com.noticeboard.model.Notice" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    User user = (User) session.getAttribute("loggedUser");
    NoticeDAO dao = new NoticeDAO();
    List<Notice> myNotices = dao.getNoticesByUser(user.getId());
    String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Notices | NoticePro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<nav class="navbar">
    <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand">
        <div class="logo-icon">📋</div><span>NoticePro</span>
    </a>
    <ul class="navbar-nav">
        <li><span style="color:rgba(255,255,255,0.7); font-size:0.88rem;">👋 <%= user.getFullName() %></span></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-nav">Logout</a></li>
    </ul>
</nav>

<div class="layout-sidebar">
    <aside class="sidebar">
        <p class="sidebar-section-title">Student Menu</p>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/student/dashboard.jsp"><span class="nav-icon">🏠</span> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/viewNotices"><span class="nav-icon">📌</span> Notice Board</a></li>
            <li><a href="${pageContext.request.contextPath}/student/submit-notice.jsp"><span class="nav-icon">✏️</span> Submit Notice</a></li>
            <li><a href="${pageContext.request.contextPath}/student/my-notices.jsp" class="active"><span class="nav-icon">📂</span> My Notices</a></li>
            <li><a href="${pageContext.request.contextPath}/student/profile.jsp"><span class="nav-icon">👤</span> My Profile</a></li>
        </ul>
        <p class="sidebar-section-title" style="margin-top:1.5rem;">General</p>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/logout"><span class="nav-icon">🚪</span> Logout</a></li>
        </ul>
    </aside>

    <div class="main-content">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:1.5rem; flex-wrap:wrap; gap:1rem;">
            <h2 class="section-title" style="margin-bottom:0;">📂 My Notices</h2>
            <a href="${pageContext.request.contextPath}/student/submit-notice.jsp" class="btn btn-accent">
                ✏️ Submit New
            </a>
        </div>

        <% if ("submitted".equals(success)) { %>
            <div class="alert alert-success">✅ Your notice has been submitted successfully and is pending admin review!</div>
        <% } %>

        <% if (myNotices.isEmpty()) { %>
            <div class="empty-state card">
                <div class="empty-icon">📝</div>
                <h3>No notices submitted yet</h3>
                <p>Submit your first notice to see it here</p>
                <a href="${pageContext.request.contextPath}/student/submit-notice.jsp" class="btn btn-accent" style="margin-top:1rem;">Submit Notice</a>
            </div>
        <% } else { %>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Title</th>
                            <th>Category</th>
                            <th>Status</th>
                            <th>Submitted On</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int i = 1; for (Notice n : myNotices) { %>
                        <tr>
                            <td><%= i++ %></td>
                            <td>
                                <strong style="color:var(--primary);"><%= n.getTitle() %></strong>
                                <p style="font-size:0.78rem; color:var(--text-muted); margin-top:0.2rem;">
                                    <%= n.getDescription().length() > 80 ? n.getDescription().substring(0,80) + "..." : n.getDescription() %>
                                </p>
                            </td>
                            <td><span class="notice-badge badge-<%= n.getCategory() %>"><%= n.getCategory() %></span></td>
                            <td>
                                <span class="notice-badge badge-<%= n.getStatus() %>">
                                    <% if ("approved".equals(n.getStatus())) { %>✅<% } %>
                                    <% if ("pending".equals(n.getStatus())) { %>⏳<% } %>
                                    <% if ("rejected".equals(n.getStatus())) { %>❌<% } %>
                                    <%= n.getStatus() %>
                                </span>
                            </td>
                            <td style="font-size:0.82rem; color:var(--text-muted);">
                                <%= n.getCreatedAt() != null ? n.getCreatedAt().substring(0,10) : "—" %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </div>
</div>
</body>
</html>
