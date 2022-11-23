<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로우 관리</title>
</head>
<body>
<!-- memberInfo를 받은 페이지 -->
<h2>팔로우 목록</h2>

	<a href="controller.jsp?action=main">메인 화면으로</a>

	<table border="1">
		<th>FollowerList</th>		
		<tr>
			<c:forEach var="f1" items="${followerList}">
				<td style="bgcolor:lightblue">${f1}</td>
			</c:forEach>
		</tr>	
	</table>
	
	<table border="1">
	<th>FollowingList</th>
		<tr>
			<c:forEach var="f2" items="${followingList}">
				<td style="bgcolor:lightgreen">${f2}</td>
			</c:forEach>			
		</tr>
	</table>
	
</body>
</html>