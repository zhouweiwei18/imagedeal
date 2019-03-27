<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="${pageContext.request.contextPath }/user/userRegister.action">

		用户名：<input name="username" type="text"> 
		密码：<input name="password" type="text"> 
		手机：<input name="phonenumber" type="text"> 
		qq:<input name="qq" type="text"> 
		email:<input name="email" type="text"> 
		contacts:<input name="contacts" type="text"> 
		sex：<input name="sex" type="text">
		facecode：<input name="facecode" type="text"> 
		image:<input name="image" type="text"> 
		<input type="submit" value="提交">

	</form>

</body>
</html>