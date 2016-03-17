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
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/maruti.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/engine.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/util.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/interface/SystemDWRHandler.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/popup/modal.popup.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.22.custom.css" type="text/css"/>
    <style type="text/css">
        .tbl_paddingleft {
            padding-left: 20px !important;
        }
    </style>
</head>
<body>

<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a href="${pageContext.request.contextPath}/backend/dashboard.html" class="tip-bottom"><i class="icon-home"></i> Dashboard</a> <a href="javascript:void(0);" class="current">App Category Management</a> </div>
  </div>

  <div class="container-fluid">

    <div class="row-fluid">
      <div class="span12">

      <div class="widget-box">
        <div class="widget-title">
            <a href="javascript:void(0);" onclick="openCategoryDialog('-1', 'add');">
            <span class="icon">
                <i class="icon-plus"></i>
            </span>
            </a>
            <h5>App Category Management</h5>
        </div>

        <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
                <thead>
                    <tr>
                        <th width="50%" class="tbl_paddingleft">Category Name</th>
                        <th width="20%" class="tbl_paddingleft">Move</th>
                        <th class="tbl_paddingleft">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${categories}" var="category">
                        <tr class="gradeX">
                            <td class="tbl_paddingleft">${category.categoryName}</td>
                            <td class="tbl_paddingleft">
                                <c:if test="${sequence_min != category.sequence}">
                                    <a title="up" href="javascript:void(0);" onclick="changeCategorySequencce(${category.id}, 'up');"><img src="${pageContext.request.contextPath}/images/sequence_up.gif"/></a>
                                </c:if>
                                <c:if test="${sequence_max != category.sequence}">
                                    <a title="down" href="javascript:void(0);" onclick="changeCategorySequencce(${category.id}, 'down');"><img src="${pageContext.request.contextPath}/images/sequence_down.gif"/></a>
                                </c:if>
                            </td>
                            <td class="center tbl_paddingleft">
                                <a href="javascript:void(0);" onclick="openCategoryDialog('${category.id}', 'edit');" class="btn btn-primary btn-mini">Edit</a>
                                <a href="javascript:void(0);" onclick="categoryDeleteConfirm('${category.id}');" class="btn btn-danger btn-mini">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
      </div>

      </div>
    </div>
  </div>

</div>

<div id="category_delete_dialog" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Are you sure you want to delete this category from the system?
    </p>
</div>

<div id="category_delete_refuse" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        There exist apps under this category, if you want to delete this category, please remove these apps to another category first.
    </p>
</div>

