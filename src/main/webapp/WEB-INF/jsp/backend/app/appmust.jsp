<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring-form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
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
    <script src="${pageContext.request.contextPath}/dwr/engine.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/util.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/interface/SystemDWRHandler.js" type="text/javascript"></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/js/jquery-loadmask/jquery.loadmask.min.js'></script>
    <link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/js/jquery-loadmask/jquery.loadmask.css'/>
    <script src="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.22.custom.css" type="text/css"/>
</head>

<body>

<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="content">
    <div id="content-header">
        <div id="breadcrumb"> <a style="font-size:13px" href="${pageContext.request.contextPath}/backend/dashboard.html" class="tip-bottom"><i class="icon-home"></i> Dashboard</a> <a style="font-size:13px" href="javascript:void(0);" class="current">App ${pageName} Management</a> </div>
    </div>

    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">

                <%--效果部分--%>
                <div class="widget-box">
                    <div class="widget-title">
                        <span class="icon">
                            <i class="icon-play-circle"></i>
                        </span>
                        <h5>App ${pageName} Management</h5>
                    </div>

                    <div class="widget-content">
                        <%--推荐部分--%>
                        <div id="recommend_content" class="thumbnails">
                            <c:forEach items="${appMusts}" var="child" varStatus="counter">
                                <li class="span2">
                                    <h5 align="center">${child.appName}  ${child.appVersion}</h5>
                                    <a class="thumbnail lightbox_trigger" href="javascript:void(0);">
                                        <img style="width: 80px; height: 80px;" src="${fileRequestHost}${child.appKey}/${child.iconActualFileName}" alt="" >
                                    </a>
                                    <div class="actions">
                                        <a title="" href="javascript:void(0);" onclick="appMustDeleteConfirm('${child.id}');"><i class="icon-remove icon-white"></i></a>
                                    </div>
                                </li>
                            </c:forEach>
                        </div>

                        <%--推荐操作部分--%>
                        <br/>
                        <br/>

                        <table class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th style="font-size:13px" >Filters</th>
                            </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                    App Category:<select id="categoryId" name="categoryId" style="height: 30px;">
                                        <option value="-1">All
                                        </option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.id}" >${category.categoryName}</option>
                                            <c:forEach items="${category.children}" var="child" varStatus="counter">
                                                <option value="${child.id}">[${counter.count}] ${category.categoryName} -> ${child.categoryName}</option>
                                            </c:forEach>
                                        </c:forEach>
                                    </select>
                                     &nbsp;
                                     App Name:<input type="text" id="appName" name="appName" class="text" style="height: 25px;"/>
                                        &nbsp;
                                        <i id="app_search_button" class="icon icon-search" style="cursor: pointer" onclick="searhRecommendApps();"></i>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <%--！搜索结果部分--%>
                        <div class="widget-content nopadding">
                        <ul id="search_list_content" class="recent-posts">

                        </ul>
                    </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<div id="recommend-dialog-confirm" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Are you sure you want to set this app to ${pageName} on the box?
    </p>
</div>

<div id="recommenddelete-dialog-confirm" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Are you sure you want to delete this app from ${pageName} list?
    </p>
</div>

<div id="recommendduplicate-dialog-confirm" title="System Information Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        This app already exist in the list of force install or update apps.
    </p>
</div>

