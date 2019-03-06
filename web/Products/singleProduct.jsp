<%@ page import="Bean.ImageBean" %>
<%@ page import="java.util.List" %>
<%@ page import="Bean.ProductBean" %>
<%@ page import="java.util.HashMap" %>
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
                    if(session.getAttribute("products") == null || session.getAttribute("brands") == null|| session.getAttribute("categories") == null){
                        response.sendRedirect("../ProductServlet?sendRedirect=singleProduct.jsp?id="+request.getParameter("id"));
                    }else {
                        product = ((List<ProductBean>) session.getAttribute("products")).get(productId);
                        List<ImageBean> images = product.getImages();
                %>
                <h1 class="title is-2"><%=product.getName()%></h1>
                <small>Brand:
                    <a>
                        <%=((HashMap<Integer,String>)session.getAttribute("brands")).get(product.getBrandId())%>
                    </a>
                </small>
                <br>
                <small>Category:
                    <a>
                        <%=((HashMap<Integer,String>)session.getAttribute("categories")).get(product.getCategoryId())%>
                    </a>
                </small>
                <br>
                <br>
                <p class="has-text-weight-semibold">Price: S$<%=String.format("%.2f", product.getPrice())%></p>
                <br>
                <p><%=product.getDescription()%></p>
                <br>
                <br>
                <%
                    if(session.getAttribute("Username") != null){
                %>
                <button type="button" class="button is-success" style="float: right;" @click="addToCart()"> Add to Cart</button>
                <%
                    }else{
                %>
                <a href="../../login.jsp" class="button">Login to add this item to cart</a>
                <%
                    }
                %>
            </div>

        </div>
    </div>
</body>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="../PluginScript/vue-carousel.min.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.8.5/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.8.5/firebase-database.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.8.5/firebase.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
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
%>
            ],
        },
        methods:{
            async addToCart(){
                try {
                    const database = firebase.database().ref('Cart/<%=session.getAttribute("Username")%>')
                    await database.push({
                        id: <%=product.getProductId()%>,
                        name: '<%=product.getName()%>',
                        price:<%=String.format("%.2f", product.getPrice())%>,
                        image:'<%=product.getImages().get(0).getImageUrl()%>'
                    })
                    Swal.fire(
                        'Success',
                        'Items has been added.',
                        'Success'
                    )
                }catch{
                    Swal.fire(
                        'Error',
                        'Something when wrong in the server, try again later.',
                        'error'
                    )
                }
            }
        },
        mounted(){
            const config = {
                apiKey: " AIzaSyC3lPK-3Y5O_OUdUoDW57tBVZeYNmzEx2o ",
                authDomain: "theonlinepetstore-f196f.firebaseapp.com",
                databaseURL: "https://theonlinepetstore-f196f.firebaseio.com/",
                projectId: "theonlinepetstore-f196f",
            }
            firebase.initializeApp(config);
        }
    })
</script>
<%}%>
</html>

