<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
<script type="text/javascript">
$j(document).ready(function(){
	var formObj = $j("form[name='boardViewForm']");
	<%-- var userId = '<%=(String)session.getAttribute("userId")%>'; --%>
	// 수정 
		$j(".update_btn").on("click", function(){
			formObj.attr("action", "/board/${board.boardType}/${board.boardNum}/boardUpdate.do");
			formObj.attr("method", "get");
			formObj.submit();				
		})
		
		$j("#delete_btn").on("click",function(){
			var deleteYN = confirm("삭제하시겠습니까?"); 
			if(deleteYN == false){
				return false;
			}
			var param = formObj.serialize();
			alert("${user.userId}")
			alert("${board.boardType},${board.boardNum}")
			alert(param)
				$j.ajax({
				    url : "/board/boardDeleteAction.do",
				    dataType: "json",
				    type: "POST",
				    data : param,
				    success: function(data, textStatus, jqXHR)
				    {
				    	if(data.success == "N"){
				    		alert("삭제된 게시물입니다.");
				    		location.href = "/board/boardList.do";	
				    		return false;
				    	}
				    	
				    	alert("삭제완료")
						alert("메세지:"+data.success);
						
						location.href = "/board/boardList.do";
				    },
				    error: function (jqXHR, textStatus, errorThrown)
				    {
				    	alert("실패");
				    }
				});
			/* if(deleteYN==true){
				formObj.attr("action","/board/boardDeleteAction.do")
				formObj.attr("method","post");
				formObj.submit();
			} */
		});
	});

</script>
</head>
<body>
	<form name="boardViewForm">
		<input type="hidden" id="codeName" name="codeName" value="${board.codeName}">
		<input type="hidden" id="boardType" name="boardType" value="${board.boardType}">
		<input type="hidden" id="boardNum" name="boardNum" value="${board.boardNum}">
		 
		<%-- <input type="hidden" id="boardId" name="boardId" value="${board.boardId}"> --%>
		
	</form>
	
	<table align="center">
		<tr>
			<td align="right">
				<input id="delete_btn" type="submit" value="삭제">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1">
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400" class="chk">
						${board.boardTitle}
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td class="chk">
						${board.boardComment}
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						${board.creator}
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
				<c:if test="${user.userName==board.creator}" >
				<a href="/board/${board.boardType}/${board.boardNum}/boardUpdate.do" type="submit" class="update_btn">Update</a>
				</c:if>
			</td>
		</tr>
	</table>

</body>
</html>