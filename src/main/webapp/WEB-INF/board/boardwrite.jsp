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
		<form method="post" modelAttribute="boardDTO" action="${pageContext.request.contextPath}/board/write" method="POST" enctype="multipart/form-data">
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
						<td><input class="form-control" type="text" name="boardTitle">
						</td>
					</tr>
					<tr>
						<td style="width: 110px"><h5>
								<spring:message code="label.member.board.write.content" />
							</h5></td>
						<td>
							<textarea class="form-control" name="boardContent" rows="10" maxlength="2048"></textarea>
						</td>
					</tr>
					<tr>
						<td style="width: 110px"><h5>
								<spring:message code="label.member.board.write.file.upload" />
							</h5></td>
						<td colspan="2">
							<input type="file" name="boardRealFile" class="file" id="gdsImg">
							<div class="input-group col-xs-12">
								<span class="input-group-addon"><i class="glyphicon glyphicon-picture"></i></span>
								<input class="form-control input-lg" type="text" disabled placeholder="fileupload">
								<span class="input-group-btn">
									<button class="browse btn btn-primary input-lg" type="button">
										<i class="glyphicon glyphicon-search"></i><spring:message code="label.member.board.search.file" />
									</button>
								</span>
							</div>
						</td>
						<td>
							<div class="select_img"><img src="" /></div>
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
		$(document).on('click','.browse', function(){
			var file = $(this).parent().parent().parent().find('.file');
			file.trigger('click');
		});

		$(document).on('change','.file', function(){
			$(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i,''));
		});
		$("#gdsImg").change(function(){
		   if(this.files && this.files[0]) {
		    var reader = new FileReader;
		    reader.onload = function(data) {
		     $(".select_img img").attr("src", data.target.result).width(500);
		    }
		    reader.readAsDataURL(this.files[0]);
		   }
		  });
	</script>
	<%@ include file="/WEB-INF/common/footer.jsp"%>
	<input type="hidden" name="boardDate" value="${board.boardDate}">
	<input type="hidden" name="boardHit" value="${board.boardHit}">
	<input type="hidden" name="boardGroup" value="${board.boardGroup}">
	<input type="hidden" name="boardSequence" value="${board.boardSequence}">
	<input type="hidden" name="boardLevel" value="${board.boardLevel}">
</body>
</html>
