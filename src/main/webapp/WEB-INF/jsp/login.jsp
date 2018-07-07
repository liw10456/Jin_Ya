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

<div class="modal fade" id="loginModal" role="dialog" onload='document.f.username.focus();'>
		<div class="modal-dialog">
	          <div class="modal-content">
	        <div class="modal-header">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4 class="modal-title">登入</h4>
	        </div>
	       <div class="modal-body">
				<form name='f' action='<spring:url value="/login"/>' method='POST'>
				    <span>姓名: </span>
				    <span><input type='text' name='username' value=''/></span>
				    </br>
				    <span>密碼: </span>
				    <span><input type='password' name='password'/></span>
				    
				    <div class="modal-footer">
				        <button type="button" class="btn btn-default" type="submit" value="login">登入</button>
				    	<button type="button" class="btn btn-default" type="submit" value="logout" data-dismiss="modal">取消</button>
				    </div>
				</form>
	       </div>
	       
	       
	     </div>
	  </div>
	
</div>
</html>