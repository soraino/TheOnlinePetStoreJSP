<%--
  Created by IntelliJ IDEA.
  User: lolsp
  Date: 6/3/2019
  Time: 4:55 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="../header.html"></jsp:include>
<body>
<jsp:include page="../navbar.jsp"></jsp:include>
<div class="container">
    <form action="../User/updateCreds" method="post">
        <div class="field">
            <label class="label">Old Password:</label>
            <div class="control has-icons-left">
                <input class="input" type="password" placeholder="new Password" name="OldPassword">
                <span class="icon is-small is-left">
                                      <i class="fa fa-lock"></i>
                                    </span>
            </div>
        </div>
        <div class="field">
            <label class="label">New Password:</label>
            <p class="control has-icons-left">
                <input class="input" type="password" placeholder="Old Password" name="NewPassword">
                <span class="icon is-small is-left">
                                      <i class="fa fa-lock"></i>
                                    </span>
            </p>
        </div>
        <div class="field">
            <label class="label">Confirm new Password:</label>
            <p class="control has-icons-left">
                <input class="input" type="password" placeholder="Confirm Password" name="ConfirmPassword">
                <span class="icon is-small is-left">
                                      <i class="fa fa-lock"></i>
                                    </span>
            </p>
        </div>
        <p class="control">
            <button type="submit" class="button is-primary is-medium is-fullwidth">
                Update
            </button>
        </p>
    </form>
</div>

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
    }else if(url.searchParams.has('done')){
        Swal.fire(
            'Success',
            'Password is updated',
            'Success'
        )
    }
</script>
</html>
