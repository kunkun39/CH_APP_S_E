<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="spring-form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
    <title>App Market Backend Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-responsive.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/uniform.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/select2.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/maruti-style.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/maruti-media.css" class="skin-color"/>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/maruti.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/popup/modal.popup.js" type="text/javascript"></script>
    <script type='text/javascript'
            src='${pageContext.request.contextPath}/js/jquery-loadmask/jquery.loadmask.min.js'></script>
    <link rel='stylesheet' type='text/css'
          href='${pageContext.request.contextPath}/js/jquery-loadmask/jquery.loadmask.css'/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-raty/jquery.raty.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.16.custom.min.js"
            type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.22.custom.css"
          type="text/css"/>
    <style type="text/css">
        .grey {
            color : #999999;
        }
    </style>

    <script type="text/javascript">
        jQuery(function() {
            settings = {
                align : 'center',                                    //Valid values, left, right, center
                top : 50,                                             //Use an integer (in pixels)
                width : 600,                                         //Use an integer (in pixels)
                height : 500,                                         //Use an integer (in pixels)
                padding : 10,                                        //Use an integer (in pixels)
                backgroundColor : 'white',                             //Use any hex code
                source : '',                                         //Refer to any page on your server, external pages are not valid e.g. http://www.google.co.uk
                borderColor : '#333333',                             //Use any hex code
                borderWeight : 4,                                    //Use an integer (in pixels)
                borderRadius : 5,                                     //Use an integer (in pixels)
                fadeOutTime : 300,                                     //Use any integer, 0 : no fade
                disableColor : '#666666',                             //Use any hex code
                disableOpacity : 40,                                 //Valid range 0-100
                loadingImage : '${pageContext.request.contextPath}/js/popup/loading.gif'
            };
            jQuery(document).keyup(function(event) {
                if (event.keyCode == 27) {
                    closePopup(settings.fadeOutTime);
                }
            });

        });
        function openHistoryModel(id) {
            settings.source = '${pageContext.request.contextPath}/backend/apphistory.html?appId=' + id + '&time=' + new Date().valueOf();
            openModalPopup(settings);
        }

        function openModalPopup(obj) {
            modalPopup(obj.align, obj.top, obj.width, obj.padding, obj.disableColor, obj.disableOpacity, obj.backgroundColor, obj.borderColor, obj.borderWeight, obj.borderRadius, obj.fadeOutTime, obj.source, obj.loadingImage);
        }

        $(function() {
            jQuery.fn.raty.defaults.path = '${pageContext.request.contextPath}/js/jquery-raty/img';
            jQuery('#function-score').raty({
                number: 10,//多少个星星设置
                score: ${app.appScores},//初始值是设置
                targetType: 'number',//类型选择，number是数字值，hint，是设置的数组值
                path      : '${pageContext.request.contextPath}/js/jquery-raty/img',
                cancelOff : 'cancel-off-big.png',
                cancelOn  : 'cancel-on-big.png',
                size      : 30,
                starHalf  : 'star-half-big.png',
                starOff   : 'star-off-big.png',
                starOn    : 'star-on-big.png',
                target    : '#function-hint',
                cancel    : false,
                targetKeep: true,
                precision : false,//是否包含小数
                click: function(score, evt) {
                    jQuery("#appScore").val(score);
                }
            });
        });
    </script>
</head>
<body>

