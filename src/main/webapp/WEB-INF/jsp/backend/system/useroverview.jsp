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
    <script src="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.22.custom.css" type="text/css"/>
    <script type="text/javascript">

        function userDeleteConfirm(userId, filername, current) {
            jQuery("#userenable-dialog-confirm").css("visibility", "visible");
            jQuery("#userenable-dialog-confirm").dialog({
                    resizable: false,
                    height:160,
                    width:300,
                    modal: true,
                    buttons: {
                        "Confirm": function() {
                            jQuery("#userenable-dialog-confirm").css("visibility", "hidden");
                            jQuery(this).dialog("close");
                            window.location.href = '${pageContext.request.contextPath}/backend/userchangeenable.html?userId=' + userId + '&filername=' + filername + '&current=' + current;
                        },
                        "Cancel": function() {
                            jQuery("#userenable-dialog-confirm").css("visibility", "hidden");
                            jQuery(this).dialog("close");
                        }
                    }
                });
        }

        function userEnableConfirm(userId, filername, current) {
            jQuery("#userdisable-dialog-confirm").css("visibility", "visible");
            jQuery("#userdisable-dialog-confirm").dialog({
                    resizable: false,
                    height:160,
                    width:300,
                    modal: true,
                    buttons: {
                        "Confirm": function() {
                            jQuery("#userdisable-dialog-confirm").css("visibility", "hidden");
                            jQuery(this).dialog("close");
                            window.location.href = '${pageContext.request.contextPath}/backend/userchangeenable.html?userId=' + userId + '&filername=' + filername + '&current=' + current;
                        },
                        "Cancel": function() {
                            jQuery("#userdisable-dialog-confirm").css("visibility", "hidden");
                            jQuery(this).dialog("close");
                        }
                    }
                });
        }
    </script>
</head>
<body>

<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a style="font-size: 13px" href="${pageContext.request.contextPath}/backend/dashboard.html" class="tip-bottom"><i class="icon-home"></i> Dashboard</a> <a style="font-size: 13px" href="javascript:void(0);" class="current">System User Management</a> </div>
  </div>

  <%--<div  class="quick-actions_homepage">--%>
    <%--<ul class="quick-actions">--%>
      <%--<li> <a href="${pageContext.request.contextPath}/backend/userform.html"> <i class="icon-people"></i> 添加用户 </a> </li>--%>
    <%--</ul>--%>
  <%--</div>--%>

  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">

        <div class="widget-box">
          <div class="widget-title" style="padding-top: 2px;">
            <form id="user_search_form" action="${pageContext.request.contextPath}/backend/useroverview.html" method="POST">
                <a href="${pageContext.request.contextPath}/backend/userform.html"><span class="icon"><i class="icon-plus"></i></span></a>
                <h5>Name:</h5> <input type="text" name="filername" class="text" value="${paging.name}" style="height: 25px;"/>
                &nbsp;
                <i class="icon icon-search" onclick="jQuery('#user_search_form').submit();"></i>
            </form>
          </div>

          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th width="15%">Name</th>
                  <th width="20%">Worker Code(username)</th>
                  <th width="15%">Password</th>
                  <th width="20%">ContactWay</th>
                  <th width="15%">Status</th>
                  <th>Actions</th>
                </tr>
              </thead>

              <tbody>
                <c:forEach items="${users}" var="user">
                    <tr class="gradeX">
                      <td>${user.name}</td>
                      <td>${user.username}</td>
                      <td>${user.password}</td>
                      <td>${user.contactWay}</td>
                      <td>
                        <c:if test="${user.enabled}">
                            Enabled
                        </c:if>
                        <c:if test="${!user.enabled}">
                            Disabled
                        </c:if>
                      </td>
                      <td class="center">
                        <a href="${pageContext.request.contextPath}/backend/userform.html?userId=${user.id}&filername=${filername}&current=${current}" class="btn btn-primary btn-mini">Edit</a>

                        <c:if test="${user.username != 'chappadmin'}">
                            <c:if test="${user.enabled}">
                                <a href="javascript:void(0);" onclick="return userDeleteConfirm('${user.id}', '${filername}', '${current}');" class="btn btn-danger btn-mini">Disable User</a>
                            </c:if>
                            <c:if test="${!user.enabled}">
                                <a href="javascript:void(0);" onclick="return userEnableConfirm('${user.id}', '${filername}', '${current}');" class="btn btn-danger btn-mini">Enable User</a>
                            </c:if>
                        </c:if>
                      </td>
                    </tr>
                </c:forEach>
              </tbody>

            </table>
          </div>

          <div class="widget-content nopadding">
            <div class="pagination alternate" style="padding-left: 10px">
                <ul>
                    <ch:paging urlMapping="${pageContext.request.contextPath}/backend/useroverview.html" paging="${paging}"/>
                </ul>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>

</div>

<div id="userenable-dialog-confirm" title="ystem Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Are you sure you want to disable this system user from the system?
    </p>
</div>

<div id="userdisable-dialog-confirm" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Are you sure you want to enable this system user from the system?
    </p>
</div>

</body>
</html>