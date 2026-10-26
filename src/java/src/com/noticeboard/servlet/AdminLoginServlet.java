package com.noticeboard.servlet;

import com.noticeboard.dao.AdminDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        AdminDAO dao = new AdminDAO();

        if (dao.loginAdmin(email, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("adminLogged", true);
            session.setAttribute("adminEmail", email);
            session.setAttribute("adminName", dao.getAdminName(email));
            response.sendRedirect("admin/dashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid admin credentials.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("admin-login.jsp");
    }
}