<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="content">
<div id="content-header">
    <div id="breadcrumb">
        <a href="${pageContext.request.contextPath}/backend/dashboard.html" class="tip-bottom"><i class="icon-home"></i> Dashboard</a>
        <a href="javascript:void(0);" class="current">New/Edit App Information</a>
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
            <h5>New/Edit App Information</h5>
        </div>

        <div class="widget-content nopadding">
            <spring-form:form commandName="app" class="form-horizontal" method="post" enctype="multipart/form-data">
                <input type="hidden" name="current" value="${current}"/>
                <input type="hidden" name="categoryId" value="${categoryId}"/>
                <input type="hidden" name="topicId" value="${topicId}"/>
                <input type="hidden" name="marketAppId" value="${app.id}"/>
                <input type="hidden" name="appVersionOldInt" value="${appVersionOldInt}"/>
                <input type="hidden" id="appScore" name="appScores" value="${app.appScores}"/>

                <c:if test="${alertInfoShow}">
                    <div class="alert alert-success alert-block">
                        <a class="close" data-dismiss="alert" href="javascript:void(0);">×</a>
                        <h4 class="alert-heading">Notice</h4>
                        Already save change for this app!
                    </div>
                </c:if>
                <c:if test="${errorInfoShow}">
                    <div class="alert alert-danger alert-block">
                        <a class="close" data-dismiss="alert" href="javascript:void(0);">×</a>
                        <h4 class="alert-heading">Notice</h4>
                        App package already exist in the system, please have a check.
                    </div>
                </c:if>

                <div id="app_error_information" class="alert alert-success alert-block" style="display: none;">
                    <a class="close" data-dismiss="alert" href="javascript:void(0);">×</a>
                    <h4 class="alert-heading">Notice</h4>
                </div>

                <div class="control-group">
                    <label class="control-label">Name [Required]</label>

                    <div class="controls">
                        <spring-form:input path="appFullName" maxlength="40" cssStyle="height: 30px;"/>&nbsp;
                        <spring-form:errors path="appFullName" cssClass="help-inline"/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">SubTitle [Required]</label>

                    <div class="controls">
                        <spring-form:input path="appSubTitle" maxlength="40" cssStyle="height: 30px;"/>&nbsp;
                        <spring-form:errors path="appSubTitle" cssClass="help-inline"/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">Scores [Required]</label>

                    <div class="controls">
                        <div id="function-score" style="float: left"></div>
                        <div id="function-hint" style="float: left"></div>
                    </div>
                </div>
                <%--<div class="control-group">--%>
                    <%--<label class="control-label">应用版本(数字) [必填]</label>--%>

                    <%--<div class="controls">--%>
                        <%--<spring-form:input path="appVersionInt" maxlength="30" cssStyle="height:30px;"/>&nbsp;--%>
                        <%--<spring-form:errors path="appVersionInt" cssClass="help-inline"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="control-group">--%>
                    <%--<label class="control-label">应用版本（字符） [必填]</label>--%>

                    <%--<div class="controls">--%>
                        <%--<spring-form:input path="appVersion" maxlength="30" cssStyle="height:30px;"/>&nbsp;--%>
                        <%--<spring-form:errors path="appVersion" cssClass="help-inline"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <%--<div class="control-group">--%>
                    <%--<label class="control-label">应用包名 [必填]</label>--%>

                    <%--<div class="controls">--%>
                        <%--<c:set var="packageChange" value="${app.id > 0 && app.status == 'PASSED'}"/>--%>
                        <%--<spring-form:input path="appPackage" maxlength="80" cssStyle="height:30px;"--%>
                                           <%--readonly="${packageChange}"/>&nbsp;--%>
                        <%--<spring-form:errors path="appPackage" cssClass="help-inline"/>--%>
                    <%--</div>--%>
                <%--</div>--%>
                <div class="control-group">
                    <label class="control-label">Category [Required]</label>

                    <div class="controls">
                        <select id="selectCategoryId" name="selectCategoryId" style="height: 30px;">
                            <c:forEach items="${categories}" var="category">
                                <option value="${category.id}" <c:if test="${category.id==app.categoryId}">selected="true"</c:if>>${category.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">ICON(1:1) [Required]</label>

                    <div class="controls">
                        <input type="file" id="appIconUploadFile" name="appIconUploadFile"/>&nbsp;
                        <spring-form:errors path="appIconId" cssClass="help-inline"/>
                        <c:if test="${app.appIconId > 0}">
                            <br/>
                            <br/>
                            <img width="50" height="50" alt=""
                                 src="${fileRequestHost}${app.appKey}/${app.iconActualFileName}"/>
                        </c:if>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">Post(16:9) [Required]</label>

                    <div class="controls">
                        <input type="file" id="appPosterUploadFile" name="appPosterUploadFile"/>&nbsp;
                        <spring-form:errors path="appPosterId" cssClass="help-inline"/>
                        <c:if test="${app.appPosterId > 0}">
                            <br/>
                            <br/>
                            <ul class="thumbnails">
                                <li class="span3">
                                    <a class="thumbnail lightbox_trigger"
                                       href="${fileRequestHost}${app.appKey}/${app.posterActualFileName}">
                                        <img width="400" height="200" alt=""
                                             src="${fileRequestHost}${app.appKey}/${app.posterActualFileName}"/>
                                    </a>
                                </li>
                            </ul>
                        </c:if>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">APK File [Required]</label>

                    <div class="controls">
                        <input type="file" id="appApkUploadFile" name="appApkUploadFile"/>&nbsp;
                        <spring-form:errors path="appFileId" cssClass="help-inline"/>
                        <c:if test="${app.appFileId > 0}">
                            <br/>
                            <br/>
                            ${app.apkFakeFileName}  <a href="${fileRequestHost}${app.appKey}/${app.apkActualFileName}"
                                                       target="_blank" class="btn btn-warning btn-mini">Download this file</a>
                        </c:if>
                    </div>
                    <label id = "processBarTextControl" class="control-label" style="display: none">uploading process</label>

                    <div id = "processBarValControl" class="controls" style="display: none">
                         <div class="progress progress-success progress-striped" style="width:30%">
                             <div id='proBar' class="bar" style="width: 0%"><span id="proVal"></span></div>
                         </div>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">Description [Required]</label>

                    <div class="controls">
                        <spring-form:textarea path="appDescription" cssClass="span20" rows="4"/>
                        <spring-form:errors path="appDescription" cssClass="help-inline"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">Note</label>

                    <div class="controls">
                        <spring-form:textarea path="appNote" cssClass="span20" rows="4"/>
                    </div>
                </div>
                <c:if test="${app.id > 0}">
                    <div class="control-group">
                        <label class="control-label">Other Info</label>

                        <div class="controls">
                            <input class="span3 grey" value="Package: ${app.appPackage}" readonly="true"/>&nbsp;
                            <input class="span3 grey" value="Version Name: ${app.appVersionInt}" readonly="true"/>&nbsp;
                            <input class="span3 grey" value="Version Code: ${app.appVersion}" readonly="true"/>&nbsp;
                            <input class="span3 grey" value="Size: ${app.appSize}M" readonly="true"/>&nbsp;
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">&nbsp;</label>

                        <div class="controls">
                            <input class="span3 grey" value="Download Times: ${app.downloadTimes}" readonly="true"/>&nbsp;
                            <input class="span3 grey" value="Status: ${app.statusName}" readonly="true"/>&nbsp;
                            <input class="span3 grey" value="Update Time:${app.updateDate}" readonly="true"/>&nbsp;
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">&nbsp;</label>

                        <div class="controls">
                            <input class="span6 grey" value="Box search keywords[case-insensitive]: '${app.pinYingShort}' or '${app.pinYingFull}'"
                                   readonly="true"/>&nbsp;
                        </div>
                    </div>
                </c:if>
                <div class="form-actions">
                    <input type="button" value="Change History" class="btn btn-success" onclick="openHistoryModel('${app.id}')">
                    &nbsp;
                    <input type="button" value="Back" class="btn btn-success"
                           onclick="window.location.href='${pageContext.request.contextPath}/backend/marketappoverview.html?appName=${appName}&current=${current}&appStatus=${appStatus}&categoryId=${categoryId}&topicId=${topicId}'">
                    &nbsp;
                    <input type="button" value="Save" class="btn btn-success" onclick="saveMarketApp(this.form);">
                </div>
            </spring-form:form>
        </div>
    </div>
</div>
</div>
</div>
</div>

<div id="marketapp-dialog-confirm" title="System Information Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        This app already exit in this topci.
    </p>
</div>

<div id="vipgroup-dialog-confirm" title="System Information Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        This vip group add set to this app.
    </p>
</div>

<script type="text/javascript">

    jQuery(document).ready(function(){
        checkVipShow();
    });

    function appendAppTopic() {
        var topicId = jQuery("#selectTopicId").val();
        var topicLable = jQuery("#selectTopicId").find("option:selected").text();
        var alreadyAdd = jQuery("#add_topics").val();

        if (alreadyAdd.indexOf(topicId + ",") >= 0) {
            jQuery("#marketapp-dialog-confirm").css("visibility", "visible");
            jQuery("#marketapp-dialog-confirm").dialog({
                        resizable: false,
                        height:160,
                        width:300,
                        modal: true,
                        buttons: {
                            "Confirm": function() {
                                jQuery("#marketapp-dialog-confirm").css("visibility", "hidden");
                                jQuery(this).dialog("close");
                            }
                        }
                    });

        } else {
            jQuery("#add_topics").val(alreadyAdd + topicId + ",");

            var newHtml = "<div id=\"topic_exist_" + topicId + "\">" + topicLable + " <a href=\"javascript:void(0);\" onclick=\"deleteAppTopic('" + topicId + "')\" class=\"btn btn-danger btn-mini\">Delete from topic</a><br/><div>";
            var oldHtml = jQuery("#exist_topics").html();
            jQuery("#exist_topics").html(oldHtml + newHtml);
        }
    }

    function deleteAppTopic(topicId) {
        var alreadyAdd = jQuery("#add_topics").val();
        var alreadyDelete = jQuery("#delete_topics").val();

        if (alreadyAdd.indexOf(topicId + ",") >= 0) {
            jQuery("#add_topics").val(alreadyAdd.replace(topicId + ",", ""))
        } else {
            jQuery("#delete_topics").val(alreadyDelete + topicId + ",");
        }

        jQuery("#topic_exist_" + topicId).remove();
    }

    function checkVipShow() {
        var vipChecked = jQuery("#vip").attr("checked");
        if(vipChecked) {
            jQuery("#div_vip_group").css("display", "block");
        } else {
            jQuery("#div_vip_group").css("display", "none");
        }
    }

    function appendGroup() {
        var groupId = jQuery("#selectGroupId").val();
        var groupLable = jQuery("#selectGroupId").find("option:selected").text();
        var alreadyAdd = jQuery("#add_groups").val();

        if (alreadyAdd.indexOf(groupId + ",") >= 0) {
            jQuery("#vipgroup-dialog-confirm").css("visibility", "visible");
            jQuery("#vipgroup-dialog-confirm").dialog({
                        resizable: false,
                        height:160,
                        width:300,
                        modal: true,
                        buttons: {
                            "Confirm": function() {
                                jQuery("#vipgroup-dialog-confirm").css("visibility", "hidden");
                                jQuery(this).dialog("close");
                            }
                        }
                    });

        } else {
            jQuery("#add_groups").val(alreadyAdd + groupId + ",");

            var newHtml = "<div id=\"group_exist_" + groupId + "\">" + groupLable + " <a href=\"javascript:void(0);\" onclick=\"deleteGroup('" + groupId + "')\" class=\"btn btn-danger btn-mini\">Delete Vip Group</a><br/><div>";
            var oldHtml = jQuery("#exist_groups").html();
            jQuery("#exist_groups").html(oldHtml + newHtml);
        }
    }

    function deleteGroup(groupId) {
        var alreadyAdd = jQuery("#add_groups").val();
        var alreadyDelete = jQuery("#delete_groups").val();

        if (alreadyAdd.indexOf(groupId + ",") >= 0) {
            jQuery("#add_groups").val(alreadyAdd.replace(groupId + ",", ""))
        } else {
            jQuery("#delete_groups").val(alreadyDelete + groupId + ",");
        }

        jQuery("#group_exist_" + groupId).remove();
    }

    function saveMarketApp(form) {
        form.submit();
        beginUploadProcess();
    }

    function beginUploadProcess() {
        jQuery("#processBarTextControl").css("display", "block");
        jQuery("#processBarValControl").css("display", "block");
        var intId = setInterval(getUploadMeter, 1000);

        function getUploadMeter() {
            jQuery.getJSON("${pageContext.request.contextPath}/backend/apkuploadprocess.html", function(data) {
                jQuery("#proBar").css("width", data.percentage + '%');
                jQuery("#proVal").html(data.percentage + '%');

                if (data.percentage == 100) {
                    //stop requirement
                    window.clearInterval(intId);
                }
            });
        }
    }


</script>

</body>
</html>