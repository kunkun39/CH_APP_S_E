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
                    <h5>Edit/New Mutip File Host</h5>
                </div>

                <div class="widget-content nopadding">
                    <form action="${pageContext.request.contextPath}/backend/hostform.html" method="post" class="form-horizontal" enctype="multipart/form-data">
                        <input type="hidden" id="hostId" name="hostId" value="${host.id}"/>
                        <input type="hidden" name="method" value="save"/>
                        <div class="control-group">
                            <label class="control-label">Host Address [Required]</label>
                            <div class="controls">
                                <input type="text" id="hostName" name="hostName" class="span20" value="${host.hostName}"/>
                                <span id="hostName_help" class="help-block" style="display: none;">Host should not be empty</span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"></label>
                            <div class="controls">
                                Such as http://127.0.0.1/appmarket/upload/
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="button" class="btn btn-success" onclick="closePopup(settings.fadeOutTime);">Cancel</button>
                            <button type="button" class="btn btn-success" onclick="saveMultipHost(this.form);">Save</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>

</body>
</html>