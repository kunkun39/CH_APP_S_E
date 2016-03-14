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
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/maruti.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/engine.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/util.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/interface/SystemDWRHandler.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.16.custom.min.js" type="text/javascript"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-ui/jquery-ui-1.8.22.custom.css" type="text/css"/>
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
                        <c:set var="buttons_show" value="hidden"/>
                        <c:set var="info_show" value="hidden"/>
                        <c:choose>
                            <c:when test="${record.changeUserId == currentUserId && !record.commit}">
                                <c:set var="buttons_show" value="visible"/>
                            </c:when>
                            <c:when test="${record.changeUserId != currentUserId && !record.commit}">
                                <c:set var="info_show" value="visible"/>
                            </c:when>
                        </c:choose>
                        <div id="commit_buttons" class="buttons" style="visibility: ${buttons_show};">
                            <button onclick="changeCommit(true);" class="btn btn-mini"><i class="icon-refresh"></i>  Confirm Update</button>
                            <button onclick="changeCommit(false);" class="btn btn-mini"><i class="icon-fullscreen"></i>  Cancel Update</button>
                        </div>
                        <div id="commit_info" class="buttons"  style="visibility: ${info_show};">
                            User ${record.changeUsername}is changing box pages setting...
                        </div>
                    </div>

                    <div class="widget-content">
                        <%--推荐部分--%>
                        <div class="row-fluid">
                            <div class="span12 btn-icon-pg">
                                <ul>
                                    <li onclick="resetPageNumber(1);"><i class="icon-star" ></i> Home</li>
                                    <li onclick="resetPageNumber(2);"><i class="icon-th-list"></i> ${category_1.categoryName}</li>
                                    <li onclick="resetPageNumber(3);"><i class="icon-gift"></i> ${category_2.categoryName}</li>
                                    <li onclick="resetPageNumber(4);"><i class="icon-briefcase"></i> ${category_3.categoryName}</li>
                                    <li onclick="resetPageNumber(5);"><i class="icon-adjust"></i> Topics</li>
                                </ul>
                            </div>

                            <jsp:include page="recommend/recommendpage1.jsp"/>
                            <jsp:include page="recommend/recommendpage2.jsp"/>
                            <jsp:include page="recommend/recommendpage3.jsp"/>
                            <jsp:include page="recommend/recommendpage4.jsp"/>
                            <jsp:include page="recommend/recommendpage5.jsp"/>
                        </div>

                        <%--推荐操作部分--%>
                        <br/>
                        <br/>

                        <security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_APP_RECOMMEND">
                            <table class="table table-bordered table-striped">
                                <thead>
                                <tr>
                                    <th style="font-size:13px">Filters</th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>
                                    Position Information:
                                    <a class="lightbox_trigger" href="${pageContext.request.contextPath}/images/position_example.png">
                                        <img width="100px" height="50px" alt="" src="${pageContext.request.contextPath}/images/position_example.png"/>
                                    </a>
                                    App Name:<select id="categoryId" name="categoryId" style="height: 30px;" >
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
                                <tr>
                                    <td>
                                        <div class="control-group">
                                            <label class="control-label">Recommend to</label>
                                            <div id="recommend_options" class="controls">
                                                <input type="radio" name="rem_radios" value="1"/> Position 1st&nbsp;&nbsp;
                                                <input type="radio" name="rem_radios" value="2"/> Position 2nd&nbsp;&nbsp;
                                                <input type="radio" name="rem_radios" value="3"/> Position 3rd&nbsp;&nbsp;
                                                <input type="radio" name="rem_radios" value="4"/> Position 4th&nbsp;&nbsp;
                                                <input type="radio" name="rem_radios" value="5"/> Position 5th&nbsp;&nbsp;
                                                <input type="radio" name="rem_radios" value="6"/> Position 6th&nbsp;&nbsp;
                                                <input type="radio" name="rem_radios" value="7"/> Position 7th&nbsp;&nbsp;
                                                <input type="radio" name="rem_radios" value="8"/> Position 8th&nbsp;&nbsp;
                                                <input type="radio" name="rem_radios" value="9"/> Position 9th&nbsp;&nbsp;
                                                <input type="radio" name="rem_radios" value="10"/> Position 10th&nbsp;&nbsp;
                                                <input type="radio" name="rem_radios" value="11"/> Position 11th&nbsp;&nbsp;
                                                <input type="radio" name="rem_radios" value="12"/> Position 12th&nbsp;&nbsp;
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                </tbody>
                            </table>

                            <%--！搜索结果部分--%>
                            <div class="widget-content nopadding">
                                <ul id="search_list_content" class="recent-posts">

                                </ul>
                            </div>
                        </security:authorize>

                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<div id="notselected-dialog-confirm" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Please select position which you want to recommend to?
    </p>
</div>

<div id="recommend-dialog-confirm" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Are you sure you want to recommend this app to this position?
    </p>
</div>

<div id="commit-dialog-confirm" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        There exist one person change this recommendation, please change later.
    </p>
</div>

<div id="update-dialog-confirm" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        After confirmation, the end user will see what you have changed, are you sure you want to confirm these changes?
    </p>
</div>

<div id="cancel-dialog-confirm" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        Are you sure you want to cancel this recommendation?
    </p>
</div>

<div id="duplicate-dialog-confirm" title="System Confirm Dialog?" style="visibility: hidden;">
    <p>
        <span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
        This app already recommend to another position, do you continue?
    </p>
</div>

