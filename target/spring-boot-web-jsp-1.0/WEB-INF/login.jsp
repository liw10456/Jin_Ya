<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml"
	xmlns:th="http://www.thymeleaf.org">
<head>
	<title>Spring Security Tutorial</title>
	<link rel="stylesheet" type="text/css" th:href="@{/css/login.css}" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<div class="modal fade" id="loginModal" role="dialog" onload='document.f.username.focus();'>
		<div class="modal-dialog">
	          <div class="modal-content">
	        <div class="modal-header">
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	          <h4 class="modal-title">Custom Login with Username and Password</h4>
	        </div>
	       <div class="modal-body">
				<form name='f' action='<spring:url value="/login"/>' method='POST'>
				<table>
				    <tr><td>User:</td><td><input type='text' name='username' value=''></td></tr>
				    <tr><td>Password:</td><td><input type='password' name='password'/></td></tr>
				    <tr><td colspan='2'><input name="submit" type="submit" value="Login"/></td></tr>
				</table>
				</form>
	       </div>
	       
	       <div class="modal-footer">
	           <button type="button" class="btn btn-default" name="submit" type="submit" value="Login">登入</button>
	           <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	       </div>
	     </div>
	  </div>
	
</div>
</html>