<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html>
<head>
	<title>App Market Backend Management System</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/maruti-login.css" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
</head>

<body>
    <div id="logo">
        <img src="${pageContext.request.contextPath}/images/login-logo.png" alt="" />
    </div>
    <div id="loginbox">
        <form id="loginform" class="form-vertical" action="${pageContext.request.contextPath}/j_spring_security_check" method="post">
             <div class="control-group normal_text">
                 <h3>App Market Backend Management System V${projectVersion}</h3>
                 <h6>Notice:Suggest use IE, FireFox or Chrome browser</h6>
             </div>
             <div class="control-group">
                <div class="controls">
                    <div class="main_input_box">
                        <span class="add-on"><i class="icon-user"></i></span><input name="j_username" type="text" placeholder="Username"/>
                    </div>
                </div>
             </div>
             <div class="control-group">
                <div class="controls">
                    <div class="main_input_box">
                        <span class="add-on"><i class="icon-lock"></i></span><input name="j_password" type="password" placeholder="Password" />
                    </div>
                </div>
             </div>
            <div class="form-actions">
                <span class="pull-right"><input type="submit" class="btn btn-success" value="Login" /></span>
            </div>
            <c:if test="${SPRING_SECURITY_LAST_EXCEPTION != null}">
                <label style="color: red; padding-left: 100px;">    Sorry, username or password input is not correct!</label>
            </c:if>
        </form>
    </div>

</body>

</html>
