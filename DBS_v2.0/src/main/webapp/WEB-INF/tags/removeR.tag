<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="mid" %>
<%@ attribute name="cid" %>

<c:if test="${mid==member_id}">
	<a href="controller.jsp?action=deleteC&cnt=${cnt}&comment_id=${cid}">[삭제]</a>
</c:if>