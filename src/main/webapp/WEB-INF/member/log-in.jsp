<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/regist.css">
<%@ include file="/WEB-INF/common/header.jsp"%>
</head>
<body>

	<div class="container">
		<form method="post" action = "/member/login">
			<%-- action="${pageContext.request.contextPath}/el" --%>
			<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>
								<spring:message code="label.member.login.title" />
							</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 120px"><h5>
								<spring:message code="label.member.login.id" />
							</h5></td>
						<td><input class="form-control" type="text" id="userId"
							name="userId" maxlength="20"
							placeholder="<spring:message code="label.member.login.insert.id" />"></td>
					</tr>
					<tr>
						<td style="width: 120px"><h5>
								<spring:message code="label.member.login.password" />
							</h5></td>
						<td colspan="2"><input onkeyup="fn_passwordChk();"
							class="form-control" type="password" id="userPassword"
							name="userPassword" maxlength="20"
							placeholder="<spring:message code="label.member.login.insertpassword" />"></td>
					</tr>
					<tr>
						<td>
							<input class="btn btn-primary pull-right" type="submit" value="<spring:message code="label.member.login.login" />">					
						</td>
					</tr>
				</tbody>
			</table>
		</form>
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
							ok message is
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
