<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="mid" %>
<%@ attribute name="pid" %>

<c:if test="${mid==member_id}">
	<a href="controller.jsp?action=deleteP&post_id=${pid}">[Delete]</a>
</c:if>

<c:if test="${member_id != null && member_id != mid}">
&nbsp;&nbsp;<a href="controller.jsp?action=updateP&cnt=${cnt}&post_id=${pid}">♥</a>
</c:if>