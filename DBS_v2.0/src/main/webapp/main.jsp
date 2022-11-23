<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="mytag" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Instagram Project</title>
<style type="text/css">
a {
	color: black;
	text-decoration: none;
}
a:hover {
	color: red;
}

.a {
	background-color: lightblue;
}
.b {
	background-color: lightgray;
}
</style>
<script type="text/javascript">
	function newMember(){
		window.open('new.jsp', '새창으로 회원가입', 'width=500, height=300, menubar=no, status=no, toolbar=no');
	}
</script>
</head>
<body>

<h1>Instagram Term Project by E1I3</h1>

<ul>
<c:if test="${member_id == null}">
	<li><a href="javascript:newMember()">회원가입</a></li>
</c:if>
	<li><mytag:login /></li>
	
	<c:if test="${member_id != null}">
	<li><a href="controller.jsp?action=selectM&member_id=${member_id }">회원정보 수정</a></li>
	<li><a href="controller.jsp?action=selectF&member_id=${member_id }">팔로우 목록 보기</a></li>
	</c:if>
	<li><a href="controller.jsp?action=main&cnt=${cnt+10}">[더보기]</a></li>
</ul>

<!-- 로그인을 했는지 안했는지 판단 후 글쓰기 가능하도록 만든다. 즉, member_id값을 가져왔는데 null이면 글쓰기 불가  -->
<hr>
<div class="a">
<c:choose>
<c:when test="${member_id == null}">
	로그인 이후에 글쓰기가 가능합니다!
</c:when>
<c:otherwise>
<form action="controller.jsp?action=insertP" method ="post">
	<input type="hidden" name="member_id" value="${member_id }">
	<input type="hidden" name="member_name" value="${member_name }">
	<input type ="text" name="post" placeholder="글을 작성하세요" required>
	<input type="submit" value="글 등록">
</form>
</c:otherwise>
</c:choose>
<hr>
</div>

<!-- forEach = 그냥 for문. 모든 datas을 iterate 과정을 거쳐 가져온다 -->
<c:forEach var="v" items="${datas}">
	<div class="a">
	
		<c:set var="pvo" value="${v.post}" />
		${pvo.member_name}님의 글: ${pvo.post} [좋아요: ${pvo.likes} | 댓글수: ${pvo.comment_count} | ${pvo.post_date}] <mytag:follow following_id="${pvo.member_id }"/> <mytag:removeB mid="${pvo.member_id}" pid="${pvo.post_id}"/>
		
		
		<div class="b">
		
			<c:forEach var="vv" items="${v.cdatas}">
				${vv.member_name}님의 댓글: ${vv.comment}   [${vv.comment_date}] <mytag:follow following_id="${vv.member_id }"/>  <mytag:removeR mid="${vv.member_id}" cid="${vv.comment_id}"/> <br>
			</c:forEach>
			
			<c:choose>
<c:when test="${member_id == null}">
	로그인 이후에 댓글쓰기 가능합니다!
</c:when>
<c:otherwise>
<form action="controller.jsp?action=insertC&cnt=${cnt }" method="post">
				<input type="hidden" name="member_id" value="${member_id }">
				<input type="hidden" name="post_id" value="${pvo.post_id }">
				<input type="hidden" name="member_name" value="${member_name }">
				<input type="text" name="comment" placeholder="댓글을 작성하세요">
				<input type="submit" value="댓글달기">			
			</form>
</c:otherwise>
</c:choose>
			
			
		
		</div>
	</div>
	<br>
</c:forEach>


</body>
</html>