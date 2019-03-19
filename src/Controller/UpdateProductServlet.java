package Controller;

import Entity.ApplicationDb;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "UpdateProductServlet", urlPatterns = {"/Admin/UpdateProductServlet"})
public class UpdateProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            ApplicationDb dbContext = new ApplicationDb();
            Connection _conn = dbContext.getConnection();

            int rowsAffected = 0;

            PreparedStatement ps1  = _conn.prepareStatement("UPDATE product SET Name = ? , Description= ?, CategoryId = ?, Price = ?, BrandId = ? WHERE(ProductId=?)");
            PreparedStatement ps2  = _conn.prepareStatement("INSERT IGNORE INTO brandsincategory (BrandId, CategoryId) VALUES (?, ?);");
            PreparedStatement ps3  = _conn.prepareStatement("SELECT COUNT(*)as number FROM product WHERE BrandId = ? AND CategoryId=?;");
            PreparedStatement ps4  = _conn.prepareStatement("UPDATE images SET DeletedAt = ? WHERE (ImageId = ?);");
            PreparedStatement ps5  = _conn.prepareStatement("INSERT INTO images (ImageUrl, ProductId) VALUES (?, ?);");

            ps1.setString(1,request.getParameter("Name"));
            ps1.setString(2,request.getParameter("Description"));
            ps1.setInt(3,Integer.parseInt(request.getParameter("CategoryId")));
            ps1.setDouble(4,Double.parseDouble(request.getParameter("Price")));
            ps1.setInt(5,Integer.parseInt(request.getParameter("BrandId")));
            ps1.setInt(6,Integer.parseInt(request.getParameter("id")));

            rowsAffected = ps1.executeUpdate();
            if(rowsAffected <= 0){
                response.sendRedirect("../../../Admin/Products/singleProductUpdate.jsp?productError=true&id="+request.getParameter("id"));
                return;
            }

            ps2.setInt(1,Integer.parseInt(request.getParameter("BrandId")));
            ps2.setInt(2,Integer.parseInt(request.getParameter("CategoryId")));
            ps2.executeUpdate();

            // brands in category handling if there's no more product in a specific category
            // and the brands dont have anymore products in the category
            ps3.setInt(1,Integer.parseInt(request.getParameter("oldBrand")));
            ps3.setInt(2,Integer.parseInt(request.getParameter("oldCategory")));

            ResultSet rs = ps3.executeQuery();
            if(rs.next()){
                int rowsNumber = rs.getInt("number");
                if(rowsNumber == 0){
                    PreparedStatement ps6  = _conn.prepareStatement("DELETE FROM brandsincategory WHERE BrandId = ? AND CategoryId = ?;");
                    ps6.setInt(1,Integer.parseInt(request.getParameter("oldBrand")));
                    ps6.setInt(2,Integer.parseInt(request.getParameter("oldCategory")));

                    rowsAffected = ps6.executeUpdate();
                }
            }

            rowsAffected = 0;

            ps4.setDate(1,new Date(System.currentTimeMillis()));
            String [] imageIds = request.getParameter("RemovedImages").split(" &%& ");
            for(String data : imageIds){
                int test = Integer.parseInt(data);
                ps4.setInt(2,test);
                rowsAffected += ps4.executeUpdate();
            }
            if(rowsAffected != imageIds.length){
                response.sendRedirect("../../../Admin/Products/singleProductUpdate.jsp?imageError=true&id="+request.getParameter("id"));
                return;
            }

            String[] images = request.getParameter("Images").split(" &%& ");

            rowsAffected = 0;
            // add more images
            ps5.setInt(2,Integer.parseInt(request.getParameter("id")));
            for(int i = 0 ; i < images.length; i++){
                ps5.setString(1,images[i]);
                rowsAffected += ps5.executeUpdate();
            }
            if(rowsAffected != images.length){
                response.sendRedirect("../../../Admin/Products/singleProductUpdate.jsp?imageError=true&id="+request.getParameter("id"));
                return;
            }

        }catch(Exception e){

        }
        response.sendRedirect("../../../ProductServlet?sendRedirect=../../Admin/Products");
    }
}
