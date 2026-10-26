package com.noticeboard.servlet;

import com.noticeboard.dao.NoticeDAO;
import com.noticeboard.model.Notice;
import com.noticeboard.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class SubmitNoticeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user        = (User) session.getAttribute("loggedUser");
        String title     = request.getParameter("title");
        String desc      = request.getParameter("description");
        String category  = request.getParameter("category");

        Notice notice = new Notice();
        notice.setTitle(title);
        notice.setDescription(desc);
        notice.setCategory(category);
        notice.setUserId(user.getId());
        notice.setAuthorName(user.getFullName());

        NoticeDAO dao = new NoticeDAO();
        if (dao.submitNotice(notice)) {
            response.sendRedirect("student/my-notices.jsp?success=submitted");
        } else {
            request.setAttribute("error", "Failed to submit notice. Try again.");
            request.getRequestDispatcher("student/submit-notice.jsp").forward(request, response);
        }
    }
}
