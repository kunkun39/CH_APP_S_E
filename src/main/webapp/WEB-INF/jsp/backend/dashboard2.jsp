<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <script src="${pageContext.request.contextPath}/js/maruti.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/engine.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/util.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/interface/SystemDWRHandler.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/popup/modal.popup.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.22.custom.css" type="text/css"/>
    <style type="text/css">

        .fileInputContainer{
            height:50px;
            background:url(http://127.0.0.1:8082/appmarket/icon_add.png);
            position:relative;
            width: 50px;

        }
        .fileInput{
            height:50px;
            font-size: 50px;
            position:absolute;
            right:0;
            top:0;
            opacity: 0;
            filter:alpha(opacity=0);
            cursor:pointer;
        }

    </style>
</head>
<body>
<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="content">
    <div id="content-header">
        <div id="breadcrumb">
            <a style="font-size:13px" href="${pageContext.request.contextPath}/backend/dashboard.html" class="tip-bottom"><i class="icon-home"></i> Dashboard</a>
            <a style="font-size:13px" href="javascript:void(0);" class="current">Display of Box Foreground Pages</a>
        </div>
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
                        <h5>Display of Box Foreground Pages</h5>
                    </div>
                    <div class="widget-content">
                        <div class="row-fluid">
                            <div class="tv_main">
                                <div class="centerside1">
                                    <c:forEach items="${posters}" var="poster">
                                        <div class="preview4">
                                            <div class="wrap4">
                                                <img id="img_${poster.id}" src="<c:if test="${poster.posterActualFileName != ''}">${fileRequestHost}homepageposter/${poster.posterActualFileName}</c:if>"/>
                                                <c:if test="${poster.posterActualFileName == ''}">
                                                    <div>
                                                        <a href="javascript:void(0);" onclick="openPosterUploadDialog(${poster.id});">
                                                            <img src="${pageContext.request.contextPath}/images/icon_add.png"/>
                                                        </a>
                                                    </div>
                                                </c:if>
                                                <c:if test="${poster.posterActualFileName != ''}">
                                                    <div class="action">
                                                        <a href="javascript:void(0);" onclick="openPosterUploadDialog(${poster.id});" class="btn btn-primary btn-mini">
                                                            <i class="icon-pencil icon-white"></i>Edit
                                                        </a>
                                                        <a href="javascript:void(0);" onclick="posterDeleteConfirm(${poster.id});" class="btn btn-danger btn-mini">
                                                            <i class="icon-remove icon-white"></i>Delete
                                                        </a>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="poster_delete_dialog" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Are you sure you want to delete this poster from the system?
    </p>
</div>
<script type="text/javascript">
    var homePagePosterValidate = false;
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

    function openPosterUploadDialog(id) {
        settings.source = '${pageContext.request.contextPath}/backend/homepageposterform.html?id=' + id;
        openModalPopup(settings);
    }
    function openModalPopup(obj) {
        modalPopup(obj.align, obj.top, obj.width, obj.padding, obj.disableColor, obj.disableOpacity, obj.backgroundColor, obj.borderColor, obj.borderWeight, obj.borderRadius, obj.fadeOutTime, obj.source, obj.loadingImage);
    }

    function validatePosterImage(obj) {
        var url,size;
        if ($.support.msie) {
            url = obj.value;
        } else {
            url = window.URL.createObjectURL(obj.files[0]);
        }

        var posterFile = jQuery("#posterFile");
        var posterFileName = posterFile.val();

        if (!/.(jpg|jpeg|png|JPG|JPEG|PNG)$/.test(posterFileName)) {
            jQuery("#poster_error_show").html("picture format should be JPG, JEPG, PNG, please reselect the picture");
            jQuery("#poster_error_show").css("display", "block");
            homePagePosterValidate = false;
        } else {
            jQuery("#view_image").attr("src", url).load(function() {
                size = obj.files[0].size;
                if (size > 50 * 1024) {
                    jQuery("#poster_error_show").html("picture size should be less than 50K");
                    jQuery("#poster_error_show").css("display", "block");
                    homePagePosterValidate = false;
                } else {
                    jQuery("#poster_error_show").css("display", "none");
                    homePagePosterValidate = true;
                }
            });
        }
    }

    function saveHomePagePoster(form) {
        if (homePagePosterValidate == true) {
            form.submit();
        } else {
            jQuery("#poster_error_show").html("The picture is not validated");
            jQuery("#poster_error_show").css("display", "block");
        }
    }

    function posterDeleteConfirm(id) {
        jQuery("#poster_delete_dialog").css("visibility", "visible");
        jQuery("#poster_delete_dialog").dialog({
            resizable: false,
            height:160,
            width:300,
            modal: true,
            buttons: {
                "确  认": function() {
                    window.location.href = "${pageContext.request.contextPath}/backend/homepageposterdelete.html?id=" + id;
                },
                "取  消": function() {
                    jQuery("#poster_delete_dialog").css("visibility", "hidden");
                    jQuery(this).dialog("close");
                }
            }
        });
    }
</script>

</body>
</html>
