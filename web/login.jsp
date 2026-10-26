<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("loggedUser") != null) {
        response.sendRedirect("student/dashboard.jsp");
        return;
    }
    String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Login | NoticePro</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background: linear-gradient(135deg, #1a3a5c 0%, #0f2440 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .auth-wrapper {
            display: grid;
            grid-template-columns: 1fr 1fr;
            max-width: 960px;
            width: 100%;
            background: white;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 32px 80px rgba(0,0,0,0.35);
        }

        .auth-left {
            background: linear-gradient(160deg, #1a3a5c, #2563a8);
            padding: 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .auth-left::before {
            content: '';
            position: absolute;
            top: -60px; right: -60px;
            width: 220px; height: 220px;
            border-radius: 50%;
            background: rgba(232,184,75,0.15);
        }

        .auth-left::after {
            content: '';
            position: absolute;
            bottom: -40px; left: -40px;
            width: 180px; height: 180px;
            border-radius: 50%;
            background: rgba(255,255,255,0.06);
        }

        .auth-left .logo { font-size: 3.5rem; margin-bottom: 1.5rem; position: relative; }
        .auth-left h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: white;
            margin-bottom: 1rem;
            position: relative;
        }
        .auth-left p { color: rgba(255,255,255,0.65); font-size: 0.92rem; line-height: 1.7; position: relative; }

        .auth-features { margin-top: 2rem; list-style: none; position: relative; }
        .auth-features li {
            color: rgba(255,255,255,0.75);
            font-size: 0.88rem;
            padding: 0.4rem 0;
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }
        .auth-features li::before { content: '✓'; color: #e8b84b; font-weight: 700; }

        .auth-right { padding: 3rem; }

        .auth-right h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.7rem;
            font-weight: 700;
            color: #1a3a5c;
            margin-bottom: 0.4rem;
        }
        .auth-right .subtitle { color: #6b7280; font-size: 0.88rem; margin-bottom: 2rem; }

        .auth-footer {
            text-align: center;
            margin-top: 1.5rem;
            font-size: 0.88rem;
            color: #6b7280;
        }
        .auth-footer a { color: #2563a8; text-decoration: none; font-weight: 600; }
        .auth-footer a:hover { text-decoration: underline; }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.3rem;
            color: rgba(255,255,255,0.55);
            text-decoration: none;
            font-size: 0.82rem;
            margin-top: 2rem;
            position: relative;
        }
        .back-link:hover { color: white; }

        @media (max-width: 700px) {
            .auth-wrapper { grid-template-columns: 1fr; }
            .auth-left { padding: 2rem; }
        }
    </style>
</head>
<body>
<div class="auth-wrapper">
    <!-- Left Panel -->
    <div class="auth-left">
        <div class="logo">📋</div>
        <h2>Welcome Back!</h2>
        <p>Access your college notice board, submit new notices, and stay updated with campus events.</p>
        <ul class="auth-features">
            <li>Submit notices & articles</li>
            <li>View approved announcements</li>
            <li>Track your submissions</li>
            <li>Update your profile</li>
        </ul>
        <a href="index.jsp" class="back-link">← Back to Home</a>
    </div>

    <!-- Right Panel -->
    <div class="auth-right">
        <h3>Student Login</h3>
        <p class="subtitle">Sign in to your student account</p>

        <% if ("registered".equals(success)) { %>
            <div class="alert alert-success">✅ Registration successful! You can now login.</div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">⚠️ <%= request.getAttribute("error") %></div>
        <% } %>

        <form action="login" method="post">
            <div class="form-group">
                <label class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" placeholder="Enter your college email" required>
            </div>
            <div class="form-group">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
            </div>
            <button type="submit" class="btn btn-primary btn-lg" style="width:100%; justify-content:center; margin-top:0.5rem;">
                Login →
            </button>
        </form>

        <div class="auth-footer">
            Don't have an account? <a href="register.jsp">Register here</a>
        </div>
        <div class="auth-footer" style="margin-top:0.5rem;">
            Are you an admin? <a href="admin-login.jsp">Admin Login</a>
        </div>
    </div>
</div>
</body>
</html>
