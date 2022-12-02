<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
    <head>
        <!-- Meta -->
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">

        <title>Edit Profile</title>
        <meta name="description" content="">

        <!-- The compiled CSS file -->
        <link rel="stylesheet" href="css/production.css">

        <!-- Web fonts -->
        <link href="https://fonts.googleapis.com/css?family=Cabin:400,700|Playfair+Display:900" rel="stylesheet">

        <!-- favicon.ico. Place these in the root directory. -->
        <link rel="shortcut icon" href="favicon.ico">
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
                            <div class="mb0"><img class="logo--mobile" src="img/mobile-logo.svg" alt="Viking Tours" title="Viking Tours"></div>
                        </div>
                        <div class="grid-column span-half align--right">
                            <!-- Mobile social links -->
                            <ul class="mobile-social-links list--inline">
                                <li class="mr1"><a class="link link--default" href="https://www.twitter.com"><img class="icon" src="img/facebook.svg" alt="Facebook"></a></li>
                                <li class="mr1"><a class="link link--default" href="https://www.instagram.com"><img class="icon" src="img/instagram.svg" alt="Instagram"></a></li>
                                <li><a class="link link--default" href="https://www.facebook.com"><img class="icon" src="img/twitter.svg" alt="Twitter"></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Desktop header -->
            <!-- Desktop logo -->
            <h1 class="hide-on-mobile logo-container absolute block full-width align--center"><img class="logo--desktop" src="img/desktop-logo.svg" alt="Viking Tours" title="Viking Tours"></h1>
            <!-- Social links -->
            <ul class="pt1 no-bullets align--center hide-on-mobile">
                <li><a class="link link--default" href="https://www.twitter.com"><img class="icon" src="img/facebook.svg" alt="Facebook"></a></li>
                <li><a class="link link--default" href="https://www.instagram.com"><img class="icon" src="img/instagram.svg" alt="Instagram"></a></li>
                <li><a class="link link--default" href="https://www.facebook.com"><img class="icon" src="img/twitter.svg" alt="Twitter"></a></li>
            </ul>

        </header>
        
        <!-- Hero image -->
        <div class="hero-container full-width show-on-mobile pt1 pl2 pr2">
            <div class="hero full-width full-height" style="background:rgba(0,0,0,0) url(img/4.jpg) no-repeat scroll center center/cover"></div>
        </div>
        <div class="hide-on-mobile hero" style="background:rgba(0,0,0,0) url(img/4.jpg) no-repeat scroll center center/cover"></div>

        <!-- Body -->
        <div class="body full-width pt1 pr2 pb2 pl2">
            <!-- Navigation -->
            <nav class="navigation border--bottom pt1">
            <h3 style="float: right">Welcome ${member_name}!</h3>
                <ul class="no-bullets list--inline pb1 bold">					
						<li class="small mr2"><a class="link link--text" href="controller.jsp?action=main">Home</a></li>
						<li class="small mr2"><a class="link link--text" href="controller.jsp?action=selectF&member_id=${member_id }">Follow List</a></li>
						<li class="small mr2"><a class="link link--text" href="controller.jsp?action=logout">Sign Out</a></li>
				</ul>           
				 </nav>
            <!-- Page Content -->
            <main class="content pt2 pb2">
                <h2>Edit Profile</h2>
                <p>Edit your profile!</p>
                <form action="controller.jsp?action=updateM" method="post" class="form">
                <c:set var="m" value="${memberInfo}"/>
	<input type="hidden" name="member_id" value="${m.member_id }">
	<input type="hidden" name="origin_member_name" value="${m.member_name }">
                    <label class="label" for="name">ID</label>
                    <input class="form-control mb1" type="text" name="member_id" value="${m.member_id}" disabled>
                    <label class="label" for="email">Password</label>
                    <input class="form-control mb1" type="password" name="member_pw" value="${m.member_pw}" required>
                    <label class="label" for="phone">Nickname</label>
                    <input class="form-control mb1" type="text" name="member_name" value="${m.member_name}" required>
                    <label class="label" for="message" >Email</label>
                    <input class="form-control mb1" type="email" name="member_email" value="${m.member_email}" required>
                    <div class="clearfix">
                        <input class="btn btn--default float--right" value="Edit" type="submit">
                    </div>
                </form>                          
            </main>
                        <!-- Footer -->
            <footer class="border--top pt1 pb1">
                <p class="text--gray small mb0">&copy; Copyright Viking Tours | Design by <a href="https://www.eatapapaya.com" class="link link--text">Papaya</a>.</p>
            </footer>
        </div><!-- end Body -->

    </div>

    </body>
</html>

