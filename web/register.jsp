<%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 3/3/2019
  Time: 10:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<style>
    .links{
        color: #3273dc !important;
        cursor: pointer !important;
        text-decoration: none !important;
    }
    .links:hover{
        color: #363636 !important;
    }
</style>
<jsp:include page="./header.html"></jsp:include>
<body class="layout-default">
<section class="hero is-fullheight is-info is-bold">
    <div class="hero-body">
        <div class="container">
            <div class="columns is-centered">
                <article class="card is-rounded">
                    <div class="card-content">
                        <h1 class="title has-text-grey-darker">
                            Registration
                        </h1>
                        <form action="../User/Register" method="post">
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
                            <div class="field">
                                <label class="label">Confirm Password:</label>
                                <p class="control has-icons-left">
                                    <input class="input" type="password" placeholder="Password" name="ConfirmPassword">
                                    <span class="icon is-small is-left">
                                      <i class="fa fa-lock"></i>
                                    </span>
                                </p>
                            </div>
                            <p class="control">
                                <button type="submit" class="button is-primary is-medium is-fullwidth">
                                    Register
                                </button>
                            </p>
                        </form>
                        <p class="has-text-centered">
                            <a class="links" href="./login.jsp">Log In</a> | <a class="links" href="../">Go Back</a>
                        </p>
                    </div>
                </article>
            </div>
        </div>
    </div>
</section>
</body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
<script>
    const url = new URL(window.location)

    if(url.searchParams.has('error')){
        Swal.fire(
            'Error',
            'Something when wrong in the server, try again later.',
            'error'
        )
    }else if(url.searchParams.has('confirmPassword')){
        Swal.fire(
            'Error',
            `Password doesn't match Confirm Password.`,
            'error'
        )
    }else if(url.searchParams.has('userTaken')){
        Swal.fire(
            'Error',
            'Username has been taken.',
            'error'
        )
    }
</script>
</html>
