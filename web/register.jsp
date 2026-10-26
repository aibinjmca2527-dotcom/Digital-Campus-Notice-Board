<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("loggedUser") != null) {
        response.sendRedirect("student/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register | NoticePro</title>
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
            grid-template-columns: 380px 1fr;
            max-width: 960px;
            width: 100%;
            background: white;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 32px 80px rgba(0,0,0,0.35);
        }

        .auth-left {
            background: linear-gradient(160deg, #1a3a5c, #2563a8);
            padding: 3rem 2.5rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        .auth-left::before {
            content: '';
            position: absolute;
            top: -40px; right: -40px;
            width: 180px; height: 180px;
            border-radius: 50%;
            background: rgba(232,184,75,0.12);
        }

        .auth-left .logo { font-size: 3rem; margin-bottom: 1.25rem; position: relative; }
        .auth-left h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: white;
            margin-bottom: 0.75rem;
            position: relative;
        }
        .auth-left p { color: rgba(255,255,255,0.65); font-size: 0.9rem; line-height: 1.7; position: relative; }

        .step-list { margin-top: 2rem; position: relative; }
        .step { display: flex; gap: 0.75rem; margin-bottom: 1.1rem; align-items: flex-start; }
        .step-num {
            width: 28px; height: 28px; border-radius: 50%;
            background: #e8b84b;
            color: #1a3a5c;
            font-size: 0.78rem;
            font-weight: 700;
            display: flex; align-items: center; justify-content: center;
            flex-shrink: 0;
        }
        .step-text h4 { color: white; font-size: 0.88rem; font-weight: 600; margin-bottom: 0.1rem; }
        .step-text p  { color: rgba(255,255,255,0.55); font-size: 0.78rem; }

        .auth-right { padding: 3rem; overflow-y: auto; }

        .auth-right h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.7rem;
            font-weight: 700;
            color: #1a3a5c;
            margin-bottom: 0.4rem;
        }
        .auth-right .subtitle { color: #6b7280; font-size: 0.88rem; margin-bottom: 2rem; }

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

        .auth-footer {
            text-align: center;
            margin-top: 1.25rem;
            font-size: 0.88rem;
            color: #6b7280;
        }
        .auth-footer a { color: #2563a8; text-decoration: none; font-weight: 600; }

        @media (max-width: 700px) {
            .auth-wrapper { grid-template-columns: 1fr; }
            .auth-left { display: none; }
        }
    </style>
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-left">
        <div class="logo">🎓</div>
        <h2>Join NoticePro</h2>
        <p>Create your student account to start submitting notices and staying updated with your college.</p>

        <div class="step-list">
            <div class="step">
                <div class="step-num">1</div>
                <div class="step-text">
                    <h4>Create Account</h4>
                    <p>Fill in your details below</p>
                </div>
            </div>
            <div class="step">
                <div class="step-num">2</div>
                <div class="step-text">
                    <h4>Submit Notices</h4>
                    <p>Post your notices or articles</p>
                </div>
            </div>
            <div class="step">
                <div class="step-num">3</div>
                <div class="step-text">
                    <h4>Get Approved</h4>
                    <p>Admin reviews and approves</p>
                </div>
            </div>
            <div class="step">
                <div class="step-num">4</div>
                <div class="step-text">
                    <h4>Go Live!</h4>
                    <p>Your notice appears on the board</p>
                </div>
            </div>
        </div>
        <a href="index.jsp" class="back-link">← Back to Home</a>
    </div>

    <div class="auth-right">
        <h3>Create Account</h3>
        <p class="subtitle">Register as a student to get started</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">⚠️ <%= request.getAttribute("error") %></div>
        <% } %>

        <form action="register" method="post">
            <div class="form-group">
                <label class="form-label">Full Name</label>
                <input type="text" name="fullName" class="form-control" placeholder="Enter your full name" required>
            </div>
            <div class="form-group">
                <label class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" placeholder="your@college.edu" required>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">Phone Number</label>
                    <input type="tel" name="phone" class="form-control" placeholder="Phone number">
                </div>
                <div class="form-group">
                    <label class="form-label">Department</label>
                    <select name="department" class="form-control" required>
                        <option value="">Select Department</option>
                        <option>Computer Science</option>
                        <option>Information Technology</option>
                        <option>Electronics</option>
                        <option>Mechanical</option>
                        <option>Civil</option>
                        <option>Business Administration</option>
                        <option>Arts & Science</option>
                        <option>Other</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" placeholder="Create a strong password" required minlength="6">
            </div>
            <button type="submit" class="btn btn-primary btn-lg" style="width:100%; justify-content:center; margin-top:0.5rem;">
                Create Account →
            </button>
        </form>

        <div class="auth-footer">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </div>
</div>
</body>
</html>
