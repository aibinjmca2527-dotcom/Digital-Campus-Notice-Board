package com.noticeboard.servlet;

import com.noticeboard.dao.UserDAO;
import com.noticeboard.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user         = (User) session.getAttribute("loggedUser");
        String action     = request.getParameter("action");
        UserDAO dao       = new UserDAO();

        if ("updateProfile".equals(action)) {
            user.setFullName(request.getParameter("fullName"));
            user.setPhone(request.getParameter("phone"));
            user.setDepartment(request.getParameter("department"));

            if (dao.updateProfile(user)) {
                session.setAttribute("loggedUser", user);
                session.setAttribute("userName", user.getFullName());
                response.sendRedirect("student/profile.jsp?success=updated");
            } else {
                response.sendRedirect("student/profile.jsp?error=failed");
            }

        } else if ("changePassword".equals(action)) {
            String currentPass = request.getParameter("currentPassword");
            String newPass     = request.getParameter("newPassword");

            if (user.getPassword().equals(currentPass)) {
                dao.changePassword(user.getId(), newPass);
                user.setPassword(newPass);
                session.setAttribute("loggedUser", user);
                response.sendRedirect("student/profile.jsp?success=password");
            } else {
                response.sendRedirect("student/profile.jsp?error=wrongpass");
            }
        }
    }
}
