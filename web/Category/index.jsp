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
            if (session.getAttribute("brands") == null) {
                response.sendRedirect("../ProductServlet?sendRedirect=/Products/index.jsp");
            } else {
                HashMap<Integer, String> categories = (HashMap<Integer, String>) session.getAttribute("categories");
                for (String category : categories.values()) {
        %>
        <div class="column is-one-fifth" @click="redirectPage('<%=category%>')">
            <div class="card">
                <div class="card-image">
                    <figure class="image is-square">
                        <img v-bind:src="categoryImages['<%=category%>'] || 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/No_image_available_600_x_450.svg/600px-No_image_available_600_x_450.svg.png'"
                        >
                    </figure>
                </div>
                <div class="card-content"
                     style="border-top: grey 1px solid;">
                    <div class="media">
                        <div class="media-content">
                            <p class="title is-4"><%=category%>
                            </p>
                        </div>
                    </div>
                </div>
                <footer class="card-footer">
                    <a href="./singleCategoryProducts.jsp?category=<%=category%>" class="card-footer-item has-text-centered">Show all products</a>
                    <a href="../BrandsInCategoryServlet?category=<%=category%>" class="card-footer-item has-text-centered">Show all brands</a>
                </footer>
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
            categoryImages: {
                <%
                    for(String category : categories.values()){
                %>
                '<%=category%>': '',
                <%
                    }
                %>
            },
            categories: [
                <%
                    for(String category : categories.values()){
                    %>
                '<%=category%>',
                <%
                    }
                }
            %>
            ]
        },
        async mounted() {
            for (i = 0; i < this.categories.length; i++) {
                try {
                    const response = await axios.get('https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=43c5fbe2094c3f4e2c56f0a7e393d16f&tags=pet '+this.categories[i]+', pet products&format=json&nojsoncallback=1')
                    if (response.data.photos.photo.length > 0) {
                        const randIndex = Math.floor((Math.random() * response.data.photos.photo.length));
                        const farm = response.data.photos.photo[randIndex].farm
                        const server = response.data.photos.photo[randIndex].server
                        const id = response.data.photos.photo[randIndex].id
                        const secret = response.data.photos.photo[randIndex].secret
                        this.categoryImages[this.categories[i]] = 'https://farm'+farm+'.staticflickr.com/'+server+'/'+id+'_'+secret+'.jpg'
                    } else {
                        this.categoryImages[this.categories[i]] = 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/No_image_available_600_x_450.svg/600px-No_image_available_600_x_450.svg.png'
                    }
                } catch {
                    alert('woops no images')
                    this.categoryImages[this.categories[i]] = 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/No_image_available_600_x_450.svg/600px-No_image_available_600_x_450.svg.png'
                }

            }

        }
    })
</script>
</html>
