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
                    <h5>App Category Edit<</h5>
                </div>

                <div class="widget-content nopadding">
                    <form action="${pageContext.request.contextPath}/backend/appcategoryform.html" method="post" class="form-horizontal" enctype="multipart/form-data">
                        <input type="hidden" id="categoryId" name="categoryId" value="${category.id}"/>
                        <input type="hidden" id="oldParentId" name="oldParentId" value="${category.parentId}"/>
                        <input type="hidden" name="method" value="save"/>
                        <div class="control-group">
                            <label class="control-label">Category Name [Required]</label>
                            <div class="controls">
                                <input type="text" id="categoryName" name="categoryName" class="span20" value="${category.categoryName}"/>
                                <span id="categoryName_help" class="help-block" style="display: none;">The category name field not allowed to be empty</span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Category Level [Required]</label>
                            <div class="controls">
                                <select id="parentId" name="parentId" onchange="showIconPlace();" <c:if test="${category.includeChild && category.id > 0}">disabled="true"</c:if></select>
                                    <option value="-1" <c:if test="${category.parentId==-1}">selected="true"</c:if>>First-level Category</option>
                                    <c:forEach items="${parents}" var="parent">
                                        <option value="${parent.id}" <c:if test="${category.parentId==parent.id}">selected="true"</c:if>>Under the level of ${parent.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <c:set var="iconShow" value="${category.categoryIconId > 0 ? 1:0}"/>
                        <div id="icon_place" class="control-group" <c:if test="${category.includeChild}">style="display: none;"</c:if>>
                            <label class="control-label">Category ICON [Required]</label>
                            <div class="controls">
                                <input type="file" id="categoryIconName" name="categoryIconName" class="span20"/>
                                <span id="categoryIcon_help" class="help-block" style="display: none;">The category icon field not allowed to be empty</span>
                                <span id="categoryIcon_format_help" class="help-block" style="display: none;">The category icon you selected is not a image format</span>
                            </div>
                        </div>
                        <c:if test="${category.categoryIconId > 0}">
                            <div>
                                <div class="controls">
                                    <img style="width: 60px; height: 60px;" src="${fileRequestHost}category/${category.categoryIconName}" alt="" >
                                </div>
                            </div>
                        </c:if>
                        <div class="form-actions">
                            <button type="button" class="btn btn-success" onclick="closePopup(settings.fadeOutTime);">Cancel</button>
                            <button type="button" class="btn btn-success" onclick="saveAppCategory(this.form);">Save</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

</body>
</html>