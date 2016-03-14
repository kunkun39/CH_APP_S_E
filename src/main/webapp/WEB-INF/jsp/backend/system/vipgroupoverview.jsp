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

</head>
<body>

<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a style="font-size: 13px" href="${pageContext.request.contextPath}/backend/dashboard.html" class="tip-bottom"><i class="icon-home"></i> Dashboard</a> <a style="font-size: 13px" href="javascript:void(0);" class="current">VIP Group Management</a> </div>
  </div>

  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">

        <div class="widget-box">
          <div class="widget-title" style="padding-top: 2px;">
            <form id="vipgroup_search_form" action="${pageContext.request.contextPath}/backend/vipgroupoverview.html" method="POST">
                <a href="${pageContext.request.contextPath}/backend/vipgroupform.html"><span class="icon"><i class="icon-plus"></i></span></a>
                <h5>Name:</h5> <input type="text" name="filterName" class="text" value="${paging.filterName}" style="height: 25px;"/>
                &nbsp;
                <i class="icon icon-search" onclick="jQuery('#vipgroup_search_form').submit();"></i>
            </form>
          </div>

          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th width="20%">Vip Group Name</th>
                  <th width="65%">Vip Group Description</th>
                  <th>Actions</th>
                </tr>
              </thead>

              <tbody>
                <c:forEach items="${groups}" var="group">
                    <tr class="gradeX">
                      <td>${group.groupName}</td>
                      <td>${group.groupDesc}</td>
                      <td class="center">
                        <a href="${pageContext.request.contextPath}/backend/vipgroupform.html?groupId=${group.id}&filterName=${filterName}&current=${current}" class="btn btn-primary btn-mini">Edit</a>

                        <a href="javascript:void(0);" onclick="return vipGroupDeleteConfirm('${group.id}', '${filterName}', '${current}');" class="btn btn-danger btn-mini">Delete</a>

                        <a href="${pageContext.request.contextPath}/backend/vipmemberoverview.html?groupId=${group.id}" class="btn btn-success btn-mini">Mac List</a>
                      </td>
                    </tr>
                </c:forEach>
              </tbody>

            </table>
          </div>

          <div class="widget-content nopadding">
            <div class="pagination alternate" style="padding-left: 10px">
                <ul>
                    <ch:paging urlMapping="${pageContext.request.contextPath}/backend/vipgroupoverview.html" paging="${paging}"/>
                </ul>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>

</div>

<div id="group-dialog-confirm" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Delete vip group will let app can be download by normal user if app only support this delete vip,
        Are you sure you want to delete this vip group from the system?
    </p>
</div>

<script type="text/javascript">
    function vipGroupDeleteConfirm(groupId, filterName, current) {
        jQuery("#group-dialog-confirm").css("visibility", "visible");
        jQuery("#group-dialog-confirm").dialog({
                resizable: false,
                height:160,
                width:300,
                modal: true,
                buttons: {
                    "Confirm": function() {
                        jQuery("#group-dialog-confirm").css("visibility", "hidden");
                        jQuery(this).dialog("close");
                        window.location.href = '${pageContext.request.contextPath}/backend/vipgroupdelete.html?groupId=' + groupId + '&filterName=' + filterName + '&current=' + current;
                    },
                    "Cancel": function() {
                        jQuery("#group-dialog-confirm").css("visibility", "hidden");
                        jQuery(this).dialog("close");
                    }
                }
            });
    }

</script>

</body>
</html>