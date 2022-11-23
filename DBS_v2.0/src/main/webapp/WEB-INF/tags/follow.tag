<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="following_id" %>

<!-- 만약 followingList2에 있는 사람이라면 언팔로우 
만약 followerList2에 있는 사람인데 followingList2에 없다면 맞팔로우
만약 followerList2에 있는 사람인데 followingList2에 있다면 팔로우 중 -> 언팔
둘 다 없다면 팔로우 -->

<c:set var="doneLoop" value="false"/>

<c:if test="${member_id != null && member_id != following_id}">
	
	<c:forEach var="f1" items="${followingList2}">
		<c:if test="${following_id == f1 && not doneLoop}">
			<c:set var="doneLoop" value="true"/>
			<a href="controller.jsp?action=deleteF&following_id=${following_id}&member_id=${member_id}">[unFollow]</a>
		</c:if>			
	</c:forEach>

	<c:forEach var="f2" items="${followerList2 }">
		<c:if test="${following_id == f2  && not doneLoop}">			
			<c:forEach var="f3" items="${followingList2 }">			
				<c:if test="${following_id == f3 && not doneLoop}">
					<c:set var="doneLoop" value="true"/>				
				</c:if>								
			</c:forEach>			
			<c:if test="${not doneLoop}">
				<c:set var="doneLoop" value="true"/>	
				<a href="controller.jsp?action=insertF&following_id=${following_id}&member_id=${member_id}">[Follow back]</a>
			</c:if>		
		</c:if>		
	</c:forEach>
	
	<c:if test="${not doneLoop}">
		<c:set var="doneLoop" value="true"/>
		<a href="controller.jsp?action=insertF&following_id=${following_id}&member_id=${member_id}">[Follow]</a>
	</c:if>	

</c:if>
