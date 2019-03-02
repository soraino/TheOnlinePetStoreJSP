<%@ page import="Bean.ImageBean" %>
<%@ page import="java.util.List" %>
<%@ page import="Bean.ProductBean" %>
<%@ page import="java.util.Hashtable" %>
<%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 28/2/2019
  Time: 5:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../header.html"></jsp:include>
<style>
    .center {
        display: block;
        margin-left: auto;
        margin-right: auto;
        width: 50%;
        height: 400px;
    }
</style>
<body>
    <jsp:include page="../navbar.jsp"></jsp:include>
    <div class="container" id="app">
        <div class="columns">
            <div class="column is-half">
                <carousel :data="images"></carousel>
            </div>
            <div class="column is-half">
                <%
                    ProductBean product = null;
                    int productId = Integer.parseInt(request.getParameter("id"));
                    if(session.getAttribute("products") == null){
                        response.sendRedirect("../ProductServlet?redirect=SingleProduct.jsp");
                    }else {
                        product = ((List<ProductBean>) session.getAttribute("products")).get(productId);
                        List<ImageBean> images = product.getImages();
                %>
                <h1 class="title is-2"><%=product.getName()%></h1>
                <small>Brand:
                    <a>
                        <%=((Hashtable<Integer,String>)session.getAttribute("brands")).get(product.getBrandId())%>
                    </a>
                </small>
                <br>
                <small>Category:
                    <a>
                        <%=((Hashtable<Integer,String>)session.getAttribute("categories")).get(product.getCategoryId())%>
                    </a>
                </small>
                <br>
                <br>
                <p class="has-text-weight-semibold">Price: S$<%=String.format("%.2f", product.getPrice())%></p>
                <br>
                <p><%=product.getDescription()%></p>
                <br>
                <br>
                <button type="button" class="button is-success" style="float: right;"> Add to Cart</button>
            </div>

        </div>
    </div>
</body>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="../PluginScript/vue-carousel.min.js"></script>

<script>
    new Vue({
        el:'#app',
        data:{
            images:[
<%
           for(ImageBean img : product.getImages()){
               %>
               '<div><img class="center" src="<%=img.getImageUrl()%>"></div>',
               <%
           }
       }
%>
            ],
        },
    })
</script>
</html>

