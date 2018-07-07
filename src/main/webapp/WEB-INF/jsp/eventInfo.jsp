<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:th="http://www.thymeleaf.org">
<head>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<div class="modal fade" id="eventInfoModal" role="dialog" onload='document.f.username.focus();'>
		<div class="modal-dialog">
	          <div class="modal-content">
	        <div class="modal-header">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4 class="modal-title">Event Info</h4>
	        </div>
	       <div class="modal-body">
				<p>{{eventInfo.description}}</p>
				<p>{{eventInfo.creator}}</p>
				<p>{{eventInfo.createdTime}}</p>
				<p>{{eventInfo.title}}</p>
	       </div>
	       
	       <div class="modal-footer">
	           <button type="button" class="btn btn-default" name="submit" type="submit" value="Login">登入</button>
	           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	       </div>
	     </div>
	  </div>
	
</div>
</html>