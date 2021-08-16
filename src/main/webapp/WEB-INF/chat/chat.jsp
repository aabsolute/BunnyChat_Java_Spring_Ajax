<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/common/header.jsp"%>
<meta charset="UTF-8">
</head>
<body>
	<div class="container bootstrap snippet">
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
	</div>
	
	<script type="text/javascript">
		function autoClosingAlert(selector, delay) {
			var alert = $(selector).alert();
			alert.show();
			window.setTimeout(function() {
				alert.hide()
			}, delay);
		}

		function submitFunction() {
			var fromId = '<c:out value="${sessionScope.login.userId}"/>';
			var toId = '<c:out value="${param.toId}"/>';
			$.ajax({
				type : 'post',
				url : '/chat/chatSubmit',
				data : {
					'fromUserId' : encodeURIComponent(fromId),
					'toUserId' : encodeURIComponent(toId),
					'chatContent' : $('#chatContent').val()
				},
				success : function(result) {
					if (result == 1) {
						autoClosingAlert('#successMessage', 2000);
					} else if (result == 0) {
						autoClosingAlert('#dangerMessage', 2000);
					} else {
						autoClosingAlert('#warningMessage', 2000);
					}
				}
			});
			$('#chatContent').val('');
		}

		var lastId = 0;
		function chatListFunction(type) {
			var fromId = '<c:out value="${sessionScope.login.userId}"/>';
			var toId = '<c:out value="${param.toId}"/>';
			if(type != "ten"){
				var charId = type;
			}
			$.ajax({
				type : 'post',
				url : '/chat/chatList',
				data : {
					'fromUserId' : encodeURIComponent(fromId),
					'toUserId' : encodeURIComponent(toId),
					'listType' : type,
					'chatId' : charId
				},
				success : function(jdata) {
					if (jdata == ""){
						return;
					}
					var encodeData = decodeString(jdata);
					var result = JSON.parse(encodeData);
					for (key in result) {
						if(result[key].fromUserId == fromId){
							alert(result[key].myProfile);
							addMeChat("Me", result[key].chatContent
									,result[key].chatTime, result[key].myProfile);
						}else{
							addChat(result[key].fromUserId,
									result[key].chatContent, result[key].chatTime, result[key].yourProfile);
						}
					}
					lastId = Number(result[result.length-1].chatId);
				}
			});
		}

		function addChat(chatName, chatContent, chatTime, chatProfile) {
			$('#chatlist')
					.append(
							'<div class="row">'
									+ '<div class="col-lg-12">'
									+ '<div class="media">'
									+ '<a class="pull-left" href="#">'
									+ '<img class="media-object img-circle" style="width: 30px; height:30px;" src="'
									+ chatProfile
									+ '" alt="">'
									+ '</a>' + '<div class="media-body">'
									+ '<h4 class="media-heading">' + chatName
									+ '<span class="small pull-right">'
									+ chatTime + '</span>' + '</h4>' + '<p>'
									+ chatContent + '</p>' + '</div>'
									+ '</div>' + '</div>' + '</div>' + '<hr>');
			$('#chatlist').scrollTop($('#chatlist')[0].scrollHeight);
		}

		function addMeChat(chatName, chatContent, chatTime, chatProfile) {
			$('#chatlist')
					.append(
							'<div class="row">'
									+ '<div class="col-lg-12">'
									+ '<div class="media">'
									+ '<a class="pull-left" href="#">'
									+ '<img class="media-object img-circle" style="width: 30px; height:30px;" src="'
									+ chatProfile
									+ '" alt="">'
									+ '</a>' + '<div class="media-body">'
									+ '<h4 class="media-heading">' + chatName
									+ '<span class="small pull-right">'
									+ chatTime + '</span>' + '</h4>' + '<p>'
									+ chatContent + '</p>' + '</div>'
									+ '</div>' + '</div>' + '</div>' + '<hr>');
			$('#chatlist').scrollTop($('#chatlist')[0].scrollHeight);
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
				chatListFunction(lastId);
			}, 5000);
		}
		
	</script>
	<script type="text/javascript">
		$(document).ready(function() {
			chatListFunction("ten");
			getInfiniteChat();
		});
	</script>
	<%@ include file="/WEB-INF/common/footer.jsp"%>
</body>
</html>