<script type="text/javascript">
    var fileRequestHost = '${fileRequestHost}';

    document.onkeydown = function(e){
        if(!e) e = window.event;//火狐中是 window.event
        if((e.keyCode || e.which) == 13){
            jQuery("#app_search_button").click();
        }
    }

    function searhRecommendApps() {
        var contentContainer = jQuery("#search_list_content");
        contentContainer.html("");

        var categoryId = jQuery("#categoryId").val();
        var appName = jQuery("#appName").val();

        SystemDWRHandler.obtainRecommendApps(-1, categoryId, appName, function(result) {
            var statisticData = JSON.parse(result);
            var newContent = "<li><div class=\"article-post\" style=\"text-align: center;\"><span class=\"user-info\"> Just show no more than 20 search records</span></div></li>";
            for(var i=0; i<statisticData.length; i++) {
                var appValues = statisticData[i];
                newContent = newContent + "<li><div class=\"fr\"><a class=\"btn btn-primary btn-mini\" onclick=\"recommendAppTo('" + appValues.appId + "')\">Recommend</a></div>" +
                        "<div class=\"user-thumb\"><img width=\"50\" height=\"50\" src=\"" + fileRequestHost + appValues.appKey + "/" + appValues.iconActualFileName + "\"></div>" +
                        "<div class=\"article-post\"><span class=\"user-info\"> Name:</span>" + appValues.appFullName + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"user-info\"> Version:</span>" + appValues.appVersion + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"user-info\"> Category:</span>" + appValues.appCategory +
                        "</span><p><span class=\"user-info\"> Description:</span>" + appValues.appDescription + "<br/><br/></p></div></li>";
                }
            contentContainer.html(newContent);
        });
    }

    function recommendAppTo(appId) {
        jQuery("#recommend-dialog-confirm").css("visibility", "visible");
        jQuery("#recommend-dialog-confirm").dialog({
            resizable: false,
            height:160,
            width:300,
            modal: true,
            buttons: {
                "Confirm": function() {
                    var appMustId = -1;
                    jQuery("#recommend-dialog-confirm").css("visibility", "hidden");
                    jQuery(this).dialog("close");

                    SystemDWRHandler.updateAppMust(appId, '${appMustType}', function(result) {
                        if(result == null) {
                            return;
                        } else {
                            var appNustJSON = JSON.parse(result);
                            appMustId = appNustJSON.appMustId;

                            if(appMustId > 0)  {
                                SystemDWRHandler.obtainRecommendApps(appId, -1, "", function(result) {
                                    var appValues = JSON.parse(result)[0];
                                    var content = jQuery("#recommend_content").html();
                                    var newContent = "<li class=\"span2\"><h5 align=\"center\">" + appValues.appFullName + "  " + appValues.appVersion +  "</h5>" +
                                        "<a class=\"thumbnail lightbox_trigger\" href=\"#\">" +
                                            "<img style=\"width: 80px; height: 80px;\" src=\"" + fileRequestHost + appValues.appKey + "/" + appValues.iconActualFileName + "\">" +
                                        "</a>" +
                                        "<div class=\"actions\"><a href=\"#\" onclick=\"appMustDeleteConfirm('" + appMustId + "');\"><i class=\"icon-remove icon-white\"></i></a>" +
                                        "</div></li>";

                                    jQuery("#recommend_content").html(content + newContent);
                                });
                            } else {
                                jQuery("#recommendduplicate-dialog-confirm").css("visibility", "visible");
                                jQuery("#recommendduplicate-dialog-confirm").dialog({
                                    resizable: false,
                                    height:160,
                                    width:300,
                                    modal: true,
                                    buttons: {
                                        "Cancel": function() {
                                            jQuery("#recommendduplicate-dialog-confirm").css("visibility", "hidden");
                                            jQuery(this).dialog("close");
                                        }
                                    }
                                });
                            }
                        }
                    });
                },
                "Cancel": function() {
                    jQuery("#recommend-dialog-confirm").css("visibility", "hidden");
                    jQuery(this).dialog("close");
                }
            }
        });
    }

    function appMustDeleteConfirm(appMustId) {
        jQuery("#recommenddelete-dialog-confirm").css("visibility", "visible");
        jQuery("#recommenddelete-dialog-confirm").dialog({
            resizable: false,
            height:160,
            width:300,
            modal: true,
            buttons: {
                "Confirm": function() {
                    jQuery("#recommenddelete-dialog-confirm").css("visibility", "hidden");
                    jQuery(this).dialog("close");

                    SystemDWRHandler.deleteAppMust(appMustId, function(result) {
                        window.location.href = "${pageContext.request.contextPath}/backend/appmust.html?appMustType=${appMustType}";
                    });
                },
                "Cancel": function() {
                    jQuery("#recommenddelete-dialog-confirm").css("visibility", "hidden");
                    jQuery(this).dialog("close");
                }
            }
        });
    }

</script>
</body>
</html>