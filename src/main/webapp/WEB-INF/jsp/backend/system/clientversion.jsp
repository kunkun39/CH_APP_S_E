<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring-form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <title>App Market Backend Management System</title><meta charset="UTF-8" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-responsive.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/uniform.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/select2.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/maruti-style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/maruti-media.css" class="skin-color" />
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.22.custom.css" type="text/css"/>
    <script type='text/javascript' src='${pageContext.request.contextPath}/js/jquery-loadmask/jquery.loadmask.min.js'></script>
    <link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/js/jquery-loadmask/jquery.loadmask.css'/>
</head>

<body>

<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
        <a style="font-size: 13px" href="${pageContext.request.contextPath}/backend/dashboard.html" class="tip-bottom"><i class="icon-home"></i> Dashboard</a>
        <a style="font-size: 13px" href="javascript:void(0);" class="current">Client APK Version Management</a>
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
                        <h5>Client APK Version Management</h5>
                    </div>
                    <div class="widget-content nopadding">
                        <form action="${pageContext.request.contextPath}/backend/clientversionshow.html" class="form-horizontal" method="post" name="basic_validate" id="basic_validate" novalidate="novalidate" enctype="multipart/form-data">
                            <input type="hidden" name="method" value="add"/>
                            <div class="control-group">
                                <label class="control-label">Current APK Version</label>
                                <div class="controls">
                                    <input type="text" name="required" id="required" style="height: 30px; width: 200px" value="${version.clientVersion}" readonly="true"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">New APK Version [Required]</label>
                                <div class="controls">
                                    <input id="clientVersion" name="clientVersion" value="" maxlength="30" style="height: 30px;"/>
                                    <span id="clientVersion_help" class="help-inline" for="required" style="display:none">The version of APK must be a number</span>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">New Version of APK File [Required]</label>
                                <div class="controls">
                                    <input type="file" id="clientApkUploadFile" name="clientApkUploadFile"/>&nbsp;
                                    <span id="clientApk_help" class="help-inline" for="required" style="display:none">The upload file is empty or the file name is not GDAppStore.apk</span>
                                    <c:if test="${apkFileExist}">
                                        <br/>
                                        <br/>
                                        GDAppStore.apk  <a href="${clintApkRequestHost}" target="_blank" class="btn btn-warning btn-mini">Download</a>
                                    </c:if>
                                </div>
                            </div>
                            <div class="form-actions">
                                <c:if test="${version.beginUpdate}">
                                    <input type="button" value="Close Update" class="btn btn-danger" onclick="changeClientUpdateStatus(false);">
                                </c:if>
                                <c:if test="${!version.beginUpdate}">
                                    <input type="button" value="Open Update" class="btn btn-danger" onclick="changeClientUpdateStatus(true);">
                                </c:if>
                                &nbsp;
                                <input type="button" value="Save" class="btn btn-success" onclick="saveClientVersion(this.form);">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="update-dialog-confirm" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Open or close client update?
    </p>
</div>

<script type="text/javascript">
    function endWith(str, endWith) {
        var reg = new RegExp(endWith + "$");
        return reg.test(str);
    }

    function saveClientVersion(form) {
        var canSubmit = true;
        var clientVersion = jQuery("#clientVersion").val();
        if(!IsNum(clientVersion)) {
            jQuery("#clientVersion_help").css("display", "block");
            canSubmit = false;
        } else {
            jQuery("#clientVersion_help").css("display", "none");
        }

        var clientApkUploadFile = jQuery("#clientApkUploadFile").val();
        if(clientApkUploadFile == null || clientApkUploadFile == "" || !endWith(clientApkUploadFile, "GDAppStore.apk")) {
            jQuery("#clientApk_help").css("display", "block");
            canSubmit = false;
        } else {
            jQuery("#clientApk_help").css("display", "none");
        }

        if(canSubmit) {
            jQuery('#content').mask("uploading...");
            form.submit();
        }
    }


    function IsNum(s) {
        if (s != null && s != "") {
            return !isNaN(s);
        }
        return false;
    }

    function changeClientUpdateStatus(status) {
        jQuery("#update-dialog-confirm").css("visibility", "visible");
        jQuery("#update-dialog-confirm").dialog({
            resizable: false,
            height:160,
            width:300,
            modal: true,
            buttons: {
                "Confirm": function() {
                    jQuery("#update-dialog-confirm").css("visibility", "hidden");
                    jQuery(this).dialog("close");
                    window.location.href = "${pageContext.request.contextPath}/backend/clientversionshow.html?method=change&beginUpdate=" + status;
                },
                "Cancel": function() {
                    jQuery("#update-dialog-confirm").css("visibility", "hidden");
                    jQuery(this).dialog("close");
                }
            }
        });
    }

</script>

</body>
</html>