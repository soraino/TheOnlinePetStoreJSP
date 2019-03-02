package Controller;

import Bean.ImageBean;
import Bean.ProductBean;
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
import java.util.Hashtable;
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = {"/ProductServlet"})
public class ProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            ApplicationDb dbContext = new ApplicationDb();
            Connection _conn = dbContext.getConnection();

            // create the prepare statement
            PreparedStatement ps1 = _conn.prepareStatement("Select * from product ");
            PreparedStatement ps2 = _conn.prepareStatement("Select * from images ");
            PreparedStatement ps3 = _conn.prepareStatement("Select * from brand");
            PreparedStatement ps4 = _conn.prepareStatement("Select * from Category");

            ResultSet rs1 = ps1.executeQuery();
            ResultSet rs2 = ps2.executeQuery();
            ResultSet rs3 = ps3.executeQuery();
            ResultSet rs4 = ps4.executeQuery();

            // run and get all the products
            List<ProductBean> products = new ArrayList<>();
            HashMap<Integer,Integer> idIndexTable = new HashMap<>();
            int index = 0;
            while (rs1.next()) {
                if(rs1.getDate("DeleteAt") == null) {
                    ProductBean p = new ProductBean();

                    p.setCategoryId(rs1.getInt("CategoryId"));
                    p.setDescription(rs1.getString("Description"));
                    p.setProductId(rs1.getInt("ProductId"));
                    p.setName(rs1.getString("Name"));
                    p.setBrandId(rs1.getInt("BrandId"));
                    p.setPrice(rs1.getDouble("Price"));

                    products.add(p);
                    idIndexTable.put(p.getProductId(), index);
                }
                index++;
            }

            while(rs2.next()){
                ImageBean image = new ImageBean();

                int productId = rs2.getInt("ProductId");
                image.setImageId(rs2.getInt("ImageId"));
                image.setProductID(productId);
                image.setImageUrl(rs2.getString("ImageUrl"));
                if(products.get(idIndexTable.get(productId)) != null){
                    products.get(idIndexTable.get(productId)).getImages().add(image);
                }
            }


            HashMap<Integer,String> brandsTable = new HashMap<>();
            while(rs3.next()){
                int brandId = rs3.getInt("BrandId");
                String name = rs3.getString("Name");
                brandsTable.put(brandId,name);
            }

            HashMap<Integer,String> categoryTable = new HashMap<>();
            while(rs4.next()){
                int categoryId = rs4.getInt("CategoryId");
                String name = rs4.getString("Name");
                categoryTable.put(categoryId,name);
            }

            // store all of it in the session
            HttpSession session = request.getSession();
            session.setAttribute("products", products);
            session.setAttribute("categories",categoryTable);
            session.setAttribute("brands",brandsTable);
        }catch(Exception e){
            // woops
        }
        response.sendRedirect(request.getParameter("sendRedirect"));
    }
}
