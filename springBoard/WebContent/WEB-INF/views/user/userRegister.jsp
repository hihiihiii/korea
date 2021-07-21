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
		var idReg = /^[a-z0-9]{4,18}$/; //아이디 정규식
		var pwReg = /^[A-Za-z0-9]{6,12}$/; //비밀번호 정규식
		var nameReg = /^[\uac00-\ud7a3+]{2,4}$/; //이름 정규식 euc-kr 에선 glg <-- error 에러.
		var phoneReg =  /^\d{4}$/; //핸드폰 4자리
		var addrReg = /^\d{3}-\d{3}$/; //우편번호 정규식
		
		$j("#submit").on("click",function(){
			var $frm = $j('#registForm :input');
			var param = $frm.serialize();

			if(idx==false){
				alert("아이디 중복체크를 해주세요.");
				return;
			}
			if($j("#userId").val()==""){
				alert("아이디를 입력하세요.");
				$j("#userId").focus();
				return false;
			}
			
			if(!idReg.test($j("#userId").val())){
				$j("#userId").focus();
				return false;
			}
			
			if($j("#userPw").val()==""){
				alert("비밀번호를 입력하세요.");
				$j("#userPw").focus();
				return false;
			}
			if($j("#userPwCheck").val()==""){
				alert("비밀번호 재확인 입력");
				$j("#userPwCheck").focus();
				return false;
			}
				
			if($j("#userPw").val() != $j("#userPwCheck").val()){
				$j("#userPwCheck").focus();
					return false;
				}  
				
			if($j("#userName").val()==""){
				alert("이름을 입력하세요.");
				$j("#userName").focus();
				return false;
			}
			
			if($j("#userPhone2").val()==""){
				alert("번호를 입력하세요.");
				$j("#userPhone2").focus();
				return false;
			}
				
			if($j("#userPhone3").val()==""){
				alert("번호를 입력하세요.");
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
			    	alert("실패");
			    }
			});
			
		});
		
		//------------------------------유효성검사--------------------------------
		
		//아이디 정규식 
		$j("#userId").on("propertychange change keyup paste input",function(){
			if(!idReg.test($j("#userId").val())){
				$j('font[name=idReg]').text("");
				$j('font[name=idReg]').html("4~18자 영문자, 숫자를 사용하세요.");
			}else{
				$j('font[name=idReg]').text("");
				$j("font[name=check]").html("");
			}
		});
		
		//아이디 null이면 메세지 사라짐
		$j("#userId").on("propertychange change keyup paste input",function(){
			if($j("#userId").val() == ''){
				$j('font[name=idReg]').empty();
			}
		});
		
		//비밀번호 정규식
		$j("#userPw").on("propertychange change keyup paste input",function(){
			if(!pwReg.test($j("#userPw").val())){
				$j("font[name=pwReg]").text("");
				$j("font[name=pwReg]").html("6~12자 영문 대 소문자,숫자를 사용하세요.");
			}else{
				$j("font[name=pwReg]").text("");
				$j('font[name=pwReg]').empty();
			}
		});
		
		//비밀번호 null이면 메세지 사라짐
		$j("#userPw").on("propertychange change keyup paste input",function(){
			if($j("#userPw").val() == ''){
				$j('font[name=pwReg]').empty();
			}
		});
		
		//비밀번호 체크
		$j("#userPwCheck").on("propertychange change keyup paste input",function(){
			if($j("#userPw").val() != $j("#userPwCheck").val()){
				$j("font[name=check]").text("");
				$j("font[name=check]").html("비밀번호 불일치");
			}else{
				$j("font[name=check]").text("");
				$j("font[name=check]").html("비밀번호 일치");
			}
		});
		
		//비밀번호 null이면 메세지 사라짐
		$j("#userPwCheck").on("propertychange change keyup paste input",function(){
			if($j("#userPwCheck").val() == ''){
				$j('font[name=check]').empty();
			}
		});		
		
		
		//아이디 중복체크
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
							alert("아이디를입력하세요.");
							$j("#userId").focus();
							return false;
						}
						//체크했을때, 정규식에 안맞으면 focus
						if(!idReg.test($j("#userId").val())){
							$j("#userId").focus();
							return false;
						}
						if(data == 0){
							idx=true;
							alert("사용가능합니다.");
							/* $j('#userId').attr("readonly",true); */
							/* var html="<tr><td colspan='3' style='color: green'>사용가능</td></tr>"; */
							$j('#idCheck').empty();
							/* $j('#idCheck').append(html); */
						}else{
							alert("중복된 아이디입니다.");
							/* var html="<tr><td colspan='3' style='color: red'>사용불가능한 아이디 입니다.</td></tr>"; */
							$j("#userId").focus();
							return false;
							/* $j('#idCheck').append(html); */
						}
				},
				error : function(){
					 alert("실패");
				}
			});
		});
		
		//이름 정규식
		$j("#userName").on("propertychange change keyup paste input",function(){
			if(!nameReg.test($j("#userName").val())){
				$j("font[name=nameReg]").text('');
				$j("font[name=nameReg]").html("2~4이내, 한글만 사용하세요.");
			}else{
				$j("font[name=nameReg]").text('');
				$j("font[name=nameReg]").html('');
			}
		});
		
		//이름 null값
		$j("#userName").on("propertychange change keyup paste input",function(){
			if($j("#userName").val() == ''){
				$j('font[name=nameReg]').empty();
			}
		});	
		
		//핸드폰 4자리 
		$j("#userPhone2").on("propertychange change keyup paste input",function(){
			if(!phoneReg.test($j("#userPhone2").val()) &&  !phoneReg.test($j("#userPhone3").val())){
				$j("font[name=phoneReg]").text('');
				$j("font[name=phoneReg]").html("8자리의 번호를 입력해주세요.");
			}else{
				$j("font[name=phoneReg]").text('');
				$j("font[name=phoneReg]").html('8자리의 번호를 입력해주세요.');
			}
		});
		
		$j("#userPhone3").on("propertychange change keyup paste input",function(){
			if(!phoneReg.test($j("#userPhone3").val()) &&  !phoneReg.test($j("#userPhone3").val())){
				$j("font[name=phoneReg]").text('');
				$j("font[name=phoneReg]").html("8자리의 숫자를 입력해주세요.");
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
				$j("font[name=addrReg]").html("6자리의 숫자를 입력해주세요.");
			}else{
				$j("font[name=addrReg]").text('');
				$j("font[name=addrReg]").html('');
			}
		});
	

	});
	
	//자동하이픈 6자리 
	$j(document).on("keyup", "#userAddr1", function() { 
		$j(this).val( $j(this).val().replace(/[^0-9]/g, "").replace(
				/(\d{3})(\d{3})/, '$1-$2').replace("--","-") 
		);
	});
	
	//숫자 제한
	function numberMaxLength(e){
        if(e.value.length > e.maxLength){
            e.value = e.value.slice(0, e.maxLength);
        }
    }
	
	//영어만 입력
	function engOnly(e)  {
		  e.value = e.value.replace(/[^A-Za-z]/ig, '')
	}
	
	//영어+숫자
	function engNumOnly(e){
		e.value= e. value.replace(/[^a-z0-9]/gi,'')
	}
	
	//한글만 입력
	function korOnly(e)  {
		  e.value = e.value.replace(/[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g, '')
	}
	
	//숫자만
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
							<input type="button" id="idCheck" value="중복체크"/>
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