<script>
    jQuery(function() {
		settings = {
			align : 'center',									//Valid values, left, right, center
			top : 50, 											//Use an integer (in pixels)
			width : 600, 										//Use an integer (in pixels)
			padding : 10,										//Use an integer (in pixels)
	        backgroundColor : 'white', 						    //Use any hex code
	        source : '', 				    					//Refer to any page on your server, external pages are not valid e.g. http://www.google.co.uk
	        borderColor : '#333333', 							//Use any hex code
	        borderWeight : 4,									//Use an integer (in pixels)
	        borderRadius : 5, 									//Use an integer (in pixels)
	        fadeOutTime : 300, 									//Use any integer, 0 : no fade
	        disableColor : '#666666', 							//Use any hex code
	        disableOpacity : 40, 								//Valid range 0-100
	        loadingImage : '${pageContext.request.contextPath}/js/popup/loading.gif'
		};
		jQuery(document).keyup(function(event) {
			if (event.keyCode == 27) {
				closePopup(settings.fadeOutTime);
			}
		});

	});
	function openCategoryDialog(id, method) {
		settings.source = '${pageContext.request.contextPath}/backend/appcategoryform.html?categoryId=' + id + '&method=' + method;
		openModalPopup(settings);
	}

	function openModalPopup(obj) {
		modalPopup(obj.align, obj.top, obj.width, obj.padding, obj.disableColor, obj.disableOpacity, obj.backgroundColor, obj.borderColor, obj.borderWeight, obj.borderRadius, obj.fadeOutTime, obj.source, obj.loadingImage);
	}

    function showIconPlace() {
        var parentId = jQuery("#parentId").val();
        if(parentId > 0) {
            jQuery("#icon_place").css("display", "block");
        } else {
            jQuery("#icon_place").css("display", "none");
        }
    }

    function saveAppCategory(form) {
        var parentId = jQuery("#parentId").val();
        var categoryId = jQuery("#categoryId").val();
        var categoryName = jQuery("#categoryName").val();
        var oldParentId = jQuery("#oldParentId").val();
        if(categoryName == null || categoryName == '') {
            jQuery("#categoryName_help").css("display", "block");
            return;
        } else {
            jQuery("#categoryName_help").css("display", "none");
        }

        if(categoryId <= 0 && parentId > 0) {
            var categoryIconName = jQuery("#categoryIconName").val();
            if(categoryIconName == null || categoryIconName == '') {
                jQuery("#categoryIcon_help").css("display", "block");
                return;
            } else {
                if(!isImage(categoryIconName)) {
                    jQuery("#categoryIcon_format_help").css("display", "block");
                    return;
                }
            }
        }  else if(categoryId > 0 && parentId >=0 && oldParentId <= 0) {
            var categoryIconName = jQuery("#categoryIconName").val();
            if(categoryIconName == null || categoryIconName == '') {
                jQuery("#categoryIcon_help").css("display", "block");
                return;
            } else {
                if(!isImage(categoryIconName)) {
                    jQuery("#categoryIcon_format_help").css("display", "block");
                    return;
                }
            }
        } else {
            var categoryIconName = jQuery("#categoryIconName").val();
            if(categoryIconName != null && categoryIconName != '') {
                if(!isImage(categoryIconName)) {
                    jQuery("#categoryIcon_format_help").css("display", "block");
                    return;
                }
            }
        }

        form.submit();
    }

    function isImage(url) {
        var filename = url.substring(url.lastIndexOf(".") + 1).toLowerCase();
        if (filename != "jpg" && filename != "gif" && filename != "png" && filename != "bmp" && filename != "jpeg") {
             return false;
        }
        return true;
    }

    function categoryDeleteConfirm(categoryId) {
        jQuery("#category_delete_dialog").css("visibility", "visible");
        jQuery("#category_delete_dialog").dialog({
                resizable: false,
                height:160,
                width:300,
                modal: true,
                buttons: {
                    "Confirm": function() {
                        jQuery("#category_delete_dialog").css("visibility", "hidden");
                        jQuery("#category_delete_dialog").dialog("close");
                        SystemDWRHandler.obtainCategoryHasApps(categoryId, function(result) {
                            if(result) {
                                jQuery("#category_delete_refuse").css("visibility", "visible");
                                jQuery("#category_delete_refuse").dialog({
                                        resizable: false,
                                        height:160,
                                        width:300,
                                        modal: true,
                                        buttons: {
                                            "Cancel": function() {
                                                jQuery("#category_delete_refuse").css("visibility", "hidden");
                                                jQuery(this).dialog("close");
                                            }
                                        }
                                    });
                            } else {
                                jQuery("#category_delete_refuse").dialog("close");
                                window.location.href = '${pageContext.request.contextPath}/backend/categorydelete.html?categoryId=' + categoryId;
                            }
                        });

                    },
                    "Cancel": function() {
                        jQuery("#category_delete_dialog").css("visibility", "hidden");
                        jQuery(this).dialog("close");
                    }
                }
            });
    }

    function changeCategorySequencce(id, method) {
        window.location.href = '${pageContext.request.contextPath}/backend/categorysequencechg.html?categoryId=' + id + '&method=' + method;
    }

</script>

</body>
</html>