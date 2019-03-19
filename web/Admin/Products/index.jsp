<%@ page import="Bean.ProductBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 6/3/2019
  Time: 1:23 PM
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
%>
<div class="container">
    <a class="button is-success" style="float:right;" href="./addProduct.jsp">Add Product</a>
    <br>
    <br>
    <div>
        <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
            <tr>
                <th>Id</th>
                <th>Image</th>
                <th>Name</th>
                <th>Brand</th>
                <th>Category</th>
                <th>Price</th>
                <td>&nbsp;</td>
            </tr>
            </thead>
            <tbody>
            <%
                List<ProductBean> products = (List<ProductBean>) session.getAttribute("products");

                for (int i = 0; i < products.size(); i++) {
                    ProductBean product = products.get(i);
            %>
            <tr>
                <th><p><%=product.getProductId()%>
                </p></th>
                <th><img src="<%=product.getImages().get(0).getImageUrl()%>" class="image is-128x128"></th>
                <th><p><%=product.getName()%>
                </p></th>
                <th><p><%=((HashMap<Integer, String>) session.getAttribute("brands")).get(product.getBrandId())%>
                </p></th>
                <th><p><%=((HashMap<Integer, String>) session.getAttribute("categories")).get(product.getCategoryId())%>
                </p></th>
                <th><p><%=String.format("%.2f", product.getPrice())%>
                </p></th>
                <th><a href="./singleProductUpdate.jsp?id=<%=i%>" class="button is-info">Update</a></th>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
<%
    }
%>
</body>
</html>
