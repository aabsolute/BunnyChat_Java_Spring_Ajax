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
		<form method="post" modelAttribute="boardDTO" action="${pageContext.request.contextPath}/board/update" method="POST" >
			<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>
								<spring:message code="label.member.board.write.title" />
							</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px"><h5>
								<spring:message code="label.member.board.write.userid" />
							</h5></td>
						<td><input class="form-control" type="text" id="userId"
							name="userId" value="${board.userId}" readonly="true">
						</td>
					</tr>
					<tr>
						<td style="width: 110px"><h5>
								<spring:message code="label.member.board.write.title" />
							</h5></td>
						<td><input class="form-control" type="text" name="boardTitle" value="${board.boardTitle}">
						</td>
					</tr>
					<tr>
						<td style="width: 110px"><h5>
								<spring:message code="label.member.board.write.content" />
							</h5></td>
						<td>
							<textarea class="form-control" name="boardContent" rows="10" maxlength="2048" value="${board.boardContent}"></textarea>
						</td>
					</tr>
					<tr>

					</tr>
					<tr>
						<td style="text-align: left;" colspan="3"><h5
								style="color: red;"></h5>
							<input class="btn btn-primary pull-right" type="submit"
							value="<spring:message code="label.member.board.readview.update" />">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	
	<%@ include file="/WEB-INF/common/footer.jsp"%>
	<input type="hidden" name="boardDate" value="${board.boardDate}">
	<input type="hidden" name="boardDate" value="${board.boardDate}">
	<input type="hidden" name="boardHit" value="${board.boardHit}">
	<input type="hidden" name="boardGroup" value="${board.boardGroup}">
	<input type="hidden" name="boardSequence" value="${board.boardSequence}">
	<input type="hidden" name="boardLevel" value="${board.boardLevel}">
</body>
</html>
