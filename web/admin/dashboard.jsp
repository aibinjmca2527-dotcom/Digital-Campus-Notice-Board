<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.noticeboard.model.Notice" %>
<%
    if (session.getAttribute("adminLogged") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }
    String adminName   = (String) session.getAttribute("adminName");
    Integer pending    = (Integer) request.getAttribute("pendingCount");
    Integer approved   = (Integer) request.getAttribute("approvedCount");
    Integer rejected   = (Integer) request.getAttribute("rejectedCount");
    Integer total      = (Integer) request.getAttribute("totalNotices");
    Integer userCount  = (Integer) request.getAttribute("userCount");
    List<Notice> recent = (List<Notice>) request.getAttribute("recentNotices");
    if (pending == null) pending = 0;
    if (approved == null) approved = 0;
    if (rejected == null) rejected = 0;
    if (total == null) total = 0;
    if (userCount == null) userCount = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | NoticePro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .admin-navbar { background: #0f2440; }
        .admin-sidebar { background: #0f2440; }
    </style>
</head>
<body>

<nav class="navbar admin-navbar">
    <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand">
        <div class="logo-icon" style="background:#e8b84b;">🛡️</div>
        <span>NoticePro Admin</span>
    </a>
    <ul class="navbar-nav">
        <li><span style="color:rgba(255,255,255,0.7); font-size:0.88rem;">🛡️ <%= adminName %></span></li>
        <li><a href="${pageContext.request.contextPath}/logout" class="btn-nav">Logout</a></li>
    </ul>
</nav>

<div class="layout-sidebar">
    <aside class="sidebar admin-sidebar">
        <p class="sidebar-section-title">Admin Panel</p>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/adminDashboard" class="active">
                <span class="nav-icon">📊</span> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/manageNotices">
                <span class="nav-icon">📋</span> Manage Notices</a></li>
            <li><a href="${pageContext.request.contextPath}/manageNotices?filter=pending">
                <span class="nav-icon">⏳</span> Pending (<%= pending %>)</a></li>
            <li><a href="${pageContext.request.contextPath}/manageUsers">
                <span class="nav-icon">👥</span> Manage Users</a></li>
        </ul>
        <p class="sidebar-section-title" style="margin-top:1.5rem;">General</p>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/viewNotices">
                <span class="nav-icon">📌</span> View Board</a></li>
            <li><a href="${pageContext.request.contextPath}/logout">
                <span class="nav-icon">🚪</span> Logout</a></li>
        </ul>
    </aside>

    <div class="main-content">
        <h2 class="section-title">📊 Admin Dashboard</h2>
        <p style="color:var(--text-muted); margin-bottom:1.75rem; font-size:0.9rem;">
            Welcome back, <strong><%= adminName %></strong> — here's what's happening today.
        </p>

        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon blue">📝</div>
                <div class="stat-info"><h3><%= total %></h3><p>Total Notices</p></div>
            </div>
            <div class="stat-card warning">
                <div class="stat-icon yellow">⏳</div>
                <div class="stat-info"><h3><%= pending %></h3><p>Pending Review</p></div>
            </div>
            <div class="stat-card success">
                <div class="stat-icon green">✅</div>
                <div class="stat-info"><h3><%= approved %></h3><p>Approved</p></div>
            </div>
            <div class="stat-card danger">
                <div class="stat-icon red">❌</div>
                <div class="stat-info"><h3><%= rejected %></h3><p>Rejected</p></div>
            </div>
            <div class="stat-card accent">
                <div class="stat-icon yellow">👥</div>
                <div class="stat-info"><h3><%= userCount %></h3><p>Students Registered</p></div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="card" style="margin-bottom:2rem;">
            <h3 class="section-title" style="font-size:1.1rem; margin-bottom:1rem;">⚡ Quick Actions</h3>
            <div style="display:flex; gap:1rem; flex-wrap:wrap;">
                <a href="${pageContext.request.contextPath}/manageNotices?filter=pending" class="btn btn-warning">
                    ⏳ Review Pending (<%= pending %>)
                </a>
                <a href="${pageContext.request.contextPath}/manageNotices" class="btn btn-primary">
                    📋 All Notices
                </a>
                <a href="${pageContext.request.contextPath}/manageUsers" class="btn btn-outline">
                    👥 Manage Users
                </a>
            </div>
        </div>

        <!-- Pending Notices -->
        <h3 class="section-title" style="font-size:1.1rem;">⏳ Notices Awaiting Review</h3>
        <% if (recent == null || recent.isEmpty()) { %>
            <div class="card" style="text-align:center; padding:2.5rem; color:var(--text-muted);">
                <div style="font-size:2.5rem; margin-bottom:0.75rem;">✅</div>
                <h3 style="font-size:1rem;">All caught up!</h3>
                <p style="font-size:0.88rem;">No notices pending review.</p>
            </div>
        <% } else { %>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr><th>#</th><th>Title</th><th>Category</th><th>Author</th><th>Submitted</th><th>Actions</th></tr>
                    </thead>
                    <tbody>
                        <% int i = 1; for (Notice n : recent) { if (i > 10) break; %>
                        <tr>
                            <td><%= i++ %></td>
                            <td>
                                <strong style="color:var(--primary);"><%= n.getTitle() %></strong>
                                <p style="font-size:0.78rem; color:var(--text-muted); margin-top:0.2rem;">
                                    <%= n.getDescription().length() > 70 ? n.getDescription().substring(0,70) + "..." : n.getDescription() %>
                                </p>
                            </td>
                            <td><span class="notice-badge badge-<%= n.getCategory() %>"><%= n.getCategory() %></span></td>
                            <td><%= n.getAuthorName() %></td>
                            <td style="font-size:0.82rem; color:var(--text-muted);">
                                <%= n.getCreatedAt() != null ? n.getCreatedAt().substring(0,10) : "—" %>
                            </td>
                            <td>
                                <div style="display:flex; gap:0.4rem;">
                                    <form action="${pageContext.request.contextPath}/manageNotices" method="post" style="display:inline;">
                                        <input type="hidden" name="noticeId" value="<%= n.getId() %>">
                                        <input type="hidden" name="action" value="approve">
                                        <button type="submit" class="btn btn-success btn-sm">✅ Approve</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/manageNotices" method="post" style="display:inline;">
                                        <input type="hidden" name="noticeId" value="<%= n.getId() %>">
                                        <input type="hidden" name="action" value="reject">
                                        <button type="submit" class="btn btn-danger btn-sm">❌ Reject</button>
                                    </form>
                                </div>
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
