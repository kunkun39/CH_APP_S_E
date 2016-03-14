<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="ch" uri="http://www.chanhong.com" %>
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
    <script src="${pageContext.request.contextPath}/dwr/engine.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/util.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/interface/SystemDWRHandler.js" type="text/javascript"></script>
    <script type='text/javascript' src='${pageContext.request.contextPath}/js/jquery-loadmask/jquery.loadmask.min.js'></script>
    <link rel='stylesheet' type='text/css' href='${pageContext.request.contextPath}/js/jquery-loadmask/jquery.loadmask.css'/>
    <script>
        var fileRequestHost = '${fileRequestHost}';
        var startNumber = 0;

        jQuery(document).ready(function(){
            addRankListContent();
        });

        function addRankListContent() {
            jQuery('#commit_form_mask').mask("loading................");
            var contentContainer = jQuery("#rank_list_content");
            SystemDWRHandler.obtainPageAppsByStartNumber(startNumber, function(result) {
                var statisticData = JSON.parse(result);

                if(statisticData.length > 0) {
                    contentContainer.html(contentContainer.html() + "</div><h1>Ranking " + (startNumber + 1) + " - " + (startNumber + 20) + "</h1></div>");
                } else {
                    jQuery("#add_more_info").css("display", "block");
                }

                for(var i=0; i<statisticData.length; i++) {
                    var appValues = statisticData[i];
                    var appFullName = appValues.appFullName;
                    if(appFullName.length > 20) {
                        appFullName = appFullName.substring(0, 20);
                    }
                    var newContent = "<li><div class=\"left peity_bar_good\">" +
                            "<img style=\"width:40px;height:40px\" title=\"" + appValues.appFullName + "\" src=\"" + fileRequestHost + appValues.appKey + "/" + appValues.iconActualFileName + "\"/></div>" +
                            "<div style='text-overflow:ellipsis;white-space:nowrap;' class=\"right\"><strong>" + appValues.downloadTimes + "</strong>" + appFullName + " [" + appValues.appVersion + "]</div></li>";

                    contentContainer.html(contentContainer.html() + newContent);
                }

                if(statisticData.length > 0) {
                    contentContainer.html(contentContainer.html() + "</br></br>");
                }

                startNumber = startNumber + 20;
                jQuery('#commit_form_mask').unmask();
                window.location.hash = "#add_more_button";
            });
        }

        function closeMoreInfo() {
            jQuery("#add_more_info").css("display", "none");
        }

    </script>
</head>
<body>

<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="commit_form_mask">

<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a style="font-size: 13px" href="${pageContext.request.contextPath}/backend/dashboard.html" class="tip-bottom"><i class="icon-home"></i> Dashboard</a> <a style="font-size: 13px" href="javascript:void(0);" class="current">App Download Ranking List</a> </div>
  </div>

  <%--<div class="quick-actions_homepage">--%>
    <%--<ul class="quick-actions">--%>
      <%--<li> <a href="#" onclick="openCategoryDialog('-1', 'add');"> <i class="icon-shopping-bag"></i> 添加类别 </a> </li>--%>
    <%--</ul>--%>
  <%--</div>--%>

  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">

          <div class="widget-box">
            <div class="widget-title">
                <a href="javascript:void(0);">
                <span class="icon">
                    <i class="icon-signal"></i>
                </span>
                </a>
                <h5>App Download Ranking List</h5>
            </div>

            <div class="widget-content">
                <div class="container-fluid">

                    <div class="row-fluid">
                        <div class="span12">
                            <div class="widget-box widget-plain">
                                <div class="center">
                                    <ul id="rank_list_content" class="stat-boxes stat-boxes2">
                                        <%--<c:forEach items="${apps}" var="app">--%>
                                            <%--<li>--%>
                                                <%--<div class="left peity_bar_good">--%>
                                                    <%--<img width="40" height="40" alt="" src="${fileRequestHost}${app.appKey}/${app.iconActualFileName}"/>--%>
                                                <%--</div>--%>
                                                <%--<div class="right"><strong>${app.downloadTimes}</strong> ${app.appFullName} [${app.appVersion}]</div>--%>
                                            <%--</li>--%>
                                        <%--</c:forEach>--%>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

           <div id="add_more_info" class="alert alert-error" style="display: none;">
                <button class="close" data-dismiss="alert" onclick="closeMoreInfo();">×</button>
                <strong>Notice!</strong> no more data to show
           </div>

            <div id="add_more_button" class="widget-title">
                <span onclick="addRankListContent()"><h5 style="color:green;">check more...</h5></span>
            </div>
          </div>

      </div>
    </div>
  </div>

</div>

</div>
</body>
</html>