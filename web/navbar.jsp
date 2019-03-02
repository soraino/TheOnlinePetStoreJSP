<%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 27/2/2019
  Time: 9:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
        <a class="navbar-item" href="https://bulma.io">
            <img src="https://bulma.io/images/bulma-logo.png" width="112" height="28">
        </a>

        <a role="button" class="navbar-burger burger" aria-label="menu" aria-expanded="false" data-target="navbarBasicExample">
            <span aria-hidden="true"></span>
            <span aria-hidden="true"></span>
            <span aria-hidden="true"></span>
        </a>
    </div>

    <div id="navbarBasicExample" class="navbar-menu">
        <div class="navbar-start">
            <a class="navbar-item">
                Home
            </a>

            <div class="navbar-item has-dropdown is-hoverable">
                <a class="navbar-link" href="../ProductServlet?sendRedirect=/Products/index.jsp">
                    Main Store
                </a>

                <div class="navbar-dropdown">
                    <a class="navbar-item" href="../ProductServlet?sendRedirect=/Products/index.jsp">
                        Show all product
                    </a>
                    <a class="navbar-item" href="../ProductServlet?sendRedirect=/Category/index.jsp">
                        Show all category
                    </a>
                    <a class="navbar-item" href="../ProductServlet?sendRedirect=/Products/index.jsp">
                        Show all brands
                    </a>
                </div>
            </div>
        </div>

        <div class="navbar-end">
            <div class="navbar-item">
                <div class="buttons">
                    <a class="button is-primary">
                        Sign up
                    </a>
                    <a class="button is-light">
                        Log in
                    </a>
                    <a class="button is-warning">
                        <strong>Cart</strong>
                    </a>
                </div>
            </div>
        </div>
    </div>
</nav>
