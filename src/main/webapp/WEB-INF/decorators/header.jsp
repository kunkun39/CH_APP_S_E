<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="ch" uri="http://www.chanhong.com" %>

<!--Header-part-->
<div id="header">
  <h1><a href="javascript:void(0);">App Market Backend Management System</a></h1>
</div>
<!--close-Header-part-->

<!--top-Header-messaages-->
<div class="btn-group rightzero">
    <a class="top_message tip-left" title="Manage Files"><i class="icon-file"></i></a>
    <a class="top_message tip-bottom" title="Manage Users"><i class="icon-user"></i></a>
    <a class="top_message tip-bottom" title="Manage Comments"><i class="icon-comment"></i><span class="label label-important">5</span></a>
    <a class="top_message tip-bottom" title="Manage Orders"><i class="icon-shopping-cart"></i></a>
</div>
<!--close-top-Header-messaages-->

<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse">
  <ul class="nav">
    <li class="" ><a title="" href="javascript:void(0);"><i class="icon icon-user"></i> <span class="text"><ch:user/></span></a></li>
    <li class=""><a title="" href="${pageContext.request.contextPath}/backend/userchangepassword.html"><i class="icon icon-cog"></i> <span class="text">Password Change</span></a></li>
    <li class=""><a title="" href="${pageContext.request.contextPath}/j_spring_security_logout"><i class="icon icon-share-alt"></i> <span class="text">Exit</span></a></li>
  </ul>
</div>
<!--close-top-Header-menu-->

<div id="sidebar"><a href="${pageContext.request.contextPath}/backend/dashboard.html" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>
  <ul>
    <li class="active"><a href="${pageContext.request.contextPath}/backend/dashboard.html"><i class="icon icon-home"></i> <span>Dashboard</span></a></li>

    <security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_APP_INFO,ROLE_APP_STATUS">
        <li class="submenu"> <a href="javascript:void(0);"><i class="icon icon-th"></i> <span>App Information Management</span> <span class="label">6</span></a>
          <ul>
              <li><a href="${pageContext.request.contextPath}/backend/appcategoryoverview.html"><i class="icon icon-hand-right"></i> <span>App Category Management</span></a></li>
              <li><a href="${pageContext.request.contextPath}/backend/apptopicoverview.html"><i class="icon icon-hand-right"></i> <span>App Topic Management</span></a></li>
              <li><a href="${pageContext.request.contextPath}/backend/marketappoverview.html"><i class="icon icon-hand-right"></i> <span>App Info Management</span></a></li>
              <li><a href="${pageContext.request.contextPath}/backend/appmust.html?install=true"><i class="icon icon-hand-right"></i> <span>Force Install App Management</span></a></li>
              <li><a href="${pageContext.request.contextPath}/backend/appmust.html?install=false"><i class="icon icon-hand-right"></i> <span>Force Uninstall App Management</span></a></li>
              <li><a href="${pageContext.request.contextPath}/backend/luncherrecommend.html"><i class="icon icon-hand-right"></i> <span>Other Position Recommendation</span></a></li>
          </ul>
        </li>
    </security:authorize>

    <security:authorize ifAnyGranted="ROLE_ADMIN,ROLE_APP_STATISTIC">
    <li class="submenu"> <a href="javascript:void(0);"><i class="icon icon-shopping-cart"></i> <span>App Statistic Management</span> <span class="label">3</span></a>
      <ul>
        <li><a href="${pageContext.request.contextPath}/backend/marketappranklist.html"><i class="icon icon-hand-right"></i> <span>App Download Ranking List</span></a></li>
        <li><a href="${pageContext.request.contextPath}/backend/appstatistic.html"><i class="icon icon-hand-right"></i> <span>App Download Times Statistic</span></a></li>
          <li><a href="${pageContext.request.contextPath}/backend/backupappstatistic.html"><i class="icon icon-hand-right"></i> <span>Cloud BackUp Usage Statistic</span></a></li>
      </ul>
    </li>
    </security:authorize>

    <security:authorize ifAnyGranted="ROLE_ADMIN">
    <li class="submenu"> <a href="javascript:void(0);"><i class="icon icon-align-center"></i> <span>System Configuration Management</span>
        <span class="label"><c:if test="${multipHost}">7</c:if><c:if test="${!multipHost}">6</c:if></span></a>
      <ul>
         <li><a href="${pageContext.request.contextPath}/backend/useroverview.html"><i class="icon icon-hand-right"></i> <span>System User Management</span></a></li>
         <li><a href="${pageContext.request.contextPath}/backend/clientoverview.html"><i class="icon icon-hand-right"></i> <span>STB Mac Management</span></a></li>
         <li><a href="${pageContext.request.contextPath}/backend/vipgroupoverview.html"><i class="icon icon-hand-right"></i> <span>VIP Mac Management</span></a></li>
         <li><a href="${pageContext.request.contextPath}/backend/clientversionshow.html?method=load"><i class="icon icon-hand-right"></i> <span>Client APK Version Management</span></a></li>
         <li><a href="${pageContext.request.contextPath}/backend/clientbootimageshow.html?method=load"><i class="icon icon-hand-right"></i> <span>Boot Advertising Management</span></a></li>
          <li><a href="${pageContext.request.contextPath}/backend/apkparsershow.html?method=load" target="_blank"><i class="icon icon-hand-right"></i> <span>APK Help Tool</span></a></li>
          <c:if test="${multipHost}">
              <li><a href="${pageContext.request.contextPath}/backend/hostoverview.html"><i class="icon icon-hand-right"></i> <span>Mutip File Host Management</span></a></li>
          </c:if>
      </ul>
    </li>
    </security:authorize>

  </ul>
</div>