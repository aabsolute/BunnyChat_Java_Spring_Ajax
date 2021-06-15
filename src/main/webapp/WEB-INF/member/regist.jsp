<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/regist.css">
<%@ include file="/WEB-INF/common/header.jsp"%>
<script type="text/javascript">
	function fn_idChk(){
		$.ajax({
			type:'post',
			url:'/member/memberCheck',
			data: {'userId' : $('#userId').val()},
			success:function(result){
				if(result==0){
					$('#checkMessage').html('<spring:message code="label.member.idcheck.use" />');
					$('#checkType').attr('class','modal-content panel-success');
				}
				else{
					$('#checkMessage').html('<spring:message code="label.member.idcheck.notuse" />');
					$('#checkType').attr('class','modal-content panel-warning');
				}
				$('#checkModal').modal("show");
			}
		});
	}
	
	function fn_passwordChk(){
		var pass1 = $('#userPassword').val();
		var pass2 = $('#userPassword2').val();
		if(pass1 == pass2){
			$('#passwordChkMessage').html('');
		}else{
			$('#passwordChkMessage').html('<spring:message code="label.member.passwordcheck.notsame" />');
		}

	}
	</script>
</head>
<body>

	<div class="container">
		<form method="post">
			<%-- action="${pageContext.request.contextPath}/el" --%>
			<table class="table table-bordered table-hover"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>
								<spring:message code="label.member.join.title" />
							</h4></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 120px"><h5>
								<spring:message code="label.member.join.id" />
							</h5></td>
						<td><input class="form-control" type="text" id="userId"
							name="userId" maxlength="20"
							placeholder="<spring:message code="label.member.join.insertid" />"></td>
						<td style="width: 110px;"><button class="btn btn-primary"
								onclick="fn_idChk();" type="button">
								<spring:message code="label.member.join.checkid" />
							</button></td>
					</tr>
					<tr>
						<td style="width: 120px"><h5>
								<spring:message code="label.member.join.password" />
							</h5></td>
						<td colspan="2"><input onkeyup="fn_passwordChk();"
							class="form-control" type="password" id="userPassword"
							name="userPassword" maxlength="20"
							placeholder="<spring:message code="label.member.join.insertpassword1" />"></td>
					</tr>
					<tr>
						<td style="width: 120px"><h5>
								<spring:message code="label.member.join.passwordcheck" />
							</h5></td>
						<td colspan="2"><input onkeyup="fn_passwordChk();"
							class="form-control" type="password" id="userPassword2"
							name="userPassword2" maxlength="20"
							placeholder="<spring:message code="label.member.join.insertpassword2" />"></td>
					</tr>
					<tr>
						<td style="width: 120px"><h5>
								<spring:message code="label.member.join.username" />
							</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="userName" name="userName" maxlength="20"
							placeholder="<spring:message code="label.member.join.insertusername" />"></td>
					</tr>
					<tr>
						<td style="width: 120px"><h5>
								<spring:message code="label.member.join.userage" />
							</h5></td>
						<td colspan="2"><input class="form-control" type="text"
							id="userAge" name="userAge" maxlength="3"
							placeholder="<spring:message code="label.member.join.insertuserage" />"></td>
					</tr>
					<tr>
						<td style="width: 120px"><h5>
								<spring:message code="label.member.join.usersex" />
							</h5></td>
						<td colspan="2">
							<div class="form-group"
								style="text-align: center; margin: 0 auto;">
								<div class="btn-group" data-toggle="button">
									<label class="btn btn-primary active"> <input
										type="radio" name="userGender" autocomplete="off" value="m"
										checked>
									<spring:message code="label.member.join.usersex.m" />
									</label> <label class="btn btn-primary"> <input type="radio"
										name="userGender" autocomplete="off" value="f" checked>
									<spring:message code="label.member.join.usersex.f" />
									</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 120px"><h5>
								<spring:message code="label.member.join.useremail" />
							</h5></td>
						<td colspan="2"><input class="form-control" type="email"
							id="userEmail" name="userEmail"
							placeholder="<spring:message code="label.member.join.insertuseremail" />"></td>
					</tr>
					<tr>
						<td style="text-align:left;" colspan="3"><h5 style="color:red;" id="passwordChkMessage"></h5><input class="btn btn-primary pull-right" type="submit" value="<spring:message code="label.message.button.regist" />">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<%@ include file="/WEB-INF/common/footer.jsp"%>
</body>
</html>
