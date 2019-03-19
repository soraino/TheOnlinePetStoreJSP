package Controller;

import Entity.ApplicationDb;
import com.microsoft.azure.storage.blob.*;
import com.microsoft.rest.v2.http.HttpPipeline;
import com.microsoft.rest.v2.util.FlowableUtil;
import io.reactivex.Flowable;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URL;
import java.nio.ByteBuffer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Locale;
import java.util.UUID;

@WebServlet(name = "CreateProductServlet", urlPatterns = {"/Admin/createProduct"})
public class CreateProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            ApplicationDb dbContext = new ApplicationDb();
            Connection _conn = dbContext.getConnection();

            PreparedStatement ps1  = _conn.prepareStatement("INSERT INTO product (Name, Description, CategoryId, Price, BrandId) VALUES (?, ?, ?, ?, ?);");
            PreparedStatement ps2  = _conn.prepareStatement("INSERT IGNORE INTO brandsincategory (BrandId, CategoryId) VALUES (?, ?);");
            PreparedStatement ps3  = _conn.prepareStatement("SELECT ProductId FROM product where Name = ? and Description = ? and Price = ? and BrandId = ?;");
            PreparedStatement ps4  = _conn.prepareStatement("INSERT INTO images (ImageUrl, ProductId) VALUES (?, ?);");

            ps1.setString(1,request.getParameter("Name"));
            ps1.setString(2,request.getParameter("Description"));
            ps1.setInt(3,Integer.parseInt(request.getParameter("CategoryId")));
            ps1.setDouble(4,Double.parseDouble(request.getParameter("Price")));
            ps1.setInt(5,Integer.parseInt(request.getParameter("BrandId")));

            int rowsAffected = ps1.executeUpdate();
            if(rowsAffected < 0){
                response.sendRedirect("../../../Admin/Products/createProduct?productError=true");
                return;
            }

            ps2.setInt(1,Integer.parseInt(request.getParameter("BrandId")));
            ps2.setInt(2,Integer.parseInt(request.getParameter("CategoryId")));
            rowsAffected = ps2.executeUpdate();

            ps3.setString(1,request.getParameter("Name"));
            ps3.setString(2,request.getParameter("Description"));
            ps3.setDouble(3,Double.parseDouble(request.getParameter("Price")));
            ps3.setInt(4,Integer.parseInt(request.getParameter("BrandId")));

            ResultSet rs3 = ps3.executeQuery();
            if(!rs3.next()){
                response.sendRedirect("../../../Admin/Products/createProduct?brandError=true");
                return;
            }
            int newProdId = rs3.getInt("ProductId");
            String[] images = request.getParameter("Images").split(" &%& ");


            rowsAffected = 0;
            ps4.setInt(2,newProdId);
            for(int i = 0 ; i < images.length; i++){
                ps4.setString(1,images[i]);
                rowsAffected += ps4.executeUpdate();
            }
            if(rowsAffected != images.length){
                response.sendRedirect("../../../Admin/Products/createProduct?imagesError=true");
                return;
            }
            HttpSession session = request.getSession();
            session.removeAttribute("products");
            response.sendRedirect("../../../ProductServlet?sendRedirect=../../Admin/Products");
        }catch(Exception e){
            // woops
        }
    }
}
