<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="mid" %>
<%@ attribute name="pid" %>

<c:if test="${mid==member_id}">
	<a href="controller.jsp?action=deleteP&post_id=${pid}">[삭제]</a>
</c:if>
&nbsp;&nbsp;<a href="controller.jsp?action=updateP&cnt=${cnt}&post_id=${pid}">♥</a>