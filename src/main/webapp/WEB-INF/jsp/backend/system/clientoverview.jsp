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
    <script src="${pageContext.request.contextPath}/js/popup/modal.popup.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.22.custom.css" type="text/css"/>

    <%--<script>--%>
    <%--jQuery(function() {--%>
		<%--settings = {--%>
			<%--align : 'center',									//Valid values, left, right, center--%>
			<%--top : 50, 											//Use an integer (in pixels)--%>
			<%--width : 600, 										//Use an integer (in pixels)--%>
            <%--height : 400,--%>
			<%--padding : 10,										//Use an integer (in pixels)--%>
	        <%--backgroundColor : 'white', 						    //Use any hex code--%>
	        <%--source : '', 				    					//Refer to any page on your server, external pages are not valid e.g. http://www.google.co.uk--%>
	        <%--borderColor : '#333333', 							//Use any hex code--%>
	        <%--borderWeight : 4,									//Use an integer (in pixels)--%>
	        <%--borderRadius : 5, 									//Use an integer (in pixels)--%>
	        <%--fadeOutTime : 300, 									//Use any integer, 0 : no fade--%>
	        <%--disableColor : '#666666', 							//Use any hex code--%>
	        <%--disableOpacity : 40, 								//Valid range 0-100--%>
	        <%--loadingImage : '${pageContext.request.contextPath}/js/popup/loading.gif'--%>
		<%--};--%>
		<%--jQuery(document).keyup(function(event) {--%>
			<%--if (event.keyCode == 27) {--%>
				<%--closePopup(settings.fadeOutTime);--%>
			<%--}--%>
		<%--});--%>

	<%--});--%>
	<%--function openClientImportDialog(id, method) {--%>
		<%--settings.source = '${pageContext.request.contextPath}/backend/clientimport.html?method=init';--%>
		<%--openModalPopup(settings);--%>
	<%--}--%>

	<%--function openModalPopup(obj) {--%>
		<%--modalPopup(obj.align, obj.top, obj.width, obj.padding, obj.disableColor, obj.disableOpacity, obj.backgroundColor, obj.borderColor, obj.borderWeight, obj.borderRadius, obj.fadeOutTime, obj.source, obj.loadingImage);--%>
	<%--}--%>

    <%--function saveClients(form) {--%>
        <%--var clientFrom = jQuery("#clientFrom").val();--%>
        <%--var clientTo = jQuery("#clientTo").val();--%>
        <%--if(clientFrom == null || clientFrom == '' || clientTo == null || clientTo == '') {--%>
            <%--jQuery("#client_help").css("visibility", "visible");--%>
            <%--return;--%>
        <%--}--%>

        <%--jQuery("#client_import_dialog").css("visibility", "visible");--%>
        <%--jQuery("#client_import_dialog").dialog({--%>
            <%--resizable: false,--%>
            <%--height:160,--%>
            <%--width:300,--%>
            <%--modal: true,--%>
            <%--buttons: {--%>
                <%--"Confirm": function() {--%>
                    <%--jQuery("#client_import_dialog").css("visibility", "hidden");--%>
                    <%--jQuery(this).dialog("close");--%>
                    <%--form.submit();--%>
                <%--},--%>
                <%--"Cancel": function() {--%>
                    <%--jQuery("#category_delete_dialog").css("visibility", "hidden");--%>
                    <%--jQuery(this).dialog("close");--%>
                <%--}--%>
            <%--}--%>
        <%--});--%>

    <%--}--%>

    <%--function caculateClientNumber() {--%>
        <%--var clientFrom = jQuery("#clientFrom").val();--%>
        <%--var clientTo = jQuery("#clientTo").val();--%>
        <%--if(clientFrom == null || clientFrom == '' || clientTo == null || clientTo == '') {--%>
            <%--return;--%>
        <%--}--%>

        <%--SystemDWRHandler.caculateClientNumber(clientFrom, clientTo, function(result) {--%>
            <%--if(result < 0) {--%>
                <%--jQuery("#client_help").css("visibility", "visible");--%>
                <%--return;--%>
            <%--} else {--%>
                <%--jQuery("#client_help").html("导入数量为:" + result);--%>
                <%--jQuery("#client_help").css("visibility", "visible");--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>

    <%--</script>--%>
</head>
<body>

<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a style="font-size:13px" href="${pageContext.request.contextPath}/backend/dashboard.html" class="tip-bottom"><i class="icon-home"></i> Dashboard</a> <a style="font-size:13px" href="javascript:void(0);" class="current">STB Mac Management</a> </div>
  </div>

  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">

        <div class="widget-box">
          <div class="widget-title" style="padding-top: 2px;">
            <form id="user_search_form" action="${pageContext.request.contextPath}/backend/clientoverview.html" method="POST">
                <%--<a href="#" onclick="openClientImportDialog();"><span class="icon"><i class="icon-forward"></i></span></a>--%>
                <a href="${pageContext.request.contextPath}/backend/clientform.html"><span class="icon"><i class="icon-plus"></i></span></a>
                <h5>STB MAC:</h5> <input type="text" name="filername" class="text" value="${paging.contactName}" style="height: 25px;"/>
                &nbsp;
                <i class="icon icon-search" onclick="jQuery('#user_search_form').submit();"></i>
            </form>
          </div>

          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th style="font-size: 12px" width="10%">Timestamp</th>
                  <th style="font-size: 12px" width="30%">STB MAC Range</th>
                  <th style="font-size: 12px" width="40%">Note</th>
                  <th style="font-size: 12px">Actions</th>
                </tr>
              </thead>

              <tbody>
                <c:forEach items="${clients}" var="client">
                    <tr class="gradeX">
                        <td>${client.createTime}</td>
                        <td>${client.macFrom} - ${client.macTo}</td>
                        <td>${client.note}</td>
                      <td class="center">
                        <a href="${pageContext.request.contextPath}/backend/clientform.html?clientId=${client.id}&filername=${filername}&current=${current}" class="btn btn-primary btn-mini">Edit</a>
                        <a href="javascript:void(0);" onclick="deleteMac('${client.id}');" class="btn btn-primary btn-mini">Delete</a>
                      </td>
                    </tr>
                </c:forEach>
              </tbody>

            </table>
          </div>

          <div class="widget-content nopadding">
            <div class="pagination alternate" style="padding-left: 10px">
                <ul>
                    <ch:paging urlMapping="${pageContext.request.contextPath}/backend/clientoverview.html" paging="${paging}"/>
                </ul>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>

</div>

<div id="client_delete_dialog" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Are you sure you want to delete this STB mac limitation?
    </p>
</div>

<script type="text/javascript">

    function deleteMac(clientId) {
        jQuery("#client_delete_dialog").css("visibility", "visible");
        jQuery("#client_delete_dialog").dialog({
            resizable: false,
            height:160,
            width:300,
            modal: true,
            buttons: {
                "Confirm": function() {
                    jQuery("#client_delete_dialog").css("visibility", "hidden");
                    jQuery(this).dialog("close");
                    window.location.href = '${pageContext.request.contextPath}/backend/clientdelete.html?clientId=' + clientId + '&filername=${filername}&current=${current}';
                },
                "Cancel": function() {
                    jQuery("#client_delete_dialog").css("visibility", "hidden");
                    jQuery(this).dialog("close");
                }
            }
        });
    }
</script>

</body>
</html>