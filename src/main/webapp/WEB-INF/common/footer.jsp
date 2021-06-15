<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>BunnyChat</title>
</head>
<body>
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
