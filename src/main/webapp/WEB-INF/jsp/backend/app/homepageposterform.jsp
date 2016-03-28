<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="spring-form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>App Market Backend Management System</title><meta charset="UTF-8" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/uniform.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/select2.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/maruti-style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/maruti-media.css" class="skin-color" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/module.css" />

    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/engine.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/util.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/interface/SystemDWRHandler.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/popup/modal.popup.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.22.custom.css" type="text/css"/>
</head>
<body>
<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
            <a href="${pageContext.request.contextPath}/backend/dashboard.html" class="tip-bottom"><i class="icon-home"></i> Dashboard</a>
            <a href="javascript:void(0);" class="current">New/Edit Homepage Poster</a>
        </div>
    </div>

    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <div class="widget-box">

                    <div class="widget-title">
                        <span class="icon">
                            <i class="icon-align-justify"></i>
                        </span>
                        <h5>HomePage Poster Edit</h5>
                    </div>

                    <div class="widget-content nopadding">
                        <spring-form:form commandName="poster" class="form-horizontal" method="post" enctype="multipart/form-data">
                        <%--<form action="${pageContext.request.contextPath}/backend/homepageposterform.html" method="post" class="form-horizontal" enctype="multipart/form-data">--%>
                            <input type="hidden" name="id" value="${poster.id}"/>
                            <%--<input type="hidden" name="method" value="save"/>--%>
                            <div id="icon_place" class="control-group">
                                <label class="control-label" style="width: 200px;">HomePage Poster [Required]</label>
                                <div class="controls" style="margin-left: 220px;">
                                    <input type="file" id="posterFile" name="posterFile"/>
                                    <spring-form:errors path="posterActualFileName" class="help-block"/>
                                </div>
                            </div>
                            <c:if test="${poster.posterActualFileName != ''}">
                                <div>
                                    <div class="controls">
                                        <img style="width: 200px; height: 80px;" src="${fileRequestHost}homepageposter/${poster.posterActualFileName}" alt="" >
                                    </div>
                                </div>
                            </c:if>
                            <div class="form-actions">
                                <button type="button" class="btn btn-success" onclick="closePopup(settings.fadeOutTime);">Cancel</button>
                                <button type="button" class="btn btn-success" onclick="saveHomePagePoster(this.form);">Save</button>
                            </div>
                            <img id="view_image" src="" style="display: none;"/>
                        </spring-form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function saveHomePagePoster(form) {
        form.submit();
    }
</script>

</body>
</html>