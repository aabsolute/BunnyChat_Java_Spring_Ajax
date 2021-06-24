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
		<table class="table" style="margin: 0 auto;">
			<thead>
				<tr>
					<th colspan="2"><h4><spring:message code="lable.chat.message.touser.list" /></h4></th>
				</tr>
			</thead>
			<tbody>
				<tr >
					<th style="width: 150px; text-align:center; border:1px solid #dddddd;" ><spring:message code="label.chat.check.message.friend" /></th>
					<th style="text-align:center; border:1px solid #dddddd;"><spring:message code="label.chat.check.message.message" /></th>
				</tr>
			</tbody>
			<div style="overflow-y:auto; width:100%; max-height: 450px;">
				<table class="table table-bordered table-hover" style="text-align:center; border:1px solid #dddddd; margin: 0 auto;">
					<tbody id="boxTable">
					</tbody>
				</table>
			</div>
		</table>
	</div>
<!-- 	<div class="container bootstrap snippet">
		<div class="row">
			<div class="col-xs-12">
				<div class="portlet portlet-default">
					<div class="portlet-heading">
						<div class="portlet-title">
							<h4>
								<i class="fa fa-circle text-green"></i>&nbsp;&nbsp;Live Chatting
							</h4>
						</div>
						<div class="clearfix"></div>
					</div>
					<div id="chat" class="panel-collapse collapse in">
						<div id="chatlist" class="portlet-body chat-widget"
							style="overflow-y: auto; width: auto; height: 600px"></div>
						<div class="portlet-footer">
							<div class="row" style="height: 90px;">
								<div class="form-group col-xs-10">
									<textarea style="height: 80px;" id="chatContent"
										class="form-control"
										placeholder="<spring:message code="label.chat.message.placeholder.insert" />"
										maxlength="128"></textarea>
								</div>
								<div class="form-group col-xs-2">
									<button type="button" class="btn btn-default pull-right"
										onclick="submitFunction();">
										<spring:message code="label.chat.send" />
									</button>
									<div class="clearfix"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> -->
	
	<script type="text/javascript">
		function chatBoxFunction() {
			var userId = '<c:out value="${sessionScope.login.userId}"/>';
			$.ajax({
				type : 'post',
				url : '/chat/messageBoxAjax',
				data : {
					'userId' : encodeURIComponent(userId)
				},
				success : function(jdata) {
					if (jdata == "") return ;
					$('#boxTable').html('');
					var encodeData = decodeString(jdata);
					var result = JSON.parse(encodeData);
					for (key in result) {
						if(result[key].toUserId == userId){
							result[key].toUserId = result[key].fromUserId;
						}
						if(result[key].chatRead == 0){
							addnewBox(result[key].toUserId, result[key].chatContent, result[key].chatTime);
						}else{
							addBox(result[key].toUserId, result[key].chatContent, result[key].chatTime);
						}
					}
				}
			});
		}

		function addBox(to_id, chat_content, chat_time){
			$('#boxTable').append('<tr onclick="location.href=\'./main?toId=' +
			                      encodeURIComponent(to_id) +
			                      '\'">'+
			                      '<td style="width: 150px;"><h5>'+
			                      to_id +
			                      '</h5></td>' +
			                      '<td>'+
			                      '<h5>'+
			                      chat_content +
			                      '</h5>' +
			                      '<div class="pull-right">'+
			                      chat_time +
			                      '</div>'+
			                      '</td></tr>');
		}

		function addnewBox(to_id, chat_content, chat_time){
			$('#boxTable').append('<tr onclick="location.href=\'./main?toId=' +
			                      encodeURIComponent(to_id) +
			                      '\'">'+
			                      '<td style="width: 150px;"><h5>'+
			                      to_id +
			                      '</h5></td>' +
			                      '<td>'+
			                      '<h5>'+
			                      chat_content +
			                      '</h5>' +
			                      '<div class="pull-right">'+
			                      '<span class="label label-info" style="text-align:left">new message</span>&nbsp&nbsp'+
			                      chat_time +
			                      '</div>'+
			                      '</td></tr>');
		}


		function decodeString(str){
			if(str.indexOf("+") > 0){
				return decodeURIComponent(decodeURI(str).replace(/\+/g, " "));
			} else {
				return decodeURIComponent(decodeURI(str));
			}
		}

		function getInfiniteChat() {
			setInterval(function() {
				chatBoxFunction();
			}, 2000);
		}
		
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			getInfiniteChat();
		});
	</script>
	<%@ include file="/WEB-INF/common/footer.jsp"%>
</body>
</html>
