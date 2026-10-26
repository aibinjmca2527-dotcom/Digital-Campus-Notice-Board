package com.noticeboard.servlet;

import com.noticeboard.dao.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ManageUsersServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminLogged") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
            return;
        }

        UserDAO dao = new UserDAO();
        request.setAttribute("users", dao.getAllStudents());
        request.getRequestDispatcher("admin/manage-users.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminLogged") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
            return;
        }

        int userId = Integer.parseInt(request.getParameter("userId"));
        new UserDAO().deleteUser(userId);
        response.sendRedirect("manageUsers");
    }
}
