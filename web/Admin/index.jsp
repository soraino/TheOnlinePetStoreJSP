<%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 6/3/2019
  Time: 1:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="../header.html"></jsp:include>
<body>
<%
    if (session.getAttribute("AdminUser") != null) {
        response.sendRedirect("../../../Admin/Products/");
    } else {
%>
<section class="hero is-fullheight is-danger is-bold">
    <div class="hero-body">
        <div class="container">
            <div class="columns is-centered">
                <article class="card is-rounded">
                    <div class="card-content">
                        <h1 class="title has-text-grey-darker">
                            Login
                        </h1>
                        <form action="../Admin/User" method="post">
                            <div class="field">
                                <label class="label">Username:</label>
                                <div class="control has-icons-left">
                                    <input class="input" type="text" placeholder="username" name="Username">
                                    <span class="icon is-small is-left">
                                      <i class="fas fa-user"></i>
                                    </span>
                                </div>
                            </div>
                            <div class="field">
                                <label class="label">Password:</label>
                                <p class="control has-icons-left">
                                    <input class="input" type="password" placeholder="Password" name="Password">
                                    <span class="icon is-small is-left">
                                      <i class="fa fa-lock"></i>
                                    </span>
                                </p>
                            </div>
                            <p class="control">
                                <button type="submit" class="button is-primary is-medium is-fullwidth">
                                    Login
                                </button>
                            </p>
                        </form>
                    </div>
                </article>
            </div>
        </div>
    </div>
</section>
</body>
<%
    }
%>
</html>
