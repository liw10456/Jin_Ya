<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en"  ng-app="welcomeApp" ng-controller="welcomeCtrl">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />
<!-- <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/css/bootstrap-datepicker.css"/>
 -->
 <link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/a549aa8780dbda16f6cff545aeabc3d71073911e/build/css/bootstrap-datetimepicker.css" />
<c:url value="/css/main.css" var="jstlCss" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
<script src="https://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/a549aa8780dbda16f6cff545aeabc3d71073911e/src/js/bootstrap-datetimepicker.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.4/js/bootstrap-datepicker.js"></script> -->
<script src="js/welcomeController.js"></script>
<link href="${jstlCss}" rel="stylesheet" />
<title>JIN YA | 金雅里</title>
</head>
<body>
	<nav class="navbar"> <!-- navbar-inverse -->
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">
				    <span>JIN YA </span>
				        <img src="images/JinYa.png" width="40%"/>
				</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="history"><a href="#">發現金雅里</a></li>
					<li><a href="#activity">活動主題館</a></li>
					<li><a href="#people">人物專訪</a></li>
					<li><a href="#resource">公務資源</a></li>
					<li><a href="#announcement">里佈告欄</a></li>
					<li><a href="#reservation">常見問題</a></li>
					<li><a href="#reservation"  data-toggle="modal" data-target="#myModal">誰來晚餐</a></li>
					<li>
					    <a>
						    <div id="datePlaceholder">
							    <span>{{date | date:'yyyy'}}</span>
			                    <span>{{date | date:'MM'}}</span>
			                    <span>{{date | date:'dd'}}</span>
		                    </div>
		                    <img ng-src="images/{{weatherSummary}}.png" width="36px"/>
		                    <span id="degree">{{weatherTemp| number:1}}&deg;C</span>
	                    </a>
				    </li>
				</ul>
                <!-- span class="destination">{{weatherSummary}} {{weatherTemp| number:1}}</span-->
				<ul id="login" class="nav navbar-nav pull-right">
					<c:if test="${empty username}">
					    <span><a href="#login"  data-toggle="modal" data-target="#loginModal">Log in</a></span>
						<span> / </span>
						<span><a href="/registeration">Sign Up</a></span>
					</c:if>
					<c:if test="${not empty username}">
					    <span><c:out default="username is empty or null."  value="${username}"/></span>
					    <span><a href="#logout"  data-toggle="modal" data-target="#logoutModal">Logout</a></span>
					</c:if>
				</ul>
			</div>
		</nav>

	<div class="container">
	    <div class="starter-template col-sm-9">照片集
	        <img src="images/cropped_railStation.jpg" width="100%" />
	        <div class="starter-template col-sm-6 col-block">發現金雅里
	            <ul>
		            <c:forEach var="listOuter" items="${profile}"> 
		            	<li><a type="button" ng-click="getNeighboodEventInfo('VILLAGE_INFO',${listOuter.value})">${listOuter.key}</a></li>
					</c:forEach>
	            </ul>
	        </div>
		    <div class="starter-template col-sm-6 col-block">活動主題館
		    	<button ng-click="getNeighboodEventInfo('VILLAGE_ACTIVITY',5)">GET INFO</button>
		        <ul>
		    		<c:forEach var="listOuter" items="${activity}"> 
		            	<li><a type="button" ng-click="getNeighboodEventInfo('VILLAGE_ACTIVITY',${listOuter.value})">${listOuter.key}</a></li>
					</c:forEach>
	            </ul>
	        </div>
		    <div class="starter-template col-sm-6 col-block">人物專訪
		        <ul>
		    		<c:forEach var="listOuter" items="${people}"> 
		            	<li><a type="button" ng-click="getNeighboodEventInfo('VILLAGE_PEOPLE',${listOuter.value})">${listOuter.key}</a></li>
					</c:forEach>
	            </ul>
		    </div>
		    <div class="starter-template col-sm-6 col-block">公務資源
		        <ul>
		    		<c:forEach var="listOuter" items="${publicResource}"> 
		            	<li><a type="button" ng-click="getNeighboodEventInfo('VILLAGE_PUBLIC_RESOURCES',${listOuter.value})">${listOuter.key}</a></li>
					</c:forEach>
	            </ul>
		    </div>
		    <div class="starter-template col-sm-6 col-block">里佈告欄
		        <ul>
		    		<c:forEach var="listOuter" items="${billboard}"> 
		            	<li><a type="button" ng-click="getNeighboodEventInfo('VILLAGE_BROADCAST',${listOuter.value})">${listOuter.key}</a></li>
					</c:forEach>
	            </ul>
		    </div>
		    <div class="starter-template col-sm-6 col-block">常見問題
		        <ul>
		    		<c:forEach var="listOuter" items="${ad}"> 
		            	<li><a type="button" ng-click="getNeighboodEventInfo('VILLAGE_AD',${listOuter.value})">${listOuter.key}</a></li>
					</c:forEach>
	            </ul>
		    </div>
	    </div>
	    <div class="starter-template col-sm-3">本月人物專訪: 韓里長
		    <div class="border col-sm-12"><img src="images/jin_ya_li.jpg" width="100%"/></div>
		    <p style=" text-indent: 50px;text-align:justify">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
	         eiusmod tempor incididunt ut labore et dolore magna aliqua. 
	         Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi 
	         ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in 
	         voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint 
	         occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim 
	         id est laborum <br></br> 
	         Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
	         eiusmod tempor incididunt ut labore et dolore magna aliqua. 
	         Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi 
	         ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in 
	         voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint 
	         occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim 
	         id est laborum   <a>More Info...</a></p>
	         <div>
	         <iframe src="https://teamup.com/ks09175eafc7c69bf8" frameborder="0" width="100%" height="700"></iframe>
	         </div>
	    </div>
	<%@include file="addActivity.jsp" %>
	<%@include file="login.jsp" %>
	<%@include file="logout.jsp" %>
	<%@include file="eventInfo.jsp" %>
	</div>
	
	
</body>

</html>
