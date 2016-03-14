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
        <a href="javascript:void(0);" class="current">New/Edit Vip Group</a>
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
                        <h5>New/Edit Vip Group</h5>
                    </div>

                    <div class="widget-content nopadding">
                        <spring-form:form commandName="vipGroup" class="form-horizontal" method="post" name="basic_validate" id="basic_validate" novalidate="novalidate">
                            <input type="hidden" name="id" value="${vipGroup.id}"/>
                            <div class="control-group">
                                <label class="control-label">Name [Required]</label>
                                <div class="controls">
                                    <spring-form:input path="groupName" maxlength="30" cssStyle="height: 30px;"/>&nbsp;
                                    <spring-form:errors path="groupName" cssClass="help-inline"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Description [Required]</label>
                                <div class="controls">
                                    <spring-form:textarea path="groupDesc" cssClass="span20" rows="4"/>
                                    <spring-form:errors path="groupDesc" cssClass="help-inline"/>
                                </div>
                            </div>
                            <div class="form-actions">
                                <input type="button" value="Back" class="btn btn-success" onclick="window.location.href='${pageContext.request.contextPath}/backend/vipgroupoverview.html?filterName=${filterName}&current=${current}'">
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