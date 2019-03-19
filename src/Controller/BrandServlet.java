package Controller;

import Entity.ApplicationDb;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Hashtable;

@WebServlet(name = "BrandServlet", urlPatterns = {"/BrandServlet"})
public class BrandServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            ApplicationDb dbContext = new ApplicationDb();
            Connection _conn = dbContext.getConnection();

            PreparedStatement ps = _conn.prepareStatement("INSERT INTO brand (Name) VALUES (?); ");
            ps.setString(1,request.getParameter("name"));

            int rowAffected = ps.executeUpdate();

            if(rowAffected > 0){
                HttpSession session = request.getSession();
                session.removeAttribute("brands");
                response.sendRedirect("../Admin/AllBrandsInCategoryServlet");
            }else{
                response.sendRedirect("../Admin/AddBrand?error=true");
            }

        }catch(Exception e){
            response.sendRedirect("../Admin/AddBrand?error=true");
        }
    }

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            ApplicationDb dbContext = new ApplicationDb();
            Connection _conn = dbContext.getConnection();

            PreparedStatement ps = _conn.prepareStatement("UPDATE brand SET DeletedAt= ? WHERE (BrandId = ?);");

            ps.setDate(1,new Date(System.currentTimeMillis()));
            ps.setInt(2,Integer.parseInt(request.getParameter("id")));

            int rowAffected = ps.executeUpdate();
            if(rowAffected > 0){
                HttpSession session = request.getSession();
                session.removeAttribute("brands");
                response.setStatus(200);
                response.setContentType("application/json");
                PrintWriter writer=response.getWriter();
                writer.append("done");
            }else{
                response.setStatus(500);
                response.setContentType("application/json");
                PrintWriter writer=response.getWriter();
                writer.append("Something went wrong");
            }

        }catch(Exception e){
            response.sendRedirect("../Admin/AddBrand?notDeleted=true");
        }

    }

    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            ApplicationDb dbContext = new ApplicationDb();
            Connection _conn = dbContext.getConnection();

            PreparedStatement ps = _conn.prepareStatement("UPDATE brand SET Name = ?, UpdatedAt = ? WHERE (BrandId = ?);");

            ps.setString(1,request.getParameter("name"));
            ps.setDate(2,new Date(System.currentTimeMillis()));
            ps.setInt(3,Integer.parseInt(request.getParameter("id")));

            int rowAffected = ps.executeUpdate();
            if(rowAffected > 0){
                HttpSession session = request.getSession();
                session.removeAttribute("brands");
                response.setStatus(200);
                response.setContentType("application/json");
                PrintWriter writer=response.getWriter();
                writer.append("done");
            }else{
                response.setStatus(500);
                response.setContentType("application/json");
                PrintWriter writer=response.getWriter();
                writer.append("Something went wrong");
            }

        }catch(Exception e){
            response.setStatus(500);
            response.setContentType("application/json");
            PrintWriter writer=response.getWriter();
            writer.append("Something went wrong");
        }
    }
}
