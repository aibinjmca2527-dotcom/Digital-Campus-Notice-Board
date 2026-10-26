package com.noticeboard.servlet;

import com.noticeboard.dao.NoticeDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminLogged") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
            return;
        }

        NoticeDAO dao = new NoticeDAO();
        request.setAttribute("totalNotices", dao.countByStatus("approved") + dao.countByStatus("pending") + dao.countByStatus("rejected"));
        request.setAttribute("pendingCount", dao.countByStatus("pending"));
        request.setAttribute("approvedCount", dao.countByStatus("approved"));
        request.setAttribute("rejectedCount", dao.countByStatus("rejected"));
        request.setAttribute("userCount", dao.countAllUsers());
        request.setAttribute("recentNotices", dao.getNoticesByStatus("pending"));

        request.getRequestDispatcher("admin/dashboard.jsp").forward(request, response);
    }
}
