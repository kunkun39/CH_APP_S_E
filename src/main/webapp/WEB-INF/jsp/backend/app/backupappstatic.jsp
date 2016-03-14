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
    <script src="${pageContext.request.contextPath}/js/highslide/highcharts.js"></script>
    <script src="${pageContext.request.contextPath}/js/highslide/exporting.js"></script>
    <script src="${pageContext.request.contextPath}/js/highslide/dark-green.js"></script>
    <script src="${pageContext.request.contextPath}/js/highslide/report/backup_app_static.js"></script>
    <script src="${pageContext.request.contextPath}/dwr/engine.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/util.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/dwr/interface/SystemDWRHandler.js" type="text/javascript"></script>
</head>
<body>

<%--开头菜单部分***********************************************************--%>

<jsp:include page="/WEB-INF/decorators/header.jsp"/>

<%--内容部分***********************************************************--%>

<div id="commit_form_mask">

<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a style="font-size: 13px" href="${pageContext.request.contextPath}/backend/dashboard.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Dashboard</a> <a style="font-size: 13px" href="javascript:void(0);" class="current">Clould Service Usage Statistic</a> </div>
  </div>

<div class="container-fluid">
    <div class="row-fluid">
    <div class="span12">

      <div class="widget-box">
          <div class="widget-title"><a href="javascript:void(0);"><span class="icon"> <i class="icon-signal"></i> </span></a>
            <h5>Cloud Service Usage Statistic</h5>
          </div>

          <div class="widget-content">
            <form id="app_statistic_form" action="${pageContext.request.contextPath}/backend/marketappoverview.html" method="post">
            <input type="hidden" id="appStatus" name="appStatus" value="${paging.appStatus}">
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th style="font-size: 12px">Filter</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                      Year:
                      <select id="sta_year" name="sta_year" style="height: 30px;">
                          <c:forEach begin="2015" end="2020" step="1" var="sta_year">
                              <option value="${sta_year}" <c:if test="${currentYear==sta_year}">selected="true"</c:if>>${sta_year}</option>
                          </c:forEach>
                      </select>
                      &nbsp;
                      Month:
                      <select id="sta_month" name="sta_month" style="height: 30px;">
                          <option value="0">All</option>
                          <c:forEach begin="1" end="12" step="1" var="sta_month">
                              <option value="${sta_month}">${sta_month}</option>
                          </c:forEach>
                      </select>
                      &nbsp;
                     <i class="icon icon-search" onclick="generateReport();"></i>
                  </td>
                </tr>
              </tbody>
            </table>
            </form>

            <div class="row-fluid">
                <div class="span12">
                    <div class="widget-box">
                        <div class="widget-title">
                            <span class="icon">
                                <i class="icon-signal"></i>
                            </span>
                            <h5>Results</h5>
                        </div>
                        <div class="widget-content">
                            <div id="backup_line_sta" class="bars"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
      </div>
    </div>
    </div>
</div>
</div>
</div>


<script type="text/javascript">

    jQuery(document).ready(function(){
        generateReport();
    });

        function generateReport() {
        var sta_year = jQuery("#sta_year").val();
        var sta_month = jQuery("#sta_month").val();
        renew_line_container(sta_year, sta_month);
    }

    function renew_line_container(year, month) {
        if("0" == month) {
            //全年的报表
            //一个月的报表
            SystemDWRHandler.obtainBackUpAppStaticData(year, month, function(result) {
                var statisticData = JSON.parse(result);
                var backup_sta = statisticData[0].backup_sta.split(",");
                var delete_sta = statisticData[0].delete_sta.split(",");
                var days = statisticData[0].days;
                backup_line_sta_container.xAxis.categories = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];

                var backupData = new Array();
                for(var i=0; i<backup_sta.length; i++) {
                    backupData[i] = parseInt(backup_sta[i]);
                }
                backup_line_sta_container.series[0].data = backupData;

                var deleteData = new Array();
                for(var i=0; i<delete_sta.length; i++) {
                    deleteData[i] = parseInt(delete_sta[i]);
                }
                backup_line_sta_container.series[1].data = deleteData;
                backup_line_sta_container.title.text = "Cloud Service Usage Statistic";

                var maxBackupValue = getMaxValue(backupData);
                var maxDeleteValue = getMaxValue(deleteData);
                var offset = backup_line_sta_container.yAxis.minTickInterval / 2;
                if (maxBackupValue == maxDeleteValue && maxBackupValue == 0) {

                }
                else if (maxBackupValue > maxDeleteValue) {
                    backup_line_sta_container.yAxis.max = maxBackupValue + offset;
                }
                else {
                    backup_line_sta_container.yAxis.max = maxDeleteValue + offset;
                }

                new Highcharts.Chart(backup_line_sta_container);
            });
        } else {
            //一个月的报表
            SystemDWRHandler.obtainBackUpAppStaticData(year, month, function(result) {
                var statisticData = JSON.parse(result);
                var backup_sta = statisticData[0].backup_sta.split(",");
                var delete_sta = statisticData[0].delete_sta.split(",");

                var days = statisticData[0].days;
                if(parseInt(days) == 28) {
                    backup_line_sta_container.xAxis.categories = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28'];
                } else if (parseInt(days) == 29) {
                    backup_line_sta_container.xAxis.categories = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29'];
                } else if (parseInt(days) == 30) {
                    backup_line_sta_container.xAxis.categories = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30'];
                } else {
                    backup_line_sta_container.xAxis.categories = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31'];
                }

                var backupData = new Array();
                for(var i=0; i<backup_sta.length; i++) {
                    backupData[i] = parseInt(backup_sta[i]);
                }
                backup_line_sta_container.series[0].data = backupData;

                var deleteData = new Array();
                for(var i=0; i<delete_sta.length; i++) {
                    deleteData[i] = parseInt(delete_sta[i]);
                }
                backup_line_sta_container.series[1].data = deleteData;
                backup_line_sta_container.title.text = "云备份统计";

                var maxBackupValue = getMaxValue(backupData);
                var maxDeleteValue = getMaxValue(deleteData);
                var offset = backup_line_sta_container.yAxis.minTickInterval / 2;
                if (maxBackupValue == maxDeleteValue && maxBackupValue == 0) {

                }
                else if (maxBackupValue > maxDeleteValue) {
                    backup_line_sta_container.yAxis.max = maxBackupValue + offset;
                }
                else {
                    backup_line_sta_container.yAxis.max = maxDeleteValue + offset;
                }

                new Highcharts.Chart(backup_line_sta_container);
            });
        }
    }

    function getMaxValue(array) {
        var maxValue = 0;
        for (var i = 0; i < array.length; i++) {
            if (array[i] > maxValue) {
                maxValue = array[i];
            }
        }
        return maxValue;
    }
</script>
</body>
</html>