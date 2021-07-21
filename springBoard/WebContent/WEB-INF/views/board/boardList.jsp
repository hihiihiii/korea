<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ��� ���</title>

</head>
<script type="text/javascript">

	$j(document).ready(function(){
		//SelectDelete
		var boardListLength = ${fn:length(boardList)};
		
		$j("#selectAllDelete").click(function(){
			if($j("#selectAllDelete").prop("checked")){
				$j(".deleteCheck").prop("checked", true);
			}else{
				$j(".deleteCheck").prop("checked", false)
			}
		});
		
		//�Ѱ� ������
		$j(".deleteCheck").click(function(){
			if($j(".deleteCheck:checked").length ==boardListLength){
				$j("#selectAllDelete").prop("checked", true);
			}else{
				$j("#selectAllDelete").prop("checked", false);
			}
		});
		
		//���û�����
		$j(".selectDeleteBtn").click(function(){
			var confirm_val = confirm("���� �����Ͻðڽ��ϱ�?");
			if(confirm_val){
				var checkArr = new Array();
			}
			$j.ajax({
			    url : "/board/boardDeleteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
			    	
			    	if(data.success == "N"){
			    		alert("������ �Խù��Դϴ�.");
			    		location.href = "/board/boardList.do";	
			    		return false;
			    	}
			    	
			    	alert("�����Ϸ�")
					alert("�޼���:"+data.success);
					
					location.href = "/board/boardList.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("����");
			    }
			});
		})
		
		
		var codeNameLength = ${fn:length(codeName)}; 
		//üũ�ڽ� ��ȸ
		$j("#allCheck").click(function(){
			if($j("#allCheck").prop("checked")){
				$j(".typeCk").prop("checked", true);
			}else{
				$j(".typeCk").prop('checked',false);
			}
		});
		
		//�Ѱ��� üũ�ڽ� ������ ��ü���� üũ�ڽ��� ����
		$j(".typeCk").click(function(){
			if($j("input[name='codeId']:checked").length == codeNameLength){
				$j("#allCheck").prop("checked", true);
			}else{
				$j("#allCheck").prop("checked", false);
			}
		}); 
		
		$j("#btnSearch").click(function(){
			$j("#selectType").submit();
		});
		

		//�α׾ƿ�
		$j("#userLogoutBtn").click(function(){
			location.href="/user/userLogout.do";
		});
		
	});

</script>

<style type="text/css">
			li {list-style: none; float: left; padding: 6px;}
</style>
<body>
<div class="container">
<div class="row">

			<c:if test="${user==null}">
				<a class="btn btn-default" href="/user/userLogin.do">login</a>
				<a class="btn btn-default" href="/user/userRegister.do">join</a>
			</c:if>
			<c:if test="${user != null}">
				${user.userName} �� ȯ���մϴ�.
				<button id="userLogoutBtn" type="button" class="btn btn-deault">�α׾ƿ�</button>				
			</c:if>
</div>
<table class="table table table-striped table-hover">
			<thead>
				<tr>
					<!-- <td>
						<input type="checkbox" id="selectAllDelete" name="allDelete">
					</td> -->
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title 
					</td>
				</tr>
			</thead>
			<tbody>
				
				<!-- �Խ��Ǹ�� -->
				<c:forEach items="${boardList}" var="list">
			<tr>
						<%-- <td>
							<input type="checkbox" class="deleteCheck" name="deleteCheck" value="${list.boardNum},${list.boardType}">
						</td> --%>
						<td align="center">
							${list.codeName}
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
			</tr>	
				</c:forEach>
		
			</tbody>
			</table>	
			<div>
				<a href="/board/boardWrite.do">�۾���</a>
				<!-- <input type="button" value="���û���" class="selectDeleteBtn"> -->
			</div>

		<div class="container row" style="float: none; margin:100 auto;">
        	<div class="col-md-6" style="float: none; margin:0 auto;">
	<!-- ������ȸ -->
			<form id="selectType" class="selectType" method="get" action="/board/boardList.do">
				<input type="checkbox" id="allCheck"  value="all">��ü����
				<c:forEach var="code" items="${codeName}" varStatus="status">
					<input type="checkbox" class="typeCk" name="codeId" value="${code.codeId}">${code.codeName}</>
				</c:forEach>
				<button type="button" id="btnSearch" class="btn btn-default">��ȸ</button>
				
			</form>

	<!-- ����¡ -->	
		  <ul>
		    <c:if test="${pageMaker.prev}">
		    	<li><a href="boardList${pageMaker.makeQuery(pageMaker.startPage - 1)}"><</a></li>
		    </c:if> 
		
		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
		    	<li><a href="boardList.do${pageMaker.makeQuery(idx)}">${idx}</a></li>
		    </c:forEach>
		
		    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
		    	<li><a href="boardList.do${pageMaker.makeQuery(pageMaker.endPage + 1)}">></a></li>
		    </c:if> 
		  </ul>
		  </div>
		  </div>
	</div>

</body>
</html>