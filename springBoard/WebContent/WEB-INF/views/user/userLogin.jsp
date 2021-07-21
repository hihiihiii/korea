<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인 페이지</title>
<script type="text/javascript">
$j(document).ready(function(){
	//입력값 체크
	$j("#submit").on("click",function(){
		if($j("#userId").val() ==''){
			alert("아이디를 입력해주세요.");
			$j("#userId").focus();
			return false
		}else if($j("#userPw").val()==''){
			alert("비밀번호를 입력해주세요.");
			$j("#userPw").focus();
			return false
		}
		
		var $frm = $j('#loginForm :input');
		var param = $frm.serialize();
		
		$j.ajax({
		    url : "/user/userLoginAction.do",
		    dataType: "json",
		    type: "POST",
		    data : param,
		    success: function(data, textStatus, jqXHR){
		    	if(data.success == 'N'){
                    /* alert('잘못된 아이디이거나, 비밀번호가 틀렸습니다.'); */
                    var html="<tr><td style='color: red'>잘못된 아이디 이거나, 비밀번호가 틀렸습니다.</td></tr>"; 
                    $j('#pwReg').empty();
					$j('#pwReg').append(html);
                    $j("#userPw").focus();
                    return false;
		    	}else{
                    location.href="/board/boardList.do" ; 
		    	}
		    	
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("실패");
		    }
		});
	});
});

	//영어+숫자 만 입력
	function engNumOnly(e){
		e.value= e. value.replace(/[^a-z0-9]/gi,'')
	}
	//영어만 입력
	function engOnly(e)  {
		  e.value = e.value.replace(/[^A-Za-z]/ig, '')
	}
	
</script>
</head>
<body>

<form action="/user/userLoginAction.do" method="post" id="loginForm">
	<input name="userName" id="userName" type="hidden">
	<table align="center">
	<tr>
		<td align="left">
			<a href="/board/boardList.do">List</a>
			
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
					<tr>
						<td align="center" width="100px">
							id
						</td>
						<td>
							<input name="userId" id="userId" type="text" size="20" maxlength='20' oninput="engNumOnly(this);">
						</td>
					</tr>
					<tr>
						<td align="center" width="100px">
							pw
						</td>
						<td>
							<input name="userPw" id="userPw" type="password" size="20" maxlength='20'>
						</td>
					</tr>	
			</table>
			</td>
		</tr>
		
		<tr>
			<td align="right">
				<font name="pwReg" id="pwReg" size="1"></font>
				<a href="#" type="submit" id="submit">login</a>
				<!-- <input id="submit" type="submit" value="join"> -->
			</td>
		</tr>
</table>
</form>	
</body>
</html>