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
                    <h5>Vip Member Management</h5>
                </div>

                <div class="widget-content nopadding">
                    <form action="${pageContext.request.contextPath}/backend/vipmemberform.html" method="post" class="form-horizontal" enctype="multipart/form-data">
                        <input type="hidden" id="groupId" name="groupId" value="${groupId}"/>
                        <input type="hidden" name="method" value="save"/>
                        <div class="control-group">
                            <label class="control-label">Box Mac [Required]</label>
                            <div class="controls">
                                <input type="text" id="boxMac" name="boxMac" class="span20"/>
                                <span id="boxMac_help" class="help-block" style="display: none;"></span>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="btn btn-success" onclick="closePopup(settings.fadeOutTime);">Cancel</button>
                            <button type="button" class="btn btn-success" onclick="saveVipMember(this.form);">Save</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

</body>
</html>