<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="spring-form" uri="http://www.springframework.org/tags/form" %>
<html>
<body>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <div class="widget-box">

                <div class="widget-title">
                    <span class="icon">
                        <i class="icon-align-justify"></i>
                    </span>
                    <h5>App Topic Management</h5>
                </div>

                <div class="widget-content nopadding">
                    <form action="${pageContext.request.contextPath}/backend/apptopicform.html" method="post" class="form-horizontal" enctype="multipart/form-data">
                        <input type="hidden" id="topicId" name="topicId" value="${topic.id}"/>
                        <input type="hidden" name="method" value="save"/>
                        <div class="control-group">
                            <label class="control-label">Topic Name [Required]</label>
                            <div class="controls">
                                <input type="text" id="topicName" name="topicName" class="span20" value="${topic.topicName}"/>
                                <span id="topicName_help" class="help-block" style="display: none;">The Topic Name field not allowed to be empty</span>
                            </div>
                        </div>
                        <c:set var="iconShow" value="${topic.topicIconId > 0 ? 1:0}"/>
                        <div id="icon_place" class="control-group">
                            <label class="control-label">Topic ICON [Required]</label>
                            <div class="controls">
                                <input type="file" id="topicIconName" name="topicIconName" class="span20"/>
                                <span id="topicIcon_help" class="help-block" style="display: none;">The Topic ICON field not allowed to be empty</span>
                                <span id="topicIcon_format_help" class="help-block" style="display: none;">The picture you selected is not image format</span>
                            </div>
                        </div>
                        <c:if test="${topic.topicIconId > 0}">
                            <div>
                                <div class="controls">
                                    <img style="width: 100px; height: 100px;" src="${fileRequestHost}topic/${topic.topicIconName}" alt="" >
                                </div>
                            </div>
                        </c:if>
                        <div class="form-actions">
                            <button type="button" class="btn btn-success" onclick="closePopup(settings.fadeOutTime);">Cancel</button>
                            <button type="button" class="btn btn-success" onclick="saveAppTopic(this.form);">Save</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

</body>
</html>