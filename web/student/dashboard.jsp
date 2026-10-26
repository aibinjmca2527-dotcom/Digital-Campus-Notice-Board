<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.noticeboard.model.User" %>
<%@ page import="com.noticeboard.dao.NoticeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.noticeboard.model.Notice" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    User user = (User) session.getAttribute("loggedUser");
    NoticeDAO dao = new NoticeDAO();
    List<Notice> myNotices = dao.getNoticesByUser(user.getId());
    List<Notice> approved  = dao.getApprovedNotices();

    int myTotal    = myNotices.size();
    int myPending  = (int) myNotices.stream().filter(n -> "pending".equals(n.getStatus())).count();
    int myApproved = (int) myNotices.stream().filter(n -> "approved".equals(n.getStatus())).count();
    int myRejected = (int) myNotices.stream().filter(n -> "rejected".equals(n.getStatus())).count();
    String userName = (String) session.getAttribute("userName");
    String currentPage = "/student/dashboard.jsp";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | NoticePro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand">
        <div class="logo-icon">📋</div>
        <span>NoticePro</span>
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
            <li><a href="${pageContext.request.contextPath}/student/dashboard.jsp" class="active">
                <span class="nav-icon">🏠</span> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/viewNotices">
                <span class="nav-icon">📌</span> Notice Board</a></li>
            <li><a href="${pageContext.request.contextPath}/student/submit-notice.jsp">
                <span class="nav-icon">✏️</span> Submit Notice</a></li>
            <li><a href="${pageContext.request.contextPath}/student/my-notices.jsp">
                <span class="nav-icon">📂</span> My Notices</a></li>
            <li><a href="${pageContext.request.contextPath}/student/profile.jsp">
                <span class="nav-icon">👤</span> My Profile</a></li>
        </ul>
        <p class="sidebar-section-title" style="margin-top:1.5rem;">General</p>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/logout">
                <span class="nav-icon">🚪</span> Logout</a></li>
        </ul>
    </aside>

    <div class="main-content">
        <div style="margin-bottom:1.75rem;">
            <h2 class="section-title">🏠 Welcome back, <%= user.getFullName().split(" ")[0] %>!</h2>
            <p style="color:var(--text-muted); font-size:0.9rem;">
                <%= user.getDepartment() %> &nbsp;·&nbsp; <%= user.getEmail() %>
            </p>
        </div>

        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon blue">📝</div>
                <div class="stat-info">
                    <h3><%= myTotal %></h3>
                    <p>Total Submissions</p>
                </div>
            </div>
            <div class="stat-card warning">
                <div class="stat-icon yellow">⏳</div>
                <div class="stat-info">
                    <h3><%= myPending %></h3>
                    <p>Pending Review</p>
                </div>
            </div>
            <div class="stat-card success">
                <div class="stat-icon green">✅</div>
                <div class="stat-info">
                    <h3><%= myApproved %></h3>
                    <p>Approved</p>
                </div>
            </div>
            <div class="stat-card danger">
                <div class="stat-icon red">❌</div>
                <div class="stat-info">
                    <h3><%= myRejected %></h3>
                    <p>Rejected</p>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="card" style="margin-bottom:2rem;">
            <h3 class="section-title" style="font-size:1.15rem; margin-bottom:1rem;">⚡ Quick Actions</h3>
            <div style="display:flex; gap:1rem; flex-wrap:wrap;">
                <a href="${pageContext.request.contextPath}/student/submit-notice.jsp" class="btn btn-accent btn-lg">
                    ✏️ Submit New Notice
                </a>
                <a href="${pageContext.request.contextPath}/viewNotices" class="btn btn-outline btn-lg">
                    📌 View Notice Board
                </a>
                <a href="${pageContext.request.contextPath}/student/my-notices.jsp" class="btn btn-outline btn-lg">
                    📂 My Notices
                </a>
            </div>
        </div>

        <!-- Recent Notices on Board -->
        <h3 class="section-title" style="font-size:1.15rem;">📌 Recent Approved Notices</h3>
        <% if (approved.isEmpty()) { %>
            <div class="empty-state card">
                <div class="empty-icon">📭</div>
                <h3>No notices yet</h3>
                <p>No approved notices on the board yet.</p>
            </div>
        <% } else { %>
            <div class="notices-grid">
                <% int count = 0; for (Notice n : approved) { if (count++ >= 6) break; %>
                <div class="notice-card <%= n.getCategory() %>">
                    <span class="notice-badge badge-<%= n.getCategory() %>"><%= n.getCategory() %></span>
                    <h3><%= n.getTitle() %></h3>
                    <p><%= n.getDescription() %></p>
                    <div class="notice-meta">
                        <span>👤 <%= n.getAuthorName() %></span>
                        <span>📅 <%= n.getCreatedAt() != null ? n.getCreatedAt().substring(0, 10) : "" %></span>
                    </div>
                </div>
                <% } %>
            </div>
        <% } %>
    </div>
</div>
</body>
</html>
