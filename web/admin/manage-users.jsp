<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.noticeboard.model.User" %>
<%
    if (session.getAttribute("adminLogged") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }
    String adminName = (String) session.getAttribute("adminName");
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users | Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<nav class="navbar" style="background:#0f2440;">
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
    <aside class="sidebar" style="background:#0f2440;">
        <p class="sidebar-section-title">Admin Panel</p>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/adminDashboard"><span class="nav-icon">📊</span> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/manageNotices"><span class="nav-icon">📋</span> Manage Notices</a></li>
            <li><a href="${pageContext.request.contextPath}/manageUsers" class="active"><span class="nav-icon">👥</span> Manage Users</a></li>
        </ul>
        <p class="sidebar-section-title" style="margin-top:1.5rem;">General</p>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/viewNotices"><span class="nav-icon">📌</span> View Board</a></li>
            <li><a href="${pageContext.request.contextPath}/logout"><span class="nav-icon">🚪</span> Logout</a></li>
        </ul>
    </aside>

    <div class="main-content">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:1.5rem;">
            <h2 class="section-title" style="margin-bottom:0;">👥 Manage Students</h2>
            <span class="notice-badge badge-approved" style="font-size:0.85rem; padding:0.4rem 1rem;">
                <%= users != null ? users.size() : 0 %> Registered
            </span>
        </div>

        <% if (users == null || users.isEmpty()) { %>
            <div class="empty-state card">
                <div class="empty-icon">👤</div>
                <h3>No students registered</h3>
                <p>No student accounts found in the system.</p>
            </div>
        <% } else { %>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Department</th>
                            <th>Registered On</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int i = 1; for (User u : users) { %>
                        <tr>
                            <td style="font-size:0.82rem; color:var(--text-muted);"><%= i++ %></td>
                            <td>
                                <div style="display:flex; align-items:center; gap:0.6rem;">
                                    <div style="width:34px; height:34px; border-radius:50%; background:linear-gradient(135deg,#1a3a5c,#2563a8);
                                                display:flex; align-items:center; justify-content:center; color:white; font-size:0.9rem; font-weight:700; flex-shrink:0;">
                                        <%= u.getFullName().charAt(0) %>
                                    </div>
                                    <strong style="font-size:0.9rem;"><%= u.getFullName() %></strong>
                                </div>
                            </td>
                            <td style="font-size:0.85rem; color:var(--text-muted);"><%= u.getEmail() %></td>
                            <td style="font-size:0.85rem; color:var(--text-muted);"><%= u.getPhone() != null ? u.getPhone() : "—" %></td>
                            <td>
                                <span style="font-size:0.82rem; background:#dbeafe; color:#1e40af; padding:0.2rem 0.6rem; border-radius:6px;">
                                    <%= u.getDepartment() %>
                                </span>
                            </td>
                            <td style="font-size:0.78rem; color:var(--text-muted);">
                                <%= u.getCreatedAt() != null ? u.getCreatedAt().substring(0,10) : "—" %>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/manageUsers" method="post" style="display:inline;"
                                      onsubmit="return confirm('Remove this student? This will also delete their notices.')">
                                    <input type="hidden" name="userId" value="<%= u.getId() %>">
                                    <button type="submit" class="btn btn-danger btn-sm">🗑 Remove</button>
                                </form>
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
