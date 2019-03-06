package Controller;

import com.stripe.Stripe;
import com.stripe.model.Charge;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/Checkout"})
public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try{
            // Set your secret key: remember to change this to your live secret key in production
            // See your keys here: https://dashboard.stripe.com/account/apikeys
            Stripe.apiKey = System.getenv("StripeSecretKey");

            // Token is created using Checkout or Elements!
            // Get the payment token ID submitted by the form:
            String token = request.getParameter("stripeToken");
            int amount = Integer.parseInt(request.getParameter("amount"));
            Map<String, Object> params = new HashMap<>();
            params.put("amount", amount);
            params.put("currency", "sgd");
            params.put("description", "Some Charge");
            params.put("source", token);
            Charge charge = Charge.create(params);
            response.setStatus(200);
            response.setContentType("application/json");
            PrintWriter writer=response.getWriter();
            writer.append("done");
        }catch(Exception e){
            response.setStatus(500);
            response.setContentType("application/json");
            PrintWriter writer=response.getWriter();
            writer.append("Something went wrong");
        }


    }
}
