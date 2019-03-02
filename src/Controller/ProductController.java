package Controller;

import Bean.ProductBean;

import javax.swing.text.html.parser.Entity;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Application;
import javax.ws.rs.core.GenericEntity;
import javax.ws.rs.core.Response;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import Entity.ApplicationDb;

@Path("product")
public class ProductController {
    private Connection _conn;

    public ProductController(){
        ApplicationDb dbContext = new ApplicationDb();
        _conn = dbContext.getConnection();
    }

    public Response getAllProduct(){
        try{
            PreparedStatement ps = _conn.prepareStatement("Select * from product");
            ResultSet rs = ps.executeQuery();
            List<ProductBean> products = new ArrayList<>();
            while (rs.next()) {
                ProductBean p = new ProductBean();
                p.setCategoryId(rs.getInt("CategoryId"));
                p.setDescription(rs.getString("Description"));
                p.setProductId(rs.getInt("ProductId"));
                p.setName(rs.getString("Name"));
                products.add(p);
            }
            GenericEntity<List<ProductBean>> entity = new GenericEntity<>(products){};
            return Response
                    .status(200)
                    .header("Access-Control-Allow-Origin", "*")
                    .header("Access-Control-Allow-Headers", "origin, content-type, accept, authorization")
                    .header("Access-Control-Allow-Credentials", "true")
                    .header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS, HEAD")
                    .header("Access-Control-Max-Age", "1209600")
                    .entity(entity)
                    .build();
        }catch(Exception e){
            return Response.status(500).build();
        }
    }
}
