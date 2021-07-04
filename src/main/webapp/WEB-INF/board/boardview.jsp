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
		<table class="table table-bordered table-hover" style="text-align:center; border:1px solid #dddddd;">
			<thead>
				<tr>
					<th colspan="5"><h4><spring:message code="label.bunny.board.main.title" /></h4></th>
				</tr>
				<tr>
					<th style="background-color: #fafafa; color: #000000; width: 70px;"><spring:message code="label.bunny.board.number" /></th>
					<th style="background-color: #fafafa; color: #000000;"><spring:message code="label.bunny.board.title" /></th>
					<th style="background-color: #fafafa; color: #000000;"><spring:message code="label.bunny.board.writer" /></th>
					<th style="background-color: #fafafa; color: #000000; width: 100px;"><spring:message code="label.bunny.board.write.date" /></th>
					<th style="background-color: #fafafa; color: #000000; width: 70px;"><spring:message code="label.bunny.board.hit" /></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${boardList}"  varStatus="status">
					<tr>
					<th style="background-color: #fafafa; color: #000000; width: 70px;" value="${item.boardId}"></th>
					<th style="background-color: #fafafa; color: #000000;" value="${item.boardTitle}"></th>
					<th style="background-color: #fafafa; color: #000000;" value="${item.userId}"></th>
					<th style="background-color: #fafafa; color: #000000; width: 100px;" value="${item.boardDate}"></th>
					<th style="background-color: #fafafa; color: #000000; width: 70px;" value="${item.boardHit}"></th>
					</tr>
				</c:forEach>
					<tr>
						<td colspan="5">
						<a class="btn btn-primary pull-right" type="submit" href="${pageContext.request.contextPath}/chat/write">
							<spring:message code="label.bunny.board.regist.write" />
						</a>
						</td>
					</tr>
			</tbody>
		</table>
	</div>
	<%@ include file="/WEB-INF/common/footer.jsp"%>
</body>
</html>
