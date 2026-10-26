package com.noticeboard.servlet;

import com.noticeboard.dao.NoticeDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ManageNoticesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminLogged") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
            return;
        }

        NoticeDAO dao = new NoticeDAO();
        String filter = request.getParameter("filter");

        if ("approved".equals(filter))       request.setAttribute("notices", dao.getNoticesByStatus("approved"));
        else if ("rejected".equals(filter))  request.setAttribute("notices", dao.getNoticesByStatus("rejected"));
        else if ("pending".equals(filter))   request.setAttribute("notices", dao.getNoticesByStatus("pending"));
        else                                 request.setAttribute("notices", dao.getAllNotices());

        request.setAttribute("filter", filter == null ? "all" : filter);
        request.getRequestDispatcher("admin/manage-notices.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminLogged") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
            return;
        }

        String action   = request.getParameter("action");
        int noticeId    = Integer.parseInt(request.getParameter("noticeId"));
        NoticeDAO dao   = new NoticeDAO();

        if ("approve".equals(action))       dao.updateNoticeStatus(noticeId, "approved");
        else if ("reject".equals(action))   dao.updateNoticeStatus(noticeId, "rejected");
        else if ("delete".equals(action))   dao.deleteNotice(noticeId);

        response.sendRedirect("manageNotices");
    }
}
