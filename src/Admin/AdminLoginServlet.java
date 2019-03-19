package Admin;

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

@WebServlet(name = "AdminLoginServlet", urlPatterns = {"/Admin/User"})
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ApplicationDb dbContext = new ApplicationDb();
            Connection _conn = dbContext.getConnection();

            PreparedStatement ps = _conn.prepareStatement("Select * from user where RoleId = 1 and Username = ?");
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
                    session.setAttribute("AdminUser", user.getUsername());
                    response.sendRedirect("../../ProductServlet?sendRedirect=../../Admin/Products");
                } else {
                    response.sendRedirect("../Admin/?loginFailed=true");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("../Admin/?error=true");
        }
    }
}
