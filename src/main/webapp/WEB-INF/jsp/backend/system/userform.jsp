<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="spring-form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>App Market Backend Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/uniform.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/select2.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/maruti-style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/maruti-media.css" class="skin-color" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript"></script>
</head>
<body>

<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
        <a href="${pageContext.request.contextPath}/backend/dashboard.html" class="tip-bottom"><i class="icon-home"></i> Dashboard</a>
        <a href="javascript:void(0);" class="current">New/Edit System User</a>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">
                    <div class="widget-title">
                        <span class="icon">
                            <i class="icon-info-sign"></i>
                        </span>
                        <h5>New/Edit System User</h5>
                    </div>

                    <div class="widget-content nopadding">
                        <spring-form:form commandName="user" class="form-horizontal" method="post" name="basic_validate" id="basic_validate" novalidate="novalidate">
                            <input type="hidden" name="id" value="${user.id}"/>
                            <div class="control-group">
                                <label class="control-label">Name [Required]</label>
                                <div class="controls">
                                    <spring-form:input path="name" maxlength="30" cssStyle="height: 30px;"/>&nbsp;
                                    <spring-form:errors path="name" cssClass="help-inline"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Worker Code(username) [Required]</label>
                                <div class="controls">
                                    <c:set var="justRead" value="false"/>
                                    <c:if test="${user.id > 0}">
                                        <c:set var="justRead" value="true"/>
                                    </c:if>
                                    <spring-form:input path="username" maxlength="30" cssStyle="height:30px;" readonly="${justRead}"/>&nbsp;
                                    <spring-form:errors path="username" cssClass="help-inline"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Contact Way</label>
                                <div class="controls">
                                    <spring-form:input id="contactWay" path="contactWay" cssStyle="height:30px;"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">User Roles</label>
                                <div class="controls">
                                    <label><input type="checkbox" name="roleUser" value="ROLE_ADMIN"
                                            <c:if  test="${user.hasRoleAdmin}"> checked</c:if>
                                                                        />&nbsp;&nbsp;System Administrator</label>

                                    <label><input type="checkbox" name="roleUser" value="ROLE_APP_INFO"
                                            <c:if  test="${user.hasRoleAppInfo}"> checked</c:if>
                                                                        />&nbsp;&nbsp;App Info Role</label>

                                    <label><input type="checkbox" name="roleUser" value="ROLE_APP_STATUS"
                                            <c:if  test="${user.hasRoleAppStatus}"> checked</c:if>
                                                                        />&nbsp;&nbsp;App Status Check Role</label>

                                    <label><input type="checkbox" name="roleUser" value="ROLE_APP_STATISTIC"
                                            <c:if  test="${user.hasRoleAppStatistic}"> checked</c:if>
                                                                        />&nbsp;&nbsp;System Statistic Role</label>

                                    <label><input type="checkbox" name="roleUser" value="ROLE_APP_RECOMMEND"
                                            <c:if  test="${user.hasRoleAppRecommend}"> checked</c:if>
                                                                        />&nbsp;&nbsp;Box Foreground Page Setting Role</label>
                                    <spring-form:errors path="password" cssClass="help-inline"/>
                                </div>
                            </div>
                            <div class="form-actions">
                                <input type="button" value="Back" class="btn btn-success" onclick="window.location.href='${pageContext.request.contextPath}/backend/useroverview.html?filername=${filername}&current=${current}'">
                                &nbsp;
                                <input type="submit" value="Save" class="btn btn-success">
                            </div>
                        </spring-form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>