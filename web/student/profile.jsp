<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.noticeboard.model.User" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    User user = (User) session.getAttribute("loggedUser");
    String success = request.getParameter("success");
    String error   = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile | NoticePro</title>
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
            <li><a href="${pageContext.request.contextPath}/student/my-notices.jsp"><span class="nav-icon">📂</span> My Notices</a></li>
            <li><a href="${pageContext.request.contextPath}/student/profile.jsp" class="active"><span class="nav-icon">👤</span> My Profile</a></li>
        </ul>
        <p class="sidebar-section-title" style="margin-top:1.5rem;">General</p>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/logout"><span class="nav-icon">🚪</span> Logout</a></li>
        </ul>
    </aside>

    <div class="main-content">
        <h2 class="section-title">👤 My Profile</h2>

        <% if ("updated".equals(success)) { %>
            <div class="alert alert-success">✅ Profile updated successfully!</div>
        <% } else if ("password".equals(success)) { %>
            <div class="alert alert-success">✅ Password changed successfully!</div>
        <% } else if ("wrongpass".equals(error)) { %>
            <div class="alert alert-danger">❌ Current password is incorrect.</div>
        <% } else if ("failed".equals(error)) { %>
            <div class="alert alert-danger">❌ Update failed. Please try again.</div>
        <% } %>

        <div style="display:grid; grid-template-columns:1fr 1fr; gap:1.5rem; align-items:start;">
            <!-- Profile Info Card -->
            <div class="card">
                <div style="text-align:center; padding-bottom:1.5rem; border-bottom:1px solid var(--border); margin-bottom:1.5rem;">
                    <div style="width:80px; height:80px; border-radius:50%; background:linear-gradient(135deg,#1a3a5c,#2563a8);
                                display:flex; align-items:center; justify-content:center; font-size:2rem; color:white; margin:0 auto 1rem;">
                        <%= user.getFullName().charAt(0) %>
                    </div>
                    <h3 style="font-family:'Playfair Display',serif; color:var(--primary);">
                        <%= user.getFullName() %>
                    </h3>
                    <p style="color:var(--text-muted); font-size:0.85rem;"><%= user.getDepartment() %></p>
                    <span class="notice-badge badge-approved">Student</span>
                </div>
                <h4 style="font-size:0.95rem; color:var(--primary); margin-bottom:1rem; font-weight:600;">Update Profile</h4>
                <form action="${pageContext.request.contextPath}/updateProfile" method="post">
                    <input type="hidden" name="action" value="updateProfile">
                    <div class="form-group">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="fullName" class="form-control" value="<%= user.getFullName() %>" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email (read-only)</label>
                        <input type="email" class="form-control" value="<%= user.getEmail() %>" readonly
                               style="background:#f0f0f0; cursor:not-allowed;">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Phone</label>
                        <input type="tel" name="phone" class="form-control" value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Department</label>
                        <select name="department" class="form-control">
                            <% String[] depts = {"Computer Science","Information Technology","Electronics","Mechanical","Civil","Business Administration","Arts & Science","Other"};
                               for (String dept : depts) { %>
                                <option value="<%= dept %>" <%= dept.equals(user.getDepartment()) ? "selected" : "" %>><%= dept %></option>
                            <% } %>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">💾 Update Profile</button>
                </form>
            </div>

            <!-- Change Password -->
            <div class="card">
                <h4 style="font-size:0.95rem; color:var(--primary); margin-bottom:1.25rem; font-weight:600;">🔐 Change Password</h4>
                <form action="${pageContext.request.contextPath}/updateProfile" method="post">
                    <input type="hidden" name="action" value="changePassword">
                    <div class="form-group">
                        <label class="form-label">Current Password</label>
                        <input type="password" name="currentPassword" class="form-control"
                               placeholder="Enter your current password" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">New Password</label>
                        <input type="password" name="newPassword" class="form-control"
                               placeholder="Enter new password" required minlength="6">
                    </div>
                    <button type="submit" class="btn btn-warning">🔑 Change Password</button>
                </form>

                <div style="margin-top:2rem; padding-top:1.5rem; border-top:1px solid var(--border);">
                    <h4 style="font-size:0.95rem; color:var(--primary); margin-bottom:0.75rem; font-weight:600;">ℹ️ Account Info</h4>
                    <div style="font-size:0.85rem; color:var(--text-muted); line-height:2;">
                        <p><strong>Email:</strong> <%= user.getEmail() %></p>
                        <p><strong>Member since:</strong> <%= user.getCreatedAt() != null ? user.getCreatedAt().substring(0,10) : "—" %></p>
                        <p><strong>Role:</strong> Student</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
