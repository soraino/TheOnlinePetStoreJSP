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
import java.util.HashMap;
import java.util.List;

@WebServlet(name = "AllBrandsInCategoryServlet", urlPatterns = {"/Admin/AllBrandsInCategoryServlet"})
public class AllBrandsInCategoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            ApplicationDb dbContext = new ApplicationDb();
            Connection _conn = dbContext.getConnection();

            PreparedStatement ps = _conn.prepareStatement("Select b.BrandId, c.Name from onlinepetstore.brandsincategory bic, onlinepetstore.brand b,onlinepetstore.category c where bic.BrandId = b.BrandId and c.CategoryId = bic.CategoryId");
            ResultSet rs = ps.executeQuery();
            HashMap<Integer,String> brandsCategory = new HashMap<>();
            while(rs.next()){
                if(brandsCategory.get(rs.getInt("BrandId")) != null){
                    String categories = brandsCategory.get(rs.getInt("BrandId"))+ ", "+rs.getString("Name");
                    brandsCategory.put(rs.getInt("BrandId"),categories);
                }else{
                    brandsCategory.put(rs.getInt("BrandId"),rs.getString("Name"));
                }

            }
            HttpSession session = request.getSession();
            session.setAttribute("categoryInBrands",brandsCategory);
            if(session.getAttribute("brands") == null){
                response.sendRedirect("../ProductServlet?sendRedirect=../Admin/Brands/");
            }else{
                response.sendRedirect("../Admin/Brands");
            }

        }catch(Exception e){
            // woops
        }
    }
}
