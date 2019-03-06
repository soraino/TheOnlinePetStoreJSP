package Controller;

import Bean.UserBean;
import Entity.ApplicationDb;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "UserLoginServlet", urlPatterns = {"/User/Login"})
public class UserLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ApplicationDb dbContext = new ApplicationDb();
            Connection _conn = dbContext.getConnection();

            PreparedStatement ps = _conn.prepareStatement("Select * from user where RoleId = 2 and Username = ?");
            ps.setString(1, request.getParameter("Username"));

            ResultSet rs = ps.executeQuery();

            UserBean user = new UserBean();
            if (rs.next()) {
                user.setUserId(rs.getInt("UserId"));
                user.setHashPrefix(rs.getString("HashPrefix"));
                user.setUsername(rs.getString("Username"));
                user.setPasswordHash(rs.getString("PasswordHash"));
                if (user.checkPassword(request.getParameter("Password"))) {
                    HttpSession session = request.getSession();
                    session.setAttribute("Username", user.getUsername());
                    response.sendRedirect("../");
                } else {
                    response.sendRedirect("../login.jsp?loginFailed=true");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("../login.jsp?error=true");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
