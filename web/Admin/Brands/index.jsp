<%@ page import="Bean.ProductBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Set" %><%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 6/3/2019
  Time: 1:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../../header.html"></jsp:include>
<body>
<jsp:include page="../../adminnavbar.jsp"></jsp:include>
<%
    if (session.getAttribute("AdminUser") != null) {
        HashMap<Integer, String> brands = (HashMap<Integer, String>) session.getAttribute("brands");
%>
<div class="container">
    <a class="button is-success" style="float:right;" href="./AddBrand.jsp">Add Brand</a>
    <br>
    <br>
    <div>
        <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
            <thead>
            <tr>
                <th>Id</th>
                <th>Name</th>
                <th>Categories</th>
                <td>&nbsp;</td>
            </tr>
            </thead>
            <tbody>
            <%
                Set<Integer> keySet = brands.keySet();
                HashMap<Integer, String> categoryInBrands = (HashMap<Integer, String>) session.getAttribute("categoryInBrands");
                for (int key : keySet) {
            %>
            <tr>
                <th><p><%=key%>
                </p></th>
                <th><p><%=brands.get(key)%>
                </p></th>
                <th><p><%=categoryInBrands.get(key)%>
                </p></th>
                <th><a href="./updateBrand.jsp?id=<%=key%>" class="button is-info">Update</a></th>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
<%
    } else {
        response.sendRedirect("../Admin");
    }
%>
</body>

</html>
