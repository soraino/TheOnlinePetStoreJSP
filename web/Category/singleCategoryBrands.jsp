<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 2/3/2019
  Time: 3:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../header.html"></jsp:include>
<body>
<jsp:include page="../navbar.jsp"></jsp:include>
<div class="container" id="app">
    <h1 class="title is-2">
        Brands in <%=request.getParameter("category")%> category
    </h1>
    <div class="columns is-multiline">
        <%
            if (session.getAttribute("brandsIdInCategory") == null
                    || !session.getAttribute("currCategoryBrands").equals(request.getParameter("category"))) {
                response.sendRedirect("../BrandsInCategoryServlet?category="+request.getParameter("category"));
            } else {
                HashMap<Integer, String> brands = (HashMap<Integer, String>) session.getAttribute("brands");
                List<Integer> brandId = (List<Integer>)session.getAttribute("brandsIdInCategory");
                for (int key : brandId) {
        %>
        <div class="column is-one-fifth" @click="redirectPage('<%=brands.get(key)%>')">
            <div class="card">
                <div class="card-image">
                    <figure class="image is-square">
                        <img v-bind:src="brandImages['<%=brands.get(key)%>'] || 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/No_image_available_600_x_450.svg/600px-No_image_available_600_x_450.svg.png'">
                    </figure>
                </div>
                <div class="card-content"
                     style="border-top: grey 1px solid;">
                    <div class="media">
                        <div class="media-content">
                            <p class="title is-4"><%=brands.get(key)%>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>

    </div>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script>
    new Vue({
        el: '#app',
        data: {
            brands: [
                <%
                    for(int key : brandId){
                    %>
                '<%=brands.get(key)%>',
                <%
                    }
                }
            %>
            ]
        },
        methods: {
            redirectPage(brand) {
                window.location.href = './singleBrand.jsp?brand='+brand
            },
        },
        computed:{
            brandImages(){
                return this.brands.reduce(function(acc, curr){
                    acc[curr] = 'https://logo.clearbit.com/'+curr.toLowerCase()+'.com'
                    return acc
                },{})
            }
        }
    })
</script>
</html>
