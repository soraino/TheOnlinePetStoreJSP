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

@WebServlet(name = "UserRegisterServlet", urlPatterns = {"/User/Register"})
public class UserRegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ApplicationDb dbContext = new ApplicationDb();
            Connection _conn = dbContext.getConnection();

            String username = request.getParameter("Username");
            String password = request.getParameter("Password");
            String confirmPassword = request.getParameter("ConfirmPassword");
            if (password.equals(confirmPassword)) {
                PreparedStatement ps1 = _conn.prepareStatement("Select Username from user where RoleId = 2 and Username = ?");
                ps1.setString(1, request.getParameter("Username"));
                ResultSet rs = ps1.executeQuery();

                if (rs.next()) {
                    response.sendRedirect("../register.jsp?userTaken=true");
                } else {
                    UserBean newUser = new UserBean();
                    newUser.setUsername(username);
                    newUser.generatePasswordHash(password);
                    PreparedStatement ps2 = _conn.prepareStatement("Insert into user(Username,PasswordHash,HashPrefix,roleId) values(?,?,?,2)");
                    ps2.setString(1, username);
                    ps2.setString(2, newUser.getPasswordHash());
                    ps2.setString(3, newUser.getHashPrefix());

                    int affectedRows = ps2.executeUpdate();
                    if (affectedRows > 0) {
                        HttpSession session = request.getSession();
                        session.setAttribute("Username", username);
                        response.sendRedirect("../");
                    } else {
                        response.sendRedirect("../register.jsp?error=true");
                    }
                }
            } else {
                response.sendRedirect("../register.jsp?confirmPassword=true");
            }


        } catch (Exception e) {
            response.sendRedirect("../register.jsp?error=true");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
