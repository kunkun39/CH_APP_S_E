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
                    <h5>HomePage Poster Edit</h5>
                </div>

                <div class="widget-content nopadding">
                    <form action="${pageContext.request.contextPath}/backend/homepageposterform.html" method="post" class="form-horizontal" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${poster.id}"/>
                        <input type="hidden" name="method" value="save"/>
                        <div id="icon_place" class="control-group">
                            <label class="control-label" style="width: 200px;">HomePage Poster [Required]</label>
                            <div class="controls" style="margin-left: 220px;">
                                <input type="file" id="posterFile" name="posterFile" class="span20" onchange="validatePosterImage(this);"/>
                                <span id="poster_error_show" class="help-block" style="display: none;"></span>
                            </div>
                        </div>
                        <c:if test="${poster.posterActualFileName != ''}">
                            <div>
                                <div class="controls">
                                    <img style="width: 80px; height: 60px;" src="${fileRequestHost}homepageposter/${poster.posterActualFileName}" alt="" >
                                </div>
                            </div>
                        </c:if>
                        <div class="form-actions">
                            <button type="button" class="btn btn-success" onclick="closePopup(settings.fadeOutTime);">取 消</button>
                            <button type="button" class="btn btn-success" onclick="saveHomePagePoster(this.form);">保 存</button>
                        </div>
                        <img id="view_image" src="" style="display: none;"/>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>