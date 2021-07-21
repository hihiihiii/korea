 <%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
	$j(document).ready(function(){
		
		var idx = false;
		var idReg = /^[a-z0-9]{4,18}$/; //���̵� ���Խ�
		var pwReg = /^[A-Za-z0-9]{6,12}$/; //��й�ȣ ���Խ�
		var nameReg = /^[\uac00-\ud7a3+]{2,4}$/; //�̸� ���Խ� euc-kr ���� glg <-- error ����.
		var phoneReg =  /^\d{4}$/; //�ڵ��� 4�ڸ�
		var addrReg = /^\d{3}-\d{3}$/; //�����ȣ ���Խ�
		
		$j("#submit").on("click",function(){
			var $frm = $j('#registForm :input');
			var param = $frm.serialize();

			if(idx==false){
				alert("���̵� �ߺ�üũ�� ���ּ���.");
				return;
			}
			if($j("#userId").val()==""){
				alert("���̵� �Է��ϼ���.");
				$j("#userId").focus();
				return false;
			}
			
			if(!idReg.test($j("#userId").val())){
				$j("#userId").focus();
				return false;
			}
			
			if($j("#userPw").val()==""){
				alert("��й�ȣ�� �Է��ϼ���.");
				$j("#userPw").focus();
				return false;
			}
			if($j("#userPwCheck").val()==""){
				alert("��й�ȣ ��Ȯ�� �Է�");
				$j("#userPwCheck").focus();
				return false;
			}
				
			if($j("#userPw").val() != $j("#userPwCheck").val()){
				$j("#userPwCheck").focus();
					return false;
				}  
				
			if($j("#userName").val()==""){
				alert("�̸��� �Է��ϼ���.");
				$j("#userName").focus();
				return false;
			}
			
			if($j("#userPhone2").val()==""){
				alert("��ȣ�� �Է��ϼ���.");
				$j("#userPhone2").focus();
				return false;
			}
				
			if($j("#userPhone3").val()==""){
				alert("��ȣ�� �Է��ϼ���.");
				$j("#userPhone3").focus();
				return false;
			}
			
			if(!phoneReg.test($j("#userPhone2").val())){
				$j("#userPhone2").focus();
				return false;
			}
			if(!phoneReg.test($j("#userPhone3").val())){
				$j("#userPhone3").focus();
				return false;
			}
			
			if(!addrReg.test($j("#userAddr1").val())){
				$j("#userAddr1").focus();
				return false;
			}
			
			$j.ajax({
			    url : "/user/userRegisterAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
						location.href = "/board/boardList.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("����");
			    }
			});
			
		});
		
		//------------------------------��ȿ���˻�--------------------------------
		
		//���̵� ���Խ� 
		$j("#userId").on("propertychange change keyup paste input",function(){
			if(!idReg.test($j("#userId").val())){
				$j('font[name=idReg]').text("");
				$j('font[name=idReg]').html("4~18�� ������, ���ڸ� ����ϼ���.");
			}else{
				$j('font[name=idReg]').text("");
				$j("font[name=check]").html("");
			}
		});
		
		//���̵� null�̸� �޼��� �����
		$j("#userId").on("propertychange change keyup paste input",function(){
			if($j("#userId").val() == ''){
				$j('font[name=idReg]').empty();
			}
		});
		
		//��й�ȣ ���Խ�
		$j("#userPw").on("propertychange change keyup paste input",function(){
			if(!pwReg.test($j("#userPw").val())){
				$j("font[name=pwReg]").text("");
				$j("font[name=pwReg]").html("6~12�� ���� �� �ҹ���,���ڸ� ����ϼ���.");
			}else{
				$j("font[name=pwReg]").text("");
				$j('font[name=pwReg]').empty();
			}
		});
		
		//��й�ȣ null�̸� �޼��� �����
		$j("#userPw").on("propertychange change keyup paste input",function(){
			if($j("#userPw").val() == ''){
				$j('font[name=pwReg]').empty();
			}
		});
		
		//��й�ȣ üũ
		$j("#userPwCheck").on("propertychange change keyup paste input",function(){
			if($j("#userPw").val() != $j("#userPwCheck").val()){
				$j("font[name=check]").text("");
				$j("font[name=check]").html("��й�ȣ ����ġ");
			}else{
				$j("font[name=check]").text("");
				$j("font[name=check]").html("��й�ȣ ��ġ");
			}
		});
		
		//��й�ȣ null�̸� �޼��� �����
		$j("#userPwCheck").on("propertychange change keyup paste input",function(){
			if($j("#userPwCheck").val() == ''){
				$j('font[name=check]').empty();
			}
		});		
		
		
		//���̵� �ߺ�üũ
		$j("#idCheck").on("click",function(){
			$j.ajax({
				url : "/user/idCheck.do",
				type : "post",
				data : {
					"userId":$j("#userId").val()
				},
				dataType : "json",
				success : function(data){
						if($j("#userId").val() == ""){
							alert("���̵��Է��ϼ���.");
							$j("#userId").focus();
							return false;
						}
						//üũ������, ���ԽĿ� �ȸ����� focus
						if(!idReg.test($j("#userId").val())){
							$j("#userId").focus();
							return false;
						}
						if(data == 0){
							idx=true;
							alert("��밡���մϴ�.");
							/* $j('#userId').attr("readonly",true); */
							/* var html="<tr><td colspan='3' style='color: green'>��밡��</td></tr>"; */
							$j('#idCheck').empty();
							/* $j('#idCheck').append(html); */
						}else{
							alert("�ߺ��� ���̵��Դϴ�.");
							/* var html="<tr><td colspan='3' style='color: red'>���Ұ����� ���̵� �Դϴ�.</td></tr>"; */
							$j("#userId").focus();
							return false;
							/* $j('#idCheck').append(html); */
						}
				},
				error : function(){
					 alert("����");
				}
			});
		});
		
		//�̸� ���Խ�
		$j("#userName").on("propertychange change keyup paste input",function(){
			if(!nameReg.test($j("#userName").val())){
				$j("font[name=nameReg]").text('');
				$j("font[name=nameReg]").html("2~4�̳�, �ѱ۸� ����ϼ���.");
			}else{
				$j("font[name=nameReg]").text('');
				$j("font[name=nameReg]").html('');
			}
		});
		
		//�̸� null��
		$j("#userName").on("propertychange change keyup paste input",function(){
			if($j("#userName").val() == ''){
				$j('font[name=nameReg]').empty();
			}
		});	
		
		//�ڵ��� 4�ڸ� 
		$j("#userPhone2").on("propertychange change keyup paste input",function(){
			if(!phoneReg.test($j("#userPhone2").val()) &&  !phoneReg.test($j("#userPhone3").val())){
				$j("font[name=phoneReg]").text('');
				$j("font[name=phoneReg]").html("8�ڸ��� ��ȣ�� �Է����ּ���.");
			}else{
				$j("font[name=phoneReg]").text('');
				$j("font[name=phoneReg]").html('8�ڸ��� ��ȣ�� �Է����ּ���.');
			}
		});
		
		$j("#userPhone3").on("propertychange change keyup paste input",function(){
			if(!phoneReg.test($j("#userPhone3").val()) &&  !phoneReg.test($j("#userPhone3").val())){
				$j("font[name=phoneReg]").text('');
				$j("font[name=phoneReg]").html("8�ڸ��� ���ڸ� �Է����ּ���.");
			}else{
				$j("font[name=phoneReg]").text('');
				$j("font[name=phoneReg]").html('');
			}
		});
		
		$j("#userPhone3").on("propertychange change keyup paste input",function(){
			if($j("#userPhone3").val() == ''){
				$j("font[name=phoneReg]").text('');
				$j("font[name=phoneReg]").html('');
			}
		})
		
		$j("#userAddr1").on("propertychange change keyup paste input",function(){
			if(!addrReg.test($j("#userAddr1").val())){
				$j("font[name=addrReg]").text('');
				$j("font[name=addrReg]").html("6�ڸ��� ���ڸ� �Է����ּ���.");
			}else{
				$j("font[name=addrReg]").text('');
				$j("font[name=addrReg]").html('');
			}
		});
	

	});
	
	//�ڵ������� 6�ڸ� 
	$j(document).on("keyup", "#userAddr1", function() { 
		$j(this).val( $j(this).val().replace(/[^0-9]/g, "").replace(
				/(\d{3})(\d{3})/, '$1-$2').replace("--","-") 
		);
	});
	
	//���� ����
	function numberMaxLength(e){
        if(e.value.length > e.maxLength){
            e.value = e.value.slice(0, e.maxLength);
        }
    }
	
	//��� �Է�
	function engOnly(e)  {
		  e.value = e.value.replace(/[^A-Za-z]/ig, '')
	}
	
	//����+����
	function engNumOnly(e){
		e.value= e. value.replace(/[^a-z0-9]/gi,'')
	}
	
	//�ѱ۸� �Է�
	function korOnly(e)  {
		  e.value = e.value.replace(/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g, '')
	}
	
	//���ڸ�
	function numberOnly(e){
		e.value = e.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1')
	}
	
	
