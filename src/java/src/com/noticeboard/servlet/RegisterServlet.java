package com.noticeboard.servlet;

import com.noticeboard.dao.UserDAO;
import com.noticeboard.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName   = request.getParameter("fullName");
        String email      = request.getParameter("email");
        String password   = request.getParameter("password");
        String phone      = request.getParameter("phone");
        String department = request.getParameter("department");

        UserDAO dao = new UserDAO();

        if (dao.emailExists(email)) {
            request.setAttribute("error", "Email already registered. Please login.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setDepartment(department);

        if (dao.registerUser(user)) {
            response.sendRedirect("login.jsp?success=registered");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}