<script type="text/javascript">
    var fileRequestHost = '${fileRequestHost}';
    var currentPage = 1;

    // enter key can search app directly
    document.onkeydown = function(e){
        if(!e) e = window.event;//火狐中是 window.event
        if((e.keyCode || e.which) == 13){
            jQuery("#app_search_button").click();
        }
    }

    // reset the page number currently
    function resetPageNumber(pageNumber) {
        currentPage = pageNumber;
        for(var i=1; i<=5; i++) {
            if(i == currentPage) {
                 jQuery("#part_" + i).css("display", "block");
            } else {
                jQuery("#part_" + i).css("display", "none");
            }
        }
    }

    // search app
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

    // recommend app
    function recommendAppTo(appId) {
        //1 - check is position is selected or not
        var itemPostion = $("input[name='rem_radios']:checked").val();
        if(itemPostion == null || itemPostion == undefined || itemPostion == "") {
            jQuery("#notselected-dialog-confirm").css("visibility", "visible");
            jQuery("#notselected-dialog-confirm").dialog({
                resizable: false,
                height:160,
                width:300,
                modal: true,
                buttons: {
                    "Cancel": function() {
                        jQuery("#notselected-dialog-confirm").css("visibility", "hidden");
                        jQuery(this).dialog("close");
                    }
                }
            });
            return;
        }

        //2 - recommend app to which page and position, first check is any other position recommend
        SystemDWRHandler.obtainCheckIsAppRecommend(appId, currentPage, itemPostion, function(result) {
            var boxRecommend = JSON.parse(result);
            var pageIndex = boxRecommend.page_index;
            var positionIndex = boxRecommend.position_index;

            //2.1 - if recommend, comfirm with user
            if(pageIndex > 0) {
                jQuery("#duplicate-dialog-confirm").css("visibility", "visible");
                jQuery("#duplicate-dialog-confirm").dialog({
                    resizable: false,
                    height:160,
                    width:300,
                    modal: true,
                    buttons: {
                        "Confirm": function() {
                            jQuery("#duplicate-dialog-confirm").css("visibility", "hidden");
                            jQuery(this).dialog("close");
                            confirmRecommendApp(itemPostion, appId);
                        },
                        "Cancel": function() {
                            jQuery("#duplicate-dialog-confirm").css("visibility", "hidden");
                            jQuery(this).dialog("close");
                        }
                    }
                });
            } else {
                //2.2 - not recommend, update the db
                confirmRecommendApp(itemPostion, appId);
            }
        });
    }

    function confirmRecommendApp(itemPosition, appId) {
        jQuery("#recommend-dialog-confirm").css("visibility", "visible");
        jQuery("#recommend-dialog-confirm").dialog({
            resizable: false,
            height:160,
            width:300,
            modal: true,
            buttons: {
                "Confirm": function() {
                        jQuery("#recommend-dialog-confirm").css("visibility", "hidden");
                        jQuery(this).dialog("close");

                        SystemDWRHandler.updateBoxRecommendPosition(currentPage, itemPosition, appId, ${currentUserId}, function(result) {
                            if(result) {
                                jQuery("#commit_buttons").css("visibility", "visible");
                                jQuery("#commit_info").css("visibility", "hidden");

                                SystemDWRHandler.obtainRecommendApps(appId, -1, "", function(result) {
                                    var appValues = JSON.parse(result)[0];
                                    var path = "";
                                    if(itemPosition <= 6) {
                                        path = fileRequestHost + appValues.appKey + "/" + appValues.posterActualFileName;
                                    } else {
                                        path = fileRequestHost + appValues.appKey + "/" + appValues.iconActualFileName;
                                    }
                                    jQuery("#" + currentPage + "_pos_img_" + itemPosition).attr("src", path);
                                    jQuery("#" + currentPage + "_pos_name_" + itemPosition).html(appValues.appFullName);
                                });
                            } else {
                                jQuery("#commit_buttons").css("visibility", "hidden");
                                jQuery("#commit_info").css("visibility", "visible");

                                jQuery("#commit-dialog-confirm").css("visibility", "visible");
                                jQuery("#commit-dialog-confirm").dialog({
                                    resizable: false,
                                    height:160,
                                    width:300,
                                    modal: true,
                                    buttons: {
                                        "Cancel": function() {
                                            jQuery("#commit-dialog-confirm").css("visibility", "hidden");
                                            jQuery(this).dialog("close");
                                        }
                                    }
                                });
                            }
                        });
                    },
                "Cancel": function() {
                    jQuery("#notselected-dialog-confirm").css("visibility", "hidden");
                    jQuery(this).dialog("close");
                }
            }
        });
    }

    function changeCommit(update) {
        if(update) {
            jQuery("#update-dialog-confirm").css("visibility", "visible");
            jQuery("#update-dialog-confirm").dialog({
                resizable: false,
                height:160,
                width:300,
                modal: true,
                buttons: {
                    "Confirm": function() {
                        window.location.href = "${pageContext.request.contextPath}/backend/updateboxrecommend.html";
                    },
                    "Cancel": function() {
                        jQuery("#update-dialog-confirm").css("visibility", "hidden");
                        jQuery(this).dialog("close");
                    }
                }
            });
        } else {
            jQuery("#cancel-dialog-confirm").css("visibility", "visible");
            jQuery("#cancel-dialog-confirm").dialog({
                resizable: false,
                height:160,
                width:300,
                modal: true,
                buttons: {
                    "Confirm": function() {
                        window.location.href = "${pageContext.request.contextPath}/backend/cancelboxrecommend.html";
                    },
                    "Cancel": function() {
                        jQuery("#cancel-dialog-confirm").css("visibility", "hidden");
                        jQuery(this).dialog("close");
                    }
                }
            });
        }
    }


</script>
</body>
</html>