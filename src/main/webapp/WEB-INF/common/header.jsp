<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CDN Setting -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
	integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p"
	crossorigin="anonymous" />
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<c:choose>
	<c:when test="${lang ne null and lang eq 'jp'}">
		<link rel="stylesheet" href="/resources/css/custom_jp.css">
	</c:when>
	<c:when test="${lang ne null and lang eq 'ko'}">
		<link rel="stylesheet" href="/resources/css/custom_kr.css">
	</c:when>
	<c:otherwise>
		<link rel="stylesheet" href="/resources/css/custom.css">
	</c:otherwise>
</c:choose>

<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- Bootstrap CDN Setting -->

<!-- session alarm -->
<script>
	/* $(document).ready(function(){
	    var check = "세션에 등록된값";
	    if(check == ''){
	        alert("로그인 후 이용하세요.");
	        location.href="${path}/";
	    }   
	     
	}); */
</script>
<!-- session alarm -->
<title>BunnyChat</title>
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${pageContext.request.contextPath}/">LiveBunnyChat</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/"><spring:message
							code="label.menu.main" /></a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/chat/main"><spring:message
							code="label.menu.chatroom" /></a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/chat/findFriend"><spring:message
							code="label.menu.searchfriend" /></a></li>
				<li class="nav-item">
				<a href="#"
					onclick="javascript:goMessageBox('<c:out value="${pageContext.request.contextPath}" />/chat/messageBox');"><spring:message
							code="label.menu.messagebox" /><span id="unread"
						class="label label-info"></span> </a></li>


				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/board/">BoardRoom</a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/language_kr?lang=ko">korean</a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/language_jp?lang=jp">japan</a></li>
			</ul>
			<c:choose>
				<c:when test="${sessionScope.login.userId eq null}">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false"><spring:message
									code="label.member.title.connect" /><span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a
									href="${pageContext.request.contextPath}/member/login"><spring:message
											code="label.member.title.login" /></a></li>
								<li><a
									href="${pageContext.request.contextPath}/member/regist"><spring:message
											code="label.member.title.regist" /></a></li>
							</ul></li>
					</ul>
				</c:when>
				<c:otherwise>
					<ul class="nav navbar-nav navbar-right">
						<li class="nav-item"><a href="#"><c:out value="${sessionScope.login.userId}"/><spring:message
											code="label.member.login.hello" /></a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false"><spring:message
									code="label.member.title.connect" /><span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a
									href="${pageContext.request.contextPath}/member/management"><spring:message
											code="label.member.title.management" /></a></li>
								<li><a
									href="${pageContext.request.contextPath}/member/logout"><spring:message
											code="label.member.logout" /></a></li>
							</ul></li>
					</ul>
				</c:otherwise>
			</c:choose>
		</div>
	</nav>
	<script type="text/javascript">
		function goMessageBox(url) {
			var userId = '<c:out value="${sessionScope.login.userId}"/>';
			var form = document.createElement("form");
	        var input = new Array();
	        form.action = url;
	        form.method = 'post';
	        input[0] = document.createElement('input');
	        input[0].setAttribute('type', 'hidden');
	        input[0].setAttribute('name', 'userId');
	        input[0].setAttribute('value', userId);
	        form.appendChild(input[0]);
	        /*
	        for (var i = 0; i < parm.length; i++) {
	            input[i] = document.createElement("input");
	            input[i].setAttribute("type", "hidden");
	            input[i].setAttribute('name', parm[i][0]);
	            input[i].setAttribute("value", parm[i][1]);
	            form.appendChild(input[i]);
	        }
	        */
	        document.body.appendChild(form);
	        form.submit();
		};

		function getUnread() {
			var userId = '<c:out value="${sessionScope.login.userId}"/>';
			$.ajax({
				type : 'post',
				url : '/chat/getUnread',
				data : {
					'userId' : encodeURIComponent(userId)
				},
				success : function(result) {
					if (result >= 1) {
						showUnread(result);
					} else {
						showUnread('');
					}
				}
			});
		}

		function getInfiniteUnread() {
			setInterval(function() {
				getUnread();
			}, 5000);
		}

		function showUnread(result) {
			$('#unread').html(result);
		}
	</script>

	<c:if test="${not empty sessionScope.login.userId}">
		<script type="text/javascript">
			$(document).ready(function() {
				getInfiniteUnread();
			})
		</script>
	</c:if>

</body>
</html>
