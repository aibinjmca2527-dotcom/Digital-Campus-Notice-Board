package com.noticeboard.servlet;

import com.noticeboard.dao.NoticeDAO;
import com.noticeboard.model.Notice;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ViewNoticesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        NoticeDAO dao = new NoticeDAO();
        List<Notice> notices = dao.getApprovedNotices();
        request.setAttribute("notices", notices);
        request.getRequestDispatcher("student/notice-board.jsp").forward(request, response);
    }
}
