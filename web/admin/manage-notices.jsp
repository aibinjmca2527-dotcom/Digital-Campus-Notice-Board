<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.noticeboard.model.Notice" %>
<%
    if (session.getAttribute("adminLogged") == null) {
        response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
        return;
    }
    String adminName = (String) session.getAttribute("adminName");
    List<Notice> notices = (List<Notice>) request.getAttribute("notices");
    String filter = (String) request.getAttribute("filter");
    if (filter == null) filter = "all";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Notices | Admin</title>
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
            <li><a href="${pageContext.request.contextPath}/manageNotices" class="active"><span class="nav-icon">📋</span> Manage Notices</a></li>
            <li><a href="${pageContext.request.contextPath}/manageUsers"><span class="nav-icon">👥</span> Manage Users</a></li>
        </ul>
        <p class="sidebar-section-title" style="margin-top:1.5rem;">General</p>
        <ul class="sidebar-nav">
            <li><a href="${pageContext.request.contextPath}/viewNotices"><span class="nav-icon">📌</span> View Board</a></li>
            <li><a href="${pageContext.request.contextPath}/logout"><span class="nav-icon">🚪</span> Logout</a></li>
        </ul>
    </aside>

    <div class="main-content">
        <h2 class="section-title">📋 Manage Notices</h2>

        <div class="filter-tabs" style="margin-bottom:1.5rem;">
            <a href="${pageContext.request.contextPath}/manageNotices" class="filter-tab <%= "all".equals(filter) ? "active" : "" %>">🗂 All</a>
            <a href="${pageContext.request.contextPath}/manageNotices?filter=pending" class="filter-tab <%= "pending".equals(filter) ? "active" : "" %>">⏳ Pending</a>
            <a href="${pageContext.request.contextPath}/manageNotices?filter=approved" class="filter-tab <%= "approved".equals(filter) ? "active" : "" %>">✅ Approved</a>
            <a href="${pageContext.request.contextPath}/manageNotices?filter=rejected" class="filter-tab <%= "rejected".equals(filter) ? "active" : "" %>">❌ Rejected</a>
        </div>

        <% if (notices == null || notices.isEmpty()) { %>
            <div class="empty-state card">
                <div class="empty-icon">📭</div>
                <h3>No notices found</h3>
                <p>No notices in this category yet.</p>
            </div>
        <% } else { %>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Title & Description</th>
                            <th>Category</th>
                            <th>Status</th>
                            <th>Author</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int i = 1; for (Notice n : notices) { %>
                        <tr>
                            <td style="font-size:0.82rem; color:var(--text-muted);"><%= i++ %></td>
                            <td style="max-width:280px;">
                                <strong style="color:var(--primary); font-size:0.9rem;"><%= n.getTitle() %></strong>
                                <p style="font-size:0.78rem; color:var(--text-muted); margin-top:0.2rem; line-height:1.5;">
                                    <%= n.getDescription().length() > 80 ? n.getDescription().substring(0,80) + "..." : n.getDescription() %>
                                </p>
                            </td>
                            <td><span class="notice-badge badge-<%= n.getCategory() %>"><%= n.getCategory() %></span></td>
                            <td><span class="notice-badge badge-<%= n.getStatus() %>">
                                <% if ("approved".equals(n.getStatus())) { %>✅<% } %>
                                <% if ("pending".equals(n.getStatus())) { %>⏳<% } %>
                                <% if ("rejected".equals(n.getStatus())) { %>❌<% } %>
                                <%= n.getStatus() %>
                            </span></td>
                            <td style="font-size:0.85rem;"><%= n.getAuthorName() %></td>
                            <td style="font-size:0.78rem; color:var(--text-muted);">
                                <%= n.getCreatedAt() != null ? n.getCreatedAt().substring(0,10) : "—" %>
                            </td>
                            <td>
                                <div style="display:flex; gap:0.3rem; flex-wrap:wrap;">
                                    <% if (!"approved".equals(n.getStatus())) { %>
                                    <form action="${pageContext.request.contextPath}/manageNotices" method="post" style="display:inline;">
                                        <input type="hidden" name="noticeId" value="<%= n.getId() %>">
                                        <input type="hidden" name="action" value="approve">
                                        <button type="submit" class="btn btn-success btn-sm">✅</button>
                                    </form>
                                    <% } %>
                                    <% if (!"rejected".equals(n.getStatus())) { %>
                                    <form action="${pageContext.request.contextPath}/manageNotices" method="post" style="display:inline;">
                                        <input type="hidden" name="noticeId" value="<%= n.getId() %>">
                                        <input type="hidden" name="action" value="reject">
                                        <button type="submit" class="btn btn-warning btn-sm">🚫</button>
                                    </form>
                                    <% } %>
                                    <form action="${pageContext.request.contextPath}/manageNotices" method="post" style="display:inline;"
                                          onsubmit="return confirm('Delete this notice permanently?')">
                                        <input type="hidden" name="noticeId" value="<%= n.getId() %>">
                                        <input type="hidden" name="action" value="delete">
                                        <button type="submit" class="btn btn-danger btn-sm">🗑</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <p style="font-size:0.82rem; color:var(--text-muted); margin-top:1rem; text-align:right;">
                Showing <%= notices.size() %> notice<%= notices.size() != 1 ? "s" : "" %>
            </p>
        <% } %>
    </div>
</div>
</body>
</html>
