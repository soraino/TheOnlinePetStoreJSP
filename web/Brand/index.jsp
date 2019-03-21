<%@ page import="java.util.HashMap" %>
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
    <div class="columns is-multiline">
        <%
            if (session.getAttribute("categories") == null) {
                response.sendRedirect("../ProductServlet?sendRedirect=/Products/index.jsp");
            } else {
                HashMap<Integer, String> brands = (HashMap<Integer, String>) session.getAttribute("brands");
                for (String brand : brands.values()) {
        %>
        <div class="column is-one-fifth" @click="redirectPage('<%=brand%>')">
            <div class="card">
                <div class="card-image">
                    <figure class="image is-square">
                        <img v-bind:src="brandImages['<%=brand%>'] || 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/No_image_available_600_x_450.svg/600px-No_image_available_600_x_450.svg.png'" alt="<%=brand%>">
                    </figure>
                </div>
                <div class="card-content"
                     style="border-top: grey 1px solid;">
                    <div class="media">
                        <div class="media-content">
                            <p class="title is-4"><%=brand%>
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
                    for(String brand : brands.values()){
                    %>
                '<%=brand%>',
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
