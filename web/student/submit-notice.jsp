<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.noticeboard.model.User" %>
<%
    if (session.getAttribute("loggedUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    User user = (User) session.getAttribute("loggedUser");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Submit Notice | NoticePro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

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
            <li><a href="${pageContext.request.contextPath}/student/dashboard.jsp"><span class="nav-icon">🏠</span> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/viewNotices"><span class="nav-icon">📌</span> Notice Board</a></li>
            <li><a href="${pageContext.request.contextPath}/student/submit-notice.jsp" class="active"><span class="nav-icon">✏️</span> Submit Notice</a></li>
            <li><a href="${pageContext.request.contextPath}/student/my-notices.jsp"><span class="nav-icon">📂</span> My Notices</a></li>
            <li><a href="${pageContext.request.contextPath}/student/profile.jsp"><span class="nav-icon">👤</span> My Profile</a></li>
        </ul>
        <p class="sidebar-section-title" style="margin-top:1.5rem;">General</p>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/logout"><span class="nav-icon">🚪</span> Logout</a></li>
        </ul>
    </aside>

    <div class="main-content">
        <h2 class="section-title">✏️ Submit a Notice</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">⚠️ <%= request.getAttribute("error") %></div>
        <% } %>

        <div style="display:grid; grid-template-columns:2fr 1fr; gap:1.5rem; align-items:start;">
            <div class="card">
                <form action="${pageContext.request.contextPath}/submitNotice" method="post">
                    <div class="form-group">
                        <label class="form-label">Notice Title *</label>
                        <input type="text" name="title" class="form-control"
                               placeholder="Enter a clear, descriptive title" required maxlength="200">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Category *</label>
                        <select name="category" class="form-control" required>
                            <option value="">Select Category</option>
                            <option value="event">🎉 Event</option>
                            <option value="announcement">📢 Announcement</option>
                            <option value="article">📄 Article</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Description *</label>
                        <textarea name="description" class="form-control" rows="7"
                                  placeholder="Write the full content of your notice here..." required></textarea>
                    </div>
                    <div style="display:flex; gap:1rem;">
                        <button type="submit" class="btn btn-accent btn-lg">📨 Submit for Review</button>
                        <button type="reset" class="btn btn-outline btn-lg">Clear</button>
                    </div>
                </form>
            </div>

            <div>
                <div class="card" style="background:linear-gradient(135deg,#1a3a5c,#2563a8); color:white; border:none;">
                    <h4 style="font-family:'Playfair Display',serif; font-size:1.1rem; margin-bottom:1rem;">📋 Submission Guidelines</h4>
                    <ul style="list-style:none; font-size:0.85rem; color:rgba(255,255,255,0.8); line-height:2;">
                        <li>✓ Use a clear and descriptive title</li>
                        <li>✓ Choose the correct category</li>
                        <li>✓ Be concise and informative</li>
                        <li>✓ Avoid promotional content</li>
                        <li>✓ Check spelling and grammar</li>
                        <li>✓ Admin will review within 24 hrs</li>
                    </ul>
                </div>

                <div class="card" style="margin-top:1rem;">
                    <h4 style="font-size:0.95rem; color:var(--primary); margin-bottom:0.75rem;">📂 Categories Explained</h4>
                    <div style="font-size:0.83rem; color:var(--text-muted); line-height:1.8;">
                        <p><span class="notice-badge badge-event">event</span> College functions, fests, sports</p><br>
                        <p><span class="notice-badge badge-announcement">announcement</span> Exams, holidays, circulars</p><br>
                        <p><span class="notice-badge badge-article">article</span> Student writings, opinions</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
