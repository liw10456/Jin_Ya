<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />
	<c:url value="/css/main.css" var="jstlCss" />
	<script src="js/welcomeController.js"></script>
	<link href="${jstlCss}" rel="stylesheet" />
	<title>JIN YA | 金雅里</title>
</head>
	  <div class="modal fade" id="myModal" role="dialog">
	      <div class="modal-dialog">
	          <div class="modal-content">
	        <div class="modal-header">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4 class="modal-title">預約場地</h4>
	        </div>
	       <div class="modal-body">
	         <h5>選擇場地</h5>
	         <input ng-model="activity.location" class="form-control" placeholder="場地" required />
	       </div>
	       <div class="modal-body">
	         <h5>活動開始日期</h5>
	         <div class="input-group date" id="datetimepicker1">
			    <input type="text" id="startTime" data-date-format="DD-MM-YYYY HH:mm:ss zzz" class="form-control datepicker" ng-model="activity.startTime" required/>
			    <div class="input-group-addon">
			        <span class="glyphicon glyphicon-th"></span>
			    </div>
			 </div>
	       </div>
	       <div class="modal-body">
	         <h5>活動結束日期</h5>
	         <div class="input-group date" id="datetimepicker2">
			    <input type="text" id="endTime" data-date-format="DD-MM-YYYY HH:mm:ss zzz" class="form-control datepicker" ng-model="activity.endTime" required/>
			    <div class="input-group-addon">
			        <span class="glyphicon glyphicon-th"></span>
			    </div>
			 </div>
	       </div>
	       <div class="modal-body">
	         <h5>主題簡述</h5>
	         <input ng-model="activity.topic" class="form-control" placeholder="ex:國標舞課程" required />
	       </div>
	       <div class="modal-body">
	         <h5>活動詳述</h5>
	         <input ng-model="activity.description" class="form-control" />
	       </div>
	       <div class="modal-body">
	         <h5>代表人姓名</h5>
	         <input ng-model="activity.hostName" class="form-control" id="inputEmail3" placeholder="請填入全名" required />
	       </div>
	       <div class="modal-body">
	         <h5>代表人聯絡方式</h5>
	         <input ng-model="activity.contactType" class="form-control" id="inputEmail3" placeholder="contact type" required />
	       </div>
	       <div class="modal-body">
	         <h5>預估人數</h5>
	         <input ng-model="activity.amount" class="form-control" id="inputEmail3" placeholder="請填入預計實到人數" required />
	       </div>
	       <div class="modal-footer">
	           <button type="button" class="btn btn-default" ng-click="createActivity(activity)" data-dismiss="modal">預約</button>
	           <button type="button" class="btn btn-default" data-dismiss="modal" ng-click="reset()">取消</button>
	       </div>
	     </div>
	  </div>
	</div>
</html>