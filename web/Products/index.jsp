<%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 27/2/2019
  Time: 9:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="Bean.ProductBean"%>
<%@page import="java.util.List"%>
<html>
<jsp:include page="../header.html"></jsp:include>
<body>
<jsp:include page="../navbar.jsp"></jsp:include>
<div class="container">
    <h1 class="title is-2">Products</h1>
    <div class="columns is-multiline">
        <%
            if(session.getAttribute("products") == null){
                response.sendRedirect("../ProductServlet?sendRedirect=/Products/index.jsp");
            }else{
                List<ProductBean> products = (List<ProductBean>)session.getAttribute("products");
                for (int i = 0; i < products.size(); i++) {
        %>
        <div class="column is-one-fifth" onclick="window.location.href = './singleProduct.jsp?id=<%=i%>'">
            <div class="card">
                <div class="card-image">
                    <figure class="image is-square">
                        <img src="<%=products.get(i).getImages().get(0).getImageUrl()%>" alt="Placeholder image">
                    </figure>
                </div>
                <div class="card-content"
                     style="border-top: grey 1px solid;">
                    <div class="media">
                        <div class="media-content">
                            <p class="title is-4"><%=products.get(i).getName()%></p>
                        </div>
                    </div>

                    <div class="content" >
                        <p>S$<%=String.format("%.2f",products.get(i).getPrice())%></p>
                    </div>
                </div>
            </div>

        </div>
        <%
                }
            }
        %>
    </div>
</div>
</body>
</html>
