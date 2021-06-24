<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/common/header.jsp"%>
<meta charset="UTF-8">
</head>
<body>
	<div class="container">
		<table class="table table-bordered table-hover"
			style="text-align: center; border: 1px solid #dddddd;">
			<thead>
				<tr>
					<td colspan="2"><h4>
							<spring:message code="label.friend.search.keyword" />
						</h4></td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 110px;"><h5>
							<spring:message code="label.friend.search.userId" />
						</h5></td>
					<td><input class="form-control" type="text" id="findId"
						maxlength="64"
						placeholder="<spring:message code="label.friend.search.userId.insert" />"></td>
				</tr>
				<tr>
					<td colspan="2"><button class="btn btn-primary pull-right"
							onclick="findFunction();">
							<spring:message code="label.friend.search.userId.searching" />
						</button></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="container">
		<table id="friendResult" class="table table-bordered table-hover"
			style="text-align: center; border: 1px solid #dddddd;">
		</table>
	</div>

	<script type="text/javascript">
		function findFunction() {
			var userId = $('#findId').val();
			$
					.ajax({
						type : 'post',
						url : '/member/memberCheck',
						data : {
							'userId' : userId
						},
						success : function(result) {
							if (result > 0) {
								$('#checkMessage')
										.html(
												'<spring:message code="label.friend.search.userId.success" />');
								$('#checkType').attr('class',
										'modal-content panel-success');
								getFriend(userId);
							} else if (result == -1) {
								$('#checkMessage')
										.html(
												'<spring:message code="label.friend.search.userId.notme" />');
								$('#checkType').attr('class',
										'modal-content panel-warning');
								failFriend();
							} else {
								$('#checkMessage')
										.html(
												'<spring:message code="label.friend.search.userId.fail" />');
								$('#checkType').attr('class',
										'modal-content panel-warning');
								failFriend();
							}
							$('#checkModal').modal("show");
						}
					});
		}
		function getFriend(findId) {
			$('#friendResult')
					.html(
							'<thead>'
									+ '<tr>'
									+ '<th><h4><spring:message code="label.friend.search.userId.success.result" /></h4></th>'
									+ '</thead>'
									+ '<tbody>'
									+ '<tr>'
									+ '<td style="text-align: center;"><h3>'
									+ findId
									+ '</h3><a href="${pageContext.request.contextPath}/chat/main?toId='
									+ findId
									+ '" class="btn btn-primary pull-right" >'
									+ '<spring:message code="label.friend.search.userId.success.result" /></a></td>'
									+ '</td></tr></tbody>')
		}

		function failFriend() {
			$('#friendResult').html('');
		}
	</script>
	<%@ include file="/WEB-INF/common/footer.jsp"%>
</body>
</html>
