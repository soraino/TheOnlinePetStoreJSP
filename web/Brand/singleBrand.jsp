<%@ page import="Bean.ProductBean" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 2/3/2019
  Time: 5:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../header.html"></jsp:include>
<body>
<jsp:include page="../navbar.jsp"></jsp:include>
<div class="container">
    <%
        if (session.getAttribute("products") == null) {
            response.sendRedirect("../ProductServlet?sendRedirect=/Products/index.jsp");
        } else {
            int brandId = getKey(
                    (HashMap<Integer, String>) session.getAttribute("brands"),
                    request.getParameter("brand")
            );
            if (brandId != -1) {
    %>
    <h1 class="title is-2">
        Brand: <%=request.getParameter("brand")%>
    </h1>
    <div class="columns is-multiline">
        <%
            List<ProductBean> products = (List<ProductBean>) session.getAttribute("products");
            for (int i = 0; i < products.size(); i++) {
                if (products.get(i).getBrandId() == brandId) {
        %>
        <div class="column is-one-fifth" onclick="window.location.href = './SingleProduct.jsp?id=<%=i%>'">
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
                            <p class="title is-4"><%=products.get(i).getName()%>
                            </p>
                        </div>
                    </div>

                    <div class="content">
                        <p>S$<%=String.format("%.2f", products.get(i).getPrice())%>
                        </p>
                    </div>
                </div>
            </div>

        </div>
        <%
                        }
                    }
                }else{
                    // freaking hacker
                    // stop fucking with the parameters
                    response.sendRedirect("https://www.youtube.com/watch?v=dQw4w9WgXcQ");
                }
            }
        %>
    </div>

</div>
</body>
</html>
<%!
    // get the key of the hashtable based on the value
    public int getKey(HashMap<Integer, String> table, String value) {
        Iterator<Integer> keys = table.keySet().iterator();
        while (keys.hasNext()) {
            int brandId = keys.next();
            if (table.get(brandId).equals(value)) {
                return brandId;
            }
        }
        return -1;
    }
%>