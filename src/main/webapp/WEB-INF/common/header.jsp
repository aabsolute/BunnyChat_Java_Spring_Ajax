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
	<link rel="stylesheet"
		href="/resources/css/custom.css">
	<link rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<link rel="stylesheet"
		href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
	<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">

	
	
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
					href="${pageContext.request.contextPath}/">Main</a></li>
			</ul>
			<ul class="nav navbar-nav">
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/chat/main">ChatingRoom</a></li>
			</ul>
			<ul class="nav navbar-nav">
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/board/">BoardRoom</a></li>
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

	<div class="alert alert-success" id="successMessage" style="display: none;">
		<strong><spring:message code="label.chat.message.send.success" /></strong>
	</div>
	<div class="alert alert-danger" id="dangerMessage" style="display: none;">
		<strong><spring:message code="label.chat.message.send.danger" /></strong>
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display: none;">
		<strong><spring:message code="label.chat.message.send.warning" /></strong>
	</div>

	<c:if test="${messageContent ne null}">
		<div class="modal fade" id="messageModal" tabindex="-1" role="dialog"
			aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-align-center">
					<c:choose>
						<c:when test="${messageType eq 'errorMessage'}">
							<div class="modal-content panel-warning">
								<div class="modal-header panel-heading">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times</span> <span class="sr-only">Close</span>
									</button>
									<h4 class="modal-title">
										<c:out value="${messageType}" />
									</h4>
								</div>
								<div class="modal-body">
									<c:out value="${messageContent}" />
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary"
										data-dismiss="modal">
										<spring:message code="label.member.yes" />
									</button>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="modal-content panel-success">
								<button type="button" class="close" data-dismiss="modal">
									<span aria-hidden="true">&times</span> <span class="sr-only">Close</span>
								</button>
								<h4 class="modal-title">
									<c:out value="${messageType}" />
								</h4>
							</div>
							<div class="modal-body">
								<c:out value="${messageContent}" />
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary"
									data-dismiss="modal">
									<spring:message code="label.member.yes" />
								</button>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</c:if>

	<script type="text/javascript">
        $('#messageModal').modal("show");
    </script>
	<c:remove var="messageContent" scope="session" />
	<c:remove var="messageType" scope="session" />

	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div id="checkType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span> <span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							ok message
						</h4>
					</div>
					<div id="checkMessage" class="modal-body">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">
							<spring:message code="label.member.yes" />
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
