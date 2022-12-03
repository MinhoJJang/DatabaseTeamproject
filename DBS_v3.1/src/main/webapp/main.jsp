<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="mytag"%>

<!DOCTYPE html>

<html>

<head>

<!-- Meta -->
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">

<title>nstagram</title>
<meta name="description" content="">

<!-- The compiled CSS file -->
<link rel="stylesheet" href="css/production.css">

<!-- Web fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Cabin:400,700|Playfair+Display:900"
	rel="stylesheet">

<!-- favicon.ico. Place these in the root directory. -->
<link rel="shortcut icon" href="favicon.ico">

<script type="text/javascript">

	
	function str(){
		let str = ["Hi! :)" , "What's up?", "How are you today?", "Long time no see...", "Good to see you!", "Nice to meet you!", "Did something happen?", "Isn't it too cold today?"]
		let pick = Math.floor(Math.random()*str.length);
		document.write(str[pick])
	}
</script>
</head>

<body>


	<div class="grid-row">

		<!-- Header -->
		<header class="header full-width">

			<!-- Mobile header -->
			<div class="show-on-mobile pt1 pl2 pr2 mb1">
				<div class="border--bottom pt1">
					<div class="grid-row grid-row--center pb1">
						<div class="grid-column span-half">
							<!-- Mobile logo -->
							<div class="mb0">
							<!-- TODO: src 변경해서 로고 바꾸기 -->
								<img class="logo--mobile" src="img/mobile-logo.svg"
									alt="Viking Tours" title="Viking Tours">
							</div>
						</div>
						<div class="grid-column span-half align--right">
							<!-- Mobile social links -->
							<ul class="mobile-social-links list--inline">
								<li class="mr1"><a class="link link--default"
									href="https://www.twitter.com"><img class="icon"
										src="img/facebook.svg" alt="Facebook"></a></li>
								<li class="mr1"><a class="link link--default"
									href="https://www.instagram.com"><img class="icon"
										src="img/instagram.svg" alt="Instagram"></a></li>
								<li><a class="link link--default"
									href="https://www.facebook.com"><img class="icon"
										src="img/twitter.svg" alt="Twitter"></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<!-- Desktop header -->
			<!-- Desktop logo -->
			<h1
				class="hide-on-mobile logo-container absolute block full-width align--center">
				<img class="logo--desktop" src="img/desktop-logo.svg"
					alt="Viking Tours" title="nstagram">
			</h1>
			<!-- Social links -->
			<ul class="pt1 no-bullets align--center hide-on-mobile">
				<li><a class="link link--default"
					href="https://www.twitter.com"><img class="icon"
						src="img/facebook.svg" alt="Facebook"></a></li>
				<li><a class="link link--default"
					href="https://www.instagram.com"><img class="icon"
						src="img/instagram.svg" alt="Instagram"></a></li>
				<li><a class="link link--default"
					href="https://www.facebook.com"><img class="icon"
						src="img/twitter.svg" alt="Twitter"></a></li>
			</ul>

		</header>

		<!-- Hero image -->
		<div class="hero-container full-width show-on-mobile pt1 pl2 pr2">
			
			<!-- TODO 메인 화면 사진 url 변경하기 -->
			<div class="hero full-width full-height"
				style="background: rgba(0, 0, 0, 0) url(img/1.jpg) no-repeat scroll center center/cover"></div>
		</div>
		
		
		<div class="hide-on-mobile hero"
			style="background: rgba(0, 0, 0, 0) url(img/1.jpg) no-repeat scroll center center/cover"></div>

		<!-- Body -->
		<div class="body full-width pt1 pr2 pb2 pl2">
			<!-- Navigation -->
			<nav class="navigation border--bottom pt1">
				<ul class="no-bullets list--inline pb1 bold">		
					<c:if test="${member_id == null}">
						<li class="small mr2"><a class="link link--text " href="login.jsp">Sign In</a></li>
						<li class="small mr2"><a class="link link--text " href="signup.jsp">Create Account</a></li>		
					</c:if>

					<c:if test="${member_id != null}">
						<h3 style="float: right">Welcome ${member_name}!</h3>
						<li class="small mr2"><a class="link link--text" href="controller.jsp?action=selectM&member_id=${member_id }">Edit Profile</a></li>
						<li class="small mr2"><a class="link link--text" href="controller.jsp?action=selectF&member_id=${member_id }">Follow List</a></li>
						<li class="small mr2"><a class="link link--text" href="controller.jsp?action=logout">Sign Out</a></li>
					</c:if>
					<li class="small mr2"><a class="link link--text" href="controller.jsp?action=main&cnt=${cnt+3}">[show more]</a></li>
				</ul>
			</nav>
			<!-- Page Content -->
			<main class="content pt2 pb2">
				
				
				<c:choose>
					<c:when test="${member_id == null}">
						<!-- <p>로그인 이후에 글쓰기가 가능합니다!</p>
							<br> -->
						<h2>Welcome To Nstagram!</h2>
					</c:when>
					<c:otherwise>
						<h2><script>str()</script></h2>
						<form action="controller.jsp?action=insertP" method="post">
							<input type ="hidden" name="member_id" value="${member_id }"> 
							<input type="hidden" name="member_name" value="${member_name }">				
							<input size=10 class="form-control mb1 float--left" type="text" name="post" placeholder="Please Write" required> 
							<input style="float: right" class="btn btn--default" type="submit" value="Writing">													
						</form>		
						<br>			
					</c:otherwise>	
							
				</c:choose>
				<br>
				<hr>
				<br>
				
					
				<c:forEach var="v" items="${datas}">

					<c:set var="pvo" value="${v.post}" />
					
			<strong>${pvo.member_name}'s writing: ${pvo.post} [Likes: ${pvo.likes} | Comments: ${pvo.comment_count} | ${pvo.post_date}] <mytag:follow following_id="${pvo.member_id }" />
					<mytag:removeB mid="${pvo.member_id}" pid="${pvo.post_id}" /></strong>
					<c:choose>
						<c:when test="${member_id == null}">
							<!-- <p>로그인 이후에 댓글쓰기 가능합니다!</p> -->
							<!-- class="form-control mb1 float--left" -->
							<input class="form-control mb1" placeholder="Please sign in before write" disabled>						
						</c:when>			
						<c:otherwise>
							
							<form action="controller.jsp?action=insertC&cnt=${cnt }"
								method="post">
																
								<input  type="hidden" name="member_id" value="${member_id }"> 
								<input  type="hidden" name="post_id" value="${pvo.post_id }"> 							
								<input type="hidden" name="member_name" 	value="${member_name }"> 									
								<input size=10 class="form-control mb1 float--left" type="text" name="comment" placeholder="Please Write Comment"required>								 
								<input class="btn btn--default float--right" type="submit" value="Comment">									
								<br>
								<br>
							</form>
							
							
						</c:otherwise>			
					</c:choose>
					
					<c:forEach var="vv" items="${v.cdatas}">
						<p>&nbsp;&nbsp;&nbsp;${vv.member_name}'s comment: ${vv.comment} [${vv.comment_date}] <mytag:follow following_id="${vv.member_id }" />  <mytag:removeR mid="${vv.member_id}" cid="${vv.comment_id}" /></p>
					</c:forEach>
				
					<hr>
						<br>
				</c:forEach>
			</main>
			<!-- Footer -->
			<footer class="border--top pt1 pb1">
				<p class="text--gray small mb0">
					&copy; Copyright Viking Tours | Design by <a
						href="https://www.eatapapaya.com" class="link link--text">Papaya</a>.
				</p>
			</footer>
		</div>
		<!-- end Body -->

	</div>

</body>
</html>

