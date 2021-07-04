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
		<form method="post" action="${pageContext.request.contextPath}/member/profileManagement" method="POST" enctype="multipart/form-data">
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
						<td style="width: 120px"><h5>
								<spring:message code="label.member.board.write.userid" />
							</h5></td>
						<td><input class="form-control" type="text" id="userId"
							name="userId" value="${board.userId}" readonly="true">
						</td>
					</tr>
					<tr>
						<td style="width: 120px"><h5>
								<spring:message code="label.member.board.write.title" />
							</h5></td>
						<td><input class="form-control" type="text" id="userId"
							name="userId" value="${board.boardTitle}">
						</td>
					</tr>
					<tr>
						<td style="width: 110px"><h5>
								<spring:message code="label.member.profile.title.photo" />
							</h5></td>
						<td colspan="2">
							<input type="file" name="boardFile" class="file">
							<div class="input-group col-xs-12">
								<span class="input-group-addon"><i class="glyphicon glyphicon-picture"></i></span>
								<input type="text" name="form-control input-lg" disabled placeholder="fileupload">
								<span class="input-group-btn">
									<button class="browse btn btn-primary input-lg" type="button">
										<i class="glyphicon glyphicon-search"></i><spring:message code="label.member.board.search.file" />
									</button>
								</span>
							</div>
						</td>　
					</tr>
					<tr>
						<td style="text-align: left;" colspan="3"><h5
								style="color: red;"></h5>
							<input class="btn btn-primary pull-right" type="submit"
							value="<spring:message code="label.member.board.write.regist.up" />">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<script type="text/javascript">
		function fileDown(){
			var form = document.createElement("form2");
	         form.setAttribute("charset", "UTF-8");
	         form.setAttribute("method", "Post");  //Post 방식
	         form.setAttribute("action", "./member/download"); //요청 보낼 주소
	         form.submit();
		}


	</script>
	<%@ include file="/WEB-INF/common/footer.jsp"%>
</body>
</html>
