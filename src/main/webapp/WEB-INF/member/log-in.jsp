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
	<%@ include file="/WEB-INF/common/footer.jsp"%>
</body>
</html>
