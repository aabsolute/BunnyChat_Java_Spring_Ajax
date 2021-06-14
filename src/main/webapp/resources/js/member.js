//1. 아이디 중복 체크 이벤트
// $('#userId').focusout(function(){
// 		$('#writeResult').empty();
// 		if($('#id').val()=='') $('#writeResult').append(noIdMsg).alert();
// 		else if(checkID.test($('#id').val())==false){
// 			$('#writeResult').append(notAppropriateId).alert();
// 		}else
// 			$.ajax({
// 				type : 'post',
// 				url : '/member/checkEmail',
// 				data : 'id='+$('#id').val(),
// 				dataType : 'text',
// 				success : function(data){
// 					if(data=='exist')
// 						$('#writeResult').append(existMsg).alert();
// 					else if(data=='not_exist'){
// 						$('#writeResult').append(notexistMsg).alert();
// 						$('#checkId').val($('#id').val());
// 					}
// 				}
// 			});
// });

function registerCheckFunction(){
	var userId = $('#userId').val;
	$.ajax({
		type:'POST',
		url:'/member/memberCheck',
		data:{userId, userId},
		success:function(result){
			if(result==1){
				//$('#checkMessage').html('OK');
				//$('#checkType').attr('class','modal-content panel-success');
				alert("Error");
			}
			else{
				//$('#checkMessage').html('NG');
				//$('#checkType').attr('class','modal-content panel-warning');
				alert("Good");
			}
			//$('checkModal').modal("show");
		}
	});
}

function passwordCheckFunc(){
	var userPass1 = $('userPassword').val;
	var userPass2 = $('userPassword2').val;
	if(userPass1 != userPass2){
		$('#passwordCheckMessage').html('Not match');
	}else{
		$('#passwordCheckMessage').html('');
	}
}
