<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.noticeboard.model.Notice" %>
<%
    List<Notice> notices = (List<Notice>) request.getAttribute("notices");
    boolean loggedIn = session.getAttribute("loggedUser") != null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Notice Board | NoticePro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .category-filter { display:flex; gap:0.75rem; flex-wrap:wrap; margin-bottom:2rem; }
        .cat-btn {
            padding:0.4rem 1.1rem;
            border-radius:999px;
            border:1.5px solid var(--border);
            background:white;
            cursor:pointer;
            font-size:0.85rem;
            font-weight:500;
            color:var(--text-muted);
            transition:all 0.2s;
        }
        .cat-btn:hover, .cat-btn.active { background:var(--primary); color:white; border-color:var(--primary); }
        .notice-card { display:none; }
        .notice-card.visible { display:flex; }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand">
        <div class="logo-icon">📋</div>
        <span>NoticePro</span>
    </a>
    <ul class="navbar-nav">
        <% if (loggedIn) { %>
            <li><a href="${pageContext.request.contextPath}/student/dashboard.jsp">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="btn-nav">Logout</a></li>
        <% } else { %>
            <li><a href="${pageContext.request.contextPath}/login.jsp">Login</a></li>
            <li><a href="${pageContext.request.contextPath}/register.jsp" class="btn-nav">Register</a></li>
        <% } %>
    </ul>
</nav>

<div class="page-header">
    <h1>📌 College Notice Board</h1>
    <p>All official college announcements, events, and articles</p>
</div>

<div class="container">
    <div class="category-filter">
        <button class="cat-btn active" onclick="filterNotices('all', this)">🗂 All Notices</button>
        <button class="cat-btn" onclick="filterNotices('event', this)">🎉 Events</button>
        <button class="cat-btn" onclick="filterNotices('announcement', this)">📢 Announcements</button>
        <button class="cat-btn" onclick="filterNotices('article', this)">📄 Articles</button>
    </div>

    <% if (notices == null || notices.isEmpty()) { %>
        <div class="empty-state card">
            <div class="empty-icon">📭</div>
            <h3>No notices published yet</h3>
            <p>Check back later or submit your own notice!</p>
            <% if (loggedIn) { %>
                <a href="${pageContext.request.contextPath}/student/submit-notice.jsp" class="btn btn-accent" style="margin-top:1rem;">Submit Notice</a>
            <% } %>
        </div>
    <% } else { %>
        <div class="notices-grid" id="noticesGrid">
            <% for (Notice n : notices) { %>
            <div class="notice-card visible" data-category="<%= n.getCategory() %>">
                <span class="notice-badge badge-<%= n.getCategory() %>"><%= n.getCategory() %></span>
                <h3><%= n.getTitle() %></h3>
                <p><%= n.getDescription() %></p>
                <div class="notice-meta">
                    <span>👤 <%= n.getAuthorName() %></span>
                    <span>📅 <%= n.getCreatedAt() != null ? n.getCreatedAt().substring(0,10) : "" %></span>
                </div>
            </div>
            <% } %>
        </div>
        <p style="text-align:center; color:var(--text-muted); font-size:0.85rem; margin-top:2rem;">
            Showing <%= notices.size() %> notice<%= notices.size() != 1 ? "s" : "" %>
        </p>
    <% } %>
</div>

<script>
function filterNotices(cat, btn) {
    document.querySelectorAll('.cat-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    document.querySelectorAll('.notice-card').forEach(card => {
        if (cat === 'all' || card.dataset.category === cat) {
            card.classList.add('visible');
        } else {
            card.classList.remove('visible');
        }
    });
}
</script>
</body>
</html>
