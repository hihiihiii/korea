<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판 수정페이지</title>

<script type="text/javascript">
	$j(document).ready(function(){
		var $frm = $j('.boardUpdate :input');
		/*  if($j("#boardTitle").val() && $j("#boardComment").val()){
			location.href = "/board/boardList.do";
			return false;
		}  */
		//valichk
		function fn_valiChk() {
			var updateForm = $j(".boardUpdate .chk").length;
				for (var i = 0; i < updateForm; i++) {
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
			var param = $frm.serialize();
			$j.ajax({
			    url : "/board/boardUpdateAction.do",
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


</head>
<body>
<form class="boardUpdate">
	<input type="hidden" name="boardNum" value="${board.boardNum}" readonly="readonly"/>
	<input type="hidden" name="boardType" value="${board.boardType}" readonly="readonly"/>
<!-- <input type="hidden" id="boardTitle" value="">
<input type="hidden" id="boardComment" > -->
	<table align="center">
		<tr>
			<td align="right">
			<c:if test="${user.userName==board.creator}">
			<input id="submit" type="button" value="수정">
			</c:if>
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1">
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardTitle" type="text" size="50" class="chk" title="제목을입력하세요" value="${board.boardTitle}" >
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td>
						<textarea name="boardComment" class="chk" title="내용을 입력하세요" rows="20" cols="55">${board.boardComment}</textarea>
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
				<a href="/board/${board.boardType}/${board.boardNum}/boardView.do">취소</a>
			</td>
		</tr>
	</table>
	</form>	
</body>
</html>