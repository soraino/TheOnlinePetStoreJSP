<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 6/3/2019
  Time: 11:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../../header.html"></jsp:include>
<body>
<jsp:include page="../../adminnavbar.jsp"></jsp:include>
<%
    if (session.getAttribute("AdminUser") == null) {
        response.sendRedirect("../../../Admin/");
    } else {
        if (session.getAttribute("brands") != null) {
            HashMap<Integer, String> brands = (HashMap<Integer, String>) session.getAttribute("brands");
%>
<div class="container" id="app">
    <div class="field">
        <label class="label">Brand Name</label>
        <div class="control">
            <input class="input" type="text" placeholder="Brand Name" name="name" v-model="name" required>
        </div>
    </div>
    <button class="button is-success" type="button" @click="updateBrand()">Submit</button>
    <button class="button is-danger" type="button" @click="deleteBrand()">Delete</button>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script>
    new Vue({
        el: '#app',
        data: {
            name: '<%=brands.get(Integer.parseInt(request.getParameter("id")))%>',
        },
        methods: {
            async updateBrand() {
                try {
                    const response = await axios.put('../../BrandServlet?id=<%=request.getParameter("id")%>&name=' + this.name)
                    window.location.replace('../../Admin/AllBrandsInCategoryServlet')
                } catch {
                    Swal.fire(
                        'Error',
                        'Something when wrong in the server, try again later.',
                        'error'
                    )
                }
            },
            async deleteBrand() {
                try {
                    const response = await axios.delete('../../BrandServlet?id=<%=request.getParameter("id")%>')
                    window.location.replace('../../Admin/AllBrandsInCategoryServlet')
                } catch {
                    Swal.fire(
                        'Error',
                        'Something when wrong in the server, try again later.',
                        'error'
                    )
                }

            }
        }
    })
</script>
<%
        } else {
            response.sendRedirect("../../Admin/AllBrandsInCategoryServlet");
        }
    }
%>
</html>
