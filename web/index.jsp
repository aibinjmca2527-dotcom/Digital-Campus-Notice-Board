<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>College Notice Board Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body { margin: 0; overflow-x: hidden; }

        .hero {
            min-height: 100vh;
            background: linear-gradient(135deg, #1a3a5c 0%, #0f2440 60%, #1a3a5c 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute; inset: 0;
            background-image:
                radial-gradient(circle at 15% 35%, rgba(232,184,75,0.18) 0%, transparent 45%),
                radial-gradient(circle at 85% 65%, rgba(37,99,168,0.25) 0%, transparent 45%),
                radial-gradient(circle at 50% 90%, rgba(232,184,75,0.08) 0%, transparent 40%);
            pointer-events: none;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(232,184,75,0.15);
            border: 1px solid rgba(232,184,75,0.35);
            color: #e8b84b;
            padding: 0.4rem 1.1rem;
            border-radius: 999px;
            font-size: 0.82rem;
            font-weight: 600;
            letter-spacing: 0.06em;
            text-transform: uppercase;
            margin-bottom: 1.75rem;
            position: relative;
        }

        .hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2.4rem, 6vw, 4.2rem);
            font-weight: 700;
            color: white;
            line-height: 1.15;
            max-width: 820px;
            position: relative;
            margin-bottom: 1.25rem;
        }

        .hero h1 .highlight {
            color: #e8b84b;
            display: block;
        }

        .hero p {
            font-size: 1.1rem;
            color: rgba(255,255,255,0.68);
            max-width: 560px;
            line-height: 1.75;
            position: relative;
            margin-bottom: 2.5rem;
        }

        .hero-actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            justify-content: center;
            position: relative;
        }

        .hero-actions .btn {
            padding: 0.9rem 2.2rem;
            font-size: 1rem;
            border-radius: 10px;
        }

        .btn-white {
            background: white;
            color: #1a3a5c;
            font-weight: 700;
        }
        .btn-white:hover { background: #f0f0f0; }

        .btn-ghost {
            background: rgba(255,255,255,0.1);
            color: white;
            border: 1.5px solid rgba(255,255,255,0.3);
        }
        .btn-ghost:hover { background: rgba(255,255,255,0.18); }

        /* Features */
        .features-section {
            background: #f4f1eb;
            padding: 5rem 2rem;
        }

        .features-grid {
            max-width: 1100px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 1.75rem;
        }

        .feature-card {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            border: 1px solid #e2d9c8;
            box-shadow: 0 4px 24px rgba(26,58,92,0.07);
            text-align: center;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .feature-card:hover { transform: translateY(-4px); box-shadow: 0 12px 40px rgba(26,58,92,0.15); }

        .feature-icon {
            width: 64px; height: 64px;
            border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.8rem;
            margin: 0 auto 1.25rem;
        }

        .feature-card h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.15rem;
            font-weight: 700;
            color: #1a3a5c;
            margin-bottom: 0.6rem;
        }

        .feature-card p { font-size: 0.88rem; color: #6b7280; line-height: 1.65; }

        .section-header { text-align: center; margin-bottom: 3rem; }
        .section-header h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            font-weight: 700;
            color: #1a3a5c;
            margin-bottom: 0.6rem;
        }
        .section-header p { color: #6b7280; font-size: 1rem; }

        /* Portal cards */
        .portals-section {
            background: #1a3a5c;
            padding: 5rem 2rem;
        }

        .portals-section .section-header h2 { color: white; }
        .portals-section .section-header p  { color: rgba(255,255,255,0.6); }

        .portals-grid {
            max-width: 800px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .portal-card {
            background: rgba(255,255,255,0.07);
            border: 1.5px solid rgba(255,255,255,0.15);
            border-radius: 20px;
            padding: 2.5rem 2rem;
            text-align: center;
            text-decoration: none;
            color: white;
            transition: all 0.25s;
        }

        .portal-card:hover {
            background: rgba(255,255,255,0.13);
            transform: translateY(-4px);
            border-color: #e8b84b;
        }

        .portal-icon { font-size: 3rem; margin-bottom: 1rem; display: block; }
        .portal-card h3 { font-family: 'Playfair Display', serif; font-size: 1.4rem; margin-bottom: 0.5rem; }
        .portal-card p  { font-size: 0.85rem; color: rgba(255,255,255,0.6); margin-bottom: 1.5rem; }

        .portal-card .btn { width: 100%; justify-content: center; }

        footer {
            background: #0f2440;
            color: rgba(255,255,255,0.45);
            text-align: center;
            padding: 1.75rem;
            font-size: 0.85rem;
        }

        @media (max-width: 600px) {
            .portals-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar" style="position:fixed; top:0; left:0; right:0; z-index:200;">
    <a href="index.jsp" class="navbar-brand">
        <div class="logo-icon">📋</div>
        <span>NoticePro</span>
    </a>
    <ul class="navbar-nav">
        <li><a href="viewNotices">📌 Notice Board</a></li>
        <li><a href="login.jsp">Login</a></li>
        <li><a href="register.jsp" class="btn-nav">Register</a></li>
    </ul>
</nav>

<!-- HERO -->
<section class="hero" style="padding-top:5rem;">
    <div class="hero-badge">🎓 Digital Campus Notice Board</div>
    <h1>
        Your College Notices,
        <span class="highlight">Digitized & Organized</span>
    </h1>
    <p>
        Say goodbye to paper notices and crowded bulletin boards.
        Submit, review, and access all college announcements from anywhere — instantly.
    </p>
    <div class="hero-actions">
        <a href="register.jsp" class="btn btn-white">Get Started →</a>
        <a href="viewNotices" class="btn btn-ghost">📋 View Notice Board</a>
    </div>
</section>

<!-- FEATURES -->
<section class="features-section">
    <div class="section-header">
        <h2>Everything You Need</h2>
        <p>A complete digital notice management platform for your college</p>
    </div>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feature-icon" style="background:#dbeafe;">📝</div>
            <h3>Submit Notices Easily</h3>
            <p>Students can post notices, events, and articles through a clean and simple online form — no paperwork needed.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon" style="background:#fef3c7;">🔍</div>
            <h3>Admin Verification</h3>
            <p>Every submission is reviewed by the admin before going live, ensuring quality and relevance of all published notices.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon" style="background:#d1fae5;">📌</div>
            <h3>Digital Notice Board</h3>
            <p>Browse all approved notices organized by category — events, announcements, and articles — from anywhere on campus.</p>
        </div>
        <div class="feature-card">
            <div class="feature-icon" style="background:#ede9fe;">🌱</div>
            <h3>Eco-Friendly</h3>
            <p>Reduce paper waste and support your college's green initiative by going completely digital with communications.</p>
        </div>
    </div>
</section>

<!-- PORTALS -->
<section class="portals-section">
    <div class="section-header">
        <h2>Choose Your Portal</h2>
        <p>Access the system as a student or administrator</p>
    </div>
    <div class="portals-grid">
        <a href="login.jsp" class="portal-card">
            <span class="portal-icon">🎓</span>
            <h3>Student Portal</h3>
            <p>Submit notices, track your submissions, and view the notice board</p>
            <span class="btn btn-accent">Student Login →</span>
        </a>
        <a href="admin-login.jsp" class="portal-card">
            <span class="portal-icon">🛡️</span>
            <h3>Admin Portal</h3>
            <p>Review submissions, manage users, and control the notice board</p>
            <span class="btn btn-outline" style="border-color:rgba(255,255,255,0.4); color:white;">Admin Login →</span>
        </a>
    </div>
</section>

<footer>
    <p>© 2024–2026 College Notice Board Management System &nbsp;|&nbsp; Developed by Aibin Joseph</p>
</footer>

</body>
</html>
