<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
</head>
<body>
<!-- memberInfo를 받은 페이지 -->
<h2>회원정보 수정</h2>

<a href="controller.jsp?action=main">[뒤로가기]</a>

<form action="controller.jsp?action=updateM" method="post">
<c:set var="m" value="${memberInfo}"/>
	<input type="hidden" name="member_id" value="${m.member_id }">
	<input type="hidden" name="origin_member_name" value="${m.member_name }">
	<table border="1">
		<tr>
			<td>아이디</td>
			<td><input type="text" name="member_id" value="${m.member_id}" disabled></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="member_pw" value="${m.member_pw}" required></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="member_name" value="${m.member_name}" required></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="email" name="member_email" value="${m.member_email}" required></td>
		</tr>
		<tr>
			<td colspan="2" align="right"><input type="submit" value="회원정보 수정"></td>
		</tr>
	</table>
</form>

</body>
</html>