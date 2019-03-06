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

@WebServlet(name = "UserCredentialServlet", urlPatterns = {"/User/updateCreds"})
public class UserCredentialServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ApplicationDb dbContext = new ApplicationDb();
        Connection _conn = dbContext.getConnection();
        try{
            String oldPassword = request.getParameter("OldPassword");
            String newPassword = request.getParameter("NewPassword");
            String newConfirmPassword = request.getParameter("ConfirmPassword");
            if(newPassword.equals(newConfirmPassword)){
                PreparedStatement ps = _conn.prepareStatement("Select * from user where RoleId = 2 and Username = ?");
                HttpSession session = request.getSession();
                ps.setString(1, session.getAttribute("Username").toString());

                ResultSet rs = ps.executeQuery();
                if(rs.next()){
                    UserBean user = new UserBean();
                    user.setUserId(rs.getInt("UserId"));
                    user.setHashPrefix(rs.getString("HashPrefix"));
                    user.setUsername(rs.getString("Username"));
                    user.setPasswordHash(rs.getString("PasswordHash"));
                    if (user.checkPassword(oldPassword)){
                        user.generatePasswordHash(newPassword);

                        PreparedStatement updatePs = _conn.prepareStatement("Update user set PasswordHash = ? , HashPrefix = ? where RoleId = 2 and Username = ? ");
                        updatePs.setString(1,user.getPasswordHash());
                        updatePs.setString(2,user.getHashPrefix());
                        updatePs.setString(3,user.getUsername());

                        int rowsAffected = updatePs.executeUpdate();
                        if(rowsAffected > 0){
                            response.sendRedirect("../User?done=true");
                        }else{
                            response.sendRedirect("../User?error=true");
                        }
                    }else{
                        response.sendRedirect("../User?error=true");
                    }
                }
            }else{
                response.sendRedirect("../User?confirmPassword=true");
            }
        }catch(Exception e){
            response.sendRedirect("../User?error=true");
        }
    }
}