</script>

<style type="text/css">
 	input[type="number"]::-webkit-outer-spin-button,
	input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
</style>

</head>
<body>

<form action="/user/userRegisterAction.do" method="post" id="registForm" accept-charset="euc-kr">
	<table align="center">

	<tr>
		<td align="left">
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1" width="600" height="250">
					<tr>
						<td align="center">
							id
						</td>
						<td>
							<input name="userId" id="userId" type="text" size="20" oninput="engNumOnly(this);">
							<input type="button" id="idCheck" value="�ߺ�üũ"/>
							<font name="idReg" size="1" color="red"></font>
						</td>
					</tr>
					<tr>
						<td align="center">
							pw
						</td>
						<td>
							<input name="userPw" id="userPw" type="password" size="20" maxlength='20'>
							<font name="pwReg" size="1" color="red"></font>
						</td>
					</tr>
					<tr>
						<td align="center">
							pw check
						</td>
						<td>
							<input name="userPwCheck" id="userPwCheck" type="password" size="20" maxlength='20'>
							<font name="check" size="1" color="red"></font>
						</td>
					</tr>
					<tr>
						<td align="center">
							name
						</td>
						<td>
							<input name="userName" id="userName" type="text" size="20" maxlength='4' oninput="korOnly(this);">
							<font name="nameReg" size="1" color="red"></font>
						</td>
					</tr>
					<tr>
						<td align="center">
							phone
						</td>
						<td>
							<select name="userPhone1">
								<c:forEach var="code" items="${codeName}" varStatus="status">
									<option value="${code.codeId}">${code.codeName}</option>
								</c:forEach>	
							</select>
							-
							<input name="userPhone2" id="userPhone2" width="20px" size='1' maxlength='4' oninput="numberMaxLength(this); numberOnly(this);">
							-
							<input name="userPhone3" id="userPhone3" width="20px" size='1' maxlength='4' oninput="numberMaxLength(this); numberOnly(this);">
							
							<font name="phoneReg" size="1" color="red"></font>
						</td>
					</tr>
					<tr>
						<td align="center">
							postNo
						</td>
						<td>
							<input name="userAddr1" id="userAddr1" type="text" size="20" maxlength="6" oninput="numberMaxLength(this); numberOnly(this);">
							<font name="addrReg" size="1" color="red"></font>
						</td>
					</tr>
					<tr>
						<td align="center">
							address
						</td>
						<td>
							<input name="userAddr2" id="userAddr2" type="text" size="20">
						</td>
					</tr>
					<tr>
						<td align="center">
							company
						</td>
						<td>
							<input name="userCompany" id="userCompany" type="text" size="20">
						</td>
					</tr>
			</table>
		<tr>
			<td align="right">
				<a href="#" type="submit" id="submit">join</a>
				<!-- <input id="sub	mit" type="submit" value="join"> -->
			</td>
		</tr>
</table>
</form>	
</body>
</html>