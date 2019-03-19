<%--
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
<div class="container">
    <%
        if (session.getAttribute("AdminUser") == null) {
            response.sendRedirect("../../../Admin/");
        }else{
    %>
    <form method="post" action="../../BrandServlet">
        <div class="field">
            <label class="label">Brand Name</label>
            <div class="control">
                <input class="input" type="text" placeholder="Brand Name" name="name" required>
            </div>
        </div>
        <button type="submit" class="button is-info">Submit</button>
    </form>
</div>
</body>
<%
    }
%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
<script>
    const url = new URL(window.location)

    if(url.searchParams.has('error')) {
        Swal.fire(
            'Error',
            'Something when wrong in the server, try again later.',
            'error'
        )
    }
</script>
</html>
