<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>

<script type="text/javascript">

	$j(document).ready(function(){
		
		function fn_valiChk() {
			var writeForm = $j(".boardWrite .chk").length;
				for (var i = 0; i < writeForm; i++) {
					if ($j(".chk").eq(i).val() == "" || $j(".chk").eq(i).val() == null) {
						alert($j(".chk").eq(i).attr("title"));
						return true;
				}
			}
		}	
		
		$j("#submit").on("click",function(){
			if (fn_valiChk()) {
				return false;
			}
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
// 			alert(param)


			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("작성완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
	});
	

</script>
<body>
	<form class="boardWrite">
		<table align="center">
			<tr>
				<td align="right">
				<input id="submit" type="button" value="작성">
				</td>
			</tr>
			<tr>
				<td>
					<table border ="1">
						<tr>
							<td width="120" align="center">
							Type
							</td>
							
							<td width="400">
								<select name="boardType">
									<c:forEach var="code" items="${codeName}" varStatus="status">
										<option value="${code.codeId}">${code.codeName}</option>
									</c:forEach>
								</select> 
							</td>
						</tr> 
						<tr>
							<td width="120" align="center">
							Title
							</td>
							<td width="400">
							<input name="boardTitle" type="text" size="50" class="chk" title="제목을입력하세요" value="${board.boardTitle}"> 
							</td>
						</tr>
						<tr>
							<td height="300" align="center">
								Comment
							</td>
							<td valign="top">
								<textarea name="boardComment" class="chk" title="내용을입력하세요" rows="20" cols="55">${board.boardComment}</textarea>
							</td>
						</tr>
						<tr>
							<td align="center">
							Writer
							</td>
							<td>
							<input type="hidden" name="creator" value="${user.userName}">${user.userName}
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<a href="/board/boardList.do">List</a>
				</td>
			</tr>
		</table>
	</form>	
</body>
</html>