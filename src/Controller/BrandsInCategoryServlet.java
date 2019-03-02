package Controller;

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
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "BrandsInCategoryServlet", urlPatterns = {"/BrandsInCategoryServlet"})
public class BrandsInCategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            ApplicationDb dbContext = new ApplicationDb();
            Connection _conn = dbContext.getConnection();

            PreparedStatement ps = _conn.prepareStatement("Select bic.BrandId as \"Id\" from onlinepetstore.brandsincategory bic, onlinepetstore.category c where c.CategoryId = bic.CategoryId && c.Name = ?");
            ps.setString(1,request.getParameter("category"));
            ResultSet rs = ps.executeQuery();
            List<Integer> brandIds = new ArrayList<>();
            while(rs.next()){
                brandIds.add(rs.getInt("Id"));
            }
            HttpSession session = request.getSession();
            session.setAttribute("brandsIdInCategory",brandIds);
            if(session.getAttribute("brands") == null){
                response.sendRedirect("../ProductServlet?sendRedirect=./singleCategoryProducts.jsp?category="+request.getParameter("category"));
            }else{
                response.sendRedirect("./singleCategoryProducts.jsp?category="+request.getParameter("category"));
            }

        }catch(Exception e){
            // woops
        }
    }
}
