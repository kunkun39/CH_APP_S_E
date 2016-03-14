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
        <a href="javascript:void(0);" class="current">Add/Edit STB Mac Rang</a>
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
                        <h5>Add/Edit STB Mac Rang [the STB mac just between in this mac range can access app store]</h5>
                    </div>

                    <div class="widget-content nopadding">
                        <spring-form:form commandName="client" class="form-horizontal" method="post" name="basic_validate" id="basic_validate" novalidate="novalidate">
                            <input type="hidden" name="clientId" value="${client.id}"/>
                            <div class="control-group">
                                <label class="control-label">Range From [Required]</label>
                                <div class="controls">
                                    <spring-form:input path="macFrom" maxlength="17" cssStyle="height: 30px;"/>&nbsp;
                                    <spring-form:errors path="macFrom" cssClass="help-inline"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">Range To [Required]</label>
                                <div class="controls">
                                    <spring-form:input path="macTo" maxlength="17" cssStyle="height: 30px;"/>&nbsp;
                                    <spring-form:errors path="macTo" cssClass="help-inline"/>
                                </div>
                            </div>
                             <div class="control-group">
                                <label class="control-label">Note</label>
                                <div class="controls">
                                    <spring-form:textarea path="note" cssClass="span20"/>
                                </div>
                            </div>
                            <div class="form-actions">
                                <input type="button" value="Back" class="btn btn-success" onclick="window.location.href='${pageContext.request.contextPath}/backend/clientoverview.html?filername=${filername}&current=${current}'">
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