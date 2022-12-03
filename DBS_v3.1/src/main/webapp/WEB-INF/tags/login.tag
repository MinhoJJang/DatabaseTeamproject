<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form method="post" action="controller.jsp">
	<c:choose>
		<c:when test="${member_id == null}">
			<input class="form-control mb1"  type="hidden" name="action" value="login">
			ID: <input class="form-control mb1" type="text" name="member_id" required>
			PW: <input class="form-control mb1" type="password" name="member_pw" required>
			<input class="btn btn--default float--right" type="submit" value="login">
		</c:when>
		
		<c:otherwise>
			<input class="form-control mb1" type="hidden" name="action" value="logout">
			Welcome ${member_name}!
			<input class="btn btn--default float--right" type="submit" value="logout">
		</c:otherwise>
	</c:choose>
</form>
