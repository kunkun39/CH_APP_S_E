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
    <script src="${pageContext.request.contextPath}/js/popup/modal.popup.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.22.custom.css" type="text/css"/>

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
        function openVipMemeberModel(groupId) {
            settings.source = '${pageContext.request.contextPath}/backend/vipmemberform.html?groupId=' + groupId;
            openModalPopup(settings);
        }

        function openModalPopup(obj) {
            modalPopup(obj.align, obj.top, obj.width, obj.padding, obj.disableColor, obj.disableOpacity, obj.backgroundColor, obj.borderColor, obj.borderWeight, obj.borderRadius, obj.fadeOutTime, obj.source, obj.loadingImage);
        }
    </script>

</head>
<body>

<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="content">
  <div id="content-header">
    <div id="breadcrumb">
        <a style="font-size: 13px" href="${pageContext.request.contextPath}/backend/dashboard.html" class="tip-bottom"><i class="icon-home"></i> Dashboard</a>
        <a style="font-size: 13px" href="${pageContext.request.contextPath}/backend/vipgroupoverview.html" class="tip-bottom">VIP Group Management</a>
        <a style="font-size: 13px" href="javascript:void(0);" class="current">Mac List for VIP Group '${group.groupName}'</a>
    </div>
  </div>

  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">

        <div class="widget-box">
          <div class="widget-title" style="padding-top: 2px;">
            <form id="vipmember_search_form" action="${pageContext.request.contextPath}/backend/vipmemberoverview.html" method="POST">
                <input type="hidden" name="groupId" value="${group.id}"/>
                <a href="javascript:void(0);" onclick="openVipMemeberModel('${group.id}')"><span class="icon"><i class="icon-plus"></i></span></a>
                <h5>Mac:</h5> <input type="text" name="filterMac" class="text" value="${paging.filterMac}" style="height: 25px;"/>
                &nbsp;
                <i class="icon icon-search" onclick="jQuery('#vipmember_search_form').submit();"></i>
            </form>
          </div>

          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th width="10%">#</th>
                  <th width="75%">Box Mac</th>
                  <th>Actions</th>
                </tr>
              </thead>

              <tbody>
                <c:forEach items="${members}" var="member" varStatus="counter">
                    <tr class="gradeX">
                      <td>${counter.count}</td>
                      <td>${member.boxMac}</td>
                      <td class="center">
                        <a href="javascript:void(0);" onclick="return vipMemeberDeleteConfirm('${member.id}', '${group.id}', '${filterMac}', '${current}');" class="btn btn-danger btn-mini">Delete</a>
                      </td>
                    </tr>
                </c:forEach>
              </tbody>

            </table>
          </div>

          <div class="widget-content nopadding">
            <div class="pagination alternate" style="padding-left: 10px">
                <ul>
                    <ch:paging urlMapping="${pageContext.request.contextPath}/backend/vipmemberoverview.html" paging="${paging}"/>
                </ul>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>

</div>

<div id="member-dialog-confirm" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Are you sure you want to delete this vip member from vip group ${group.groupName}?
    </p>
</div>

<script type="text/javascript">

    function saveVipMember(form) {
        var groupId = jQuery("#groupId").val();
        var boxMac = jQuery("#boxMac").val();
        if(boxMac == null || boxMac == '') {
            jQuery("#boxMac_help").html("The box mac field not allowed to be empty");
            jQuery("#boxMac_help").css("display", "block");
            return;
        } else {
            var length = boxMac.length;
            var tokens = boxMac.split(":");
            if(length != 17 || tokens.length != 6) {
                jQuery("#boxMac_help").html("The box mac format is not right");
                jQuery("#boxMac_help").css("display", "block");
                return;
            } else {
                SystemDWRHandler.isBoxMacAlreadyAddForVipGroup(groupId, boxMac, function(result) {
                    if(result) {
                        jQuery("#boxMac_help").html("The box mac already exist in this vip group");
                        jQuery("#boxMac_help").css("display", "block");
                        return;
                    } else {
                        jQuery("#boxMac_help").css("display", "none");
                        form.submit();
                    }
                });
            }
        }
    }

    function vipMemeberDeleteConfirm(memberId, groupId, filterMac, current) {
        jQuery("#member-dialog-confirm").css("visibility", "visible");
        jQuery("#member-dialog-confirm").dialog({
            resizable: false,
            height:160,
            width:300,
            modal: true,
            buttons: {
                "Confirm": function() {
                    jQuery("#member-dialog-confirm").css("visibility", "hidden");
                    jQuery(this).dialog("close");
                    window.location.href = '${pageContext.request.contextPath}/backend/vipmemberdelete.html?memberId=' + memberId + '&groupId=' + groupId + '&filterMac=' + filterMac + '&current=' + current;
                },
                "Cancel": function() {
                    jQuery("#member-dialog-confirm").css("visibility", "hidden");
                    jQuery(this).dialog("close");
                }
            }
        });
    }

</script>

</body>
</html>