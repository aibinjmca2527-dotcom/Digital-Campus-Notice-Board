<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("adminLogged") != null) {
        response.sendRedirect("admin/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login | NoticePro</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #0f2440 0%, #1a3a5c 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .admin-login-box {
            background: white;
            border-radius: 24px;
            overflow: hidden;
            max-width: 460px;
            width: 100%;
            box-shadow: 0 32px 80px rgba(0,0,0,0.4);
        }
        .admin-header {
            background: linear-gradient(135deg, #1a3a5c, #0f2440);
            padding: 2.5rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .admin-header::before {
            content: '';
            position: absolute;
            top: -30px; right: -30px;
            width: 140px; height: 140px;
            border-radius: 50%;
            background: rgba(232,184,75,0.12);
        }
        .admin-header .icon { font-size: 3rem; position: relative; margin-bottom: 0.75rem; }
        .admin-header h2 {
            font-family: 'Playfair Display', serif;
            color: white;
            font-size: 1.6rem;
            position: relative;
        }
        .admin-header p { color: rgba(255,255,255,0.6); font-size: 0.85rem; position: relative; }
        .admin-body { padding: 2.5rem; }

        .admin-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            background: #fef3c7;
            color: #92400e;
            border: 1px solid #fde68a;
            padding: 0.35rem 1rem;
            border-radius: 999px;
            font-size: 0.78rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .auth-footer {
            text-align: center;
            margin-top: 1.25rem;
            font-size: 0.85rem;
            color: #6b7280;
        }
        .auth-footer a { color: #2563a8; text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>
<div class="admin-login-box">
    <div class="admin-header">
        <div class="icon">🛡️</div>
        <h2>Admin Portal</h2>
        <p>Restricted access — administrators only</p>
    </div>
    <div class="admin-body">
        <div class="admin-badge">🔐 Secure Admin Access</div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">⚠️ <%= request.getAttribute("error") %></div>
        <% } %>

        <form action="adminLogin" method="post">
            <div class="form-group">
                <label class="form-label">Admin Email</label>
                <input type="email" name="email" class="form-control" placeholder="admin@college.edu" required>
            </div>
            <div class="form-group">
                <label class="form-label">Admin Password</label>
                <input type="password" name="password" class="form-control" placeholder="Enter admin password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-lg" style="width:100%; justify-content:center; background:#1a3a5c;">
                🛡️ Admin Login
            </button>
        </form>

        <div class="auth-footer" style="margin-top:1.5rem;">
            <a href="index.jsp">← Back to Home</a> &nbsp;·&nbsp; <a href="login.jsp">Student Login</a>
        </div>
    </div>
</div>
</body>
</html>
