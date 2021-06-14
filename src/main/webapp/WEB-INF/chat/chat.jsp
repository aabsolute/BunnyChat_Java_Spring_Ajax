<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/common/header.jsp"%>
	<script type="text/javascript">
		function autoClosingAlert(selector, delay){
			var alert = $(selector).alert();
			alert.show();
			window.setTimeout(function() { alert.hide() }, delay);
		}
		function submitFunction(){
			var fromId = '<c:out value="${sessionScope.login.userId}"/>';
            var toId = '<c:out value="${param.toId}"/>';
            $.ajax({
    			type:'post',
    			url:'/chat/chatSubmit',
    			data: {
    				'fromUserId' : encodeURIComponent(fromId),
    				'toUserId' : encodeURIComponent(toId),
    				'chatContent' : $('#chatContent').val()
    			},
    			success:function(result){
    				if(result == 1){
                        autoClosingAlert('#successMessage',2000);
                    }else if (result == 0){
                        autoClosingAlert('#dangerMessage',2000);
                    }else{
                        autoClosingAlert('#warningMessage',2000);
                    }
    			}
    		});
            $('#chatContent').val('');
		}

		var lastId = 0;
		function chatListFunction(type){
			var fromId = '<c:out value="${sessionScope.login.userId}"/>';
            var toId = '<c:out value="${param.toId}"/>';
            $.ajax({
    			type:'post',
    			url:'/chat/chatList',
    			data: {
    				'fromUserId' : encodeURIComponent(fromId),
    				'toUserId' : encodeURIComponent(toId),
    				'listType' : type
    			},
    			success:function(jdata){
    				if(jdata == "") return;
    				var result = JSON.parse(jdata);
    				for(key in result){
    					addChat(result[key].fromUserId, result[key].chatContent, result[key].chatTime);
    				}
    				lastId = Number(parsed.first);
    			}
    		});
		}
		function addChat(chatName, chatContent, chatTime){
			$('#chatlist').append('<div class="row">'+
			                      '<div class="col-lg-12">'+
			                      '<div class="media">'+
			                      '<a class="pull-left" href="#">'+
			                      '<img class="media-object img-circle" style="width: 30px; height:30px;" src="/resources/images/man.png" alt="">'+
			                      '</a>'+
			                      '<div class="media-body">'+
			                      '<h4 class="media-heading">'+
			                      chatName+
			                      '<span class="small pull-right">'+
			                      chatTime+
			                      '</span>'+
			                      '</h4>'+
			                      '<p>'+
			                      chatContent+
			                      '</p>'+
			                      '</div>'+
			                      '</div>'+
			                      '</div>'+
			                      '</div>'+
			                      '<hr>');
			$('#chatlist').scrollTop($('#chatlist')[0].scrollHeight);
			}
		function getInfiniteChat(){
			setInterval(function(){
				chatListFunction(lastId);
			},3000);
		}

	</script>
</head>
<body>
	<div class="container bootstrap snippet">
		<div class="row">
			<div class="portlet portlet-default">
				<div class="portlet-heading">
					<div class="portlet-title">
						<h4><i class="fa fa-circle text-green"></i>Live Chatting</h4>
					</div>
					<div id="chat" class="panel-collapse collapse in">
						<div id="chatlist" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height:600px">
						</div>
						<div class="portlet-footer">
							<div class="row">
								<div class="form-group col-xs-4">
									<input style="height:40px;" type="text" id="chatName" class="form-control" placeholder="<spring:message code="label.chat.message.placeholder.username" />" maxlength="8" />
								</div>
							</div>
							<div class="row" style="height:90px;">
								<div class="form-group col-xs-10">
									<textarea style="height:80px;" id="chatContent" class="form-control" placeholder="<spring:message code="label.chat.message.placeholder.insert" />" maxlength="128"></textarea>
								</div>
								<div class="form-group col-xs-2">
									<button type="button" class="btn btn-default pull-right" onclick="submitFunction();"><spring:message code="label.chat.send" /></button>
									<div class="clearfix"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="alert alert-success" id="successMessage" style="display: none;">
		<strong><spring:message code="label.chat.message.send.success" /></strong>
	</div>
	<div class="alert alert-danger" id="dangerMessage" style="display: none;">
		<strong><spring:message code="label.chat.message.send.danger" /></strong>
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display: none;">
		<strong><spring:message code="label.chat.message.send.warning" /></strong>
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
							ok message
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

	<script type="text/javascript">
		$(document).ready(function(){
        	chatListFunction('ten');
        	getInfiniteChat();
        });
	</script>
</body>
</html>
