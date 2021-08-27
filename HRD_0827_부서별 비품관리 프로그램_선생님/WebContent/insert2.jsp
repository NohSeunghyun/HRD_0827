<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비품관리 프로그램</title>
<script type="text/javascript">
	function check() {
		if (f.req_no.value == "") {
			alert("신청번호가 입력되지 않았습니다.");
			return f.req_no.focus();
		}
		if (f.equipment_no.value == "") {
			alert("비품번호가 입력되지 않았습니다.");
			return f.equipment_no.focus();
		}
		if (f.req_date.value == "") {
			alert("신청일자가 입력되지 않았습니다.");
			return f.req_date.focus();
		}
		if (f.req_qty.value == "") {
			alert("신청수량이 입력되지 않았습니다.");
			return f.req_qty.focus();
		}
		if (f.req_dept[0].checked == false && f.req_dept[1].checked == false
				&& f.req_dept[2].checked == false && f.req_dept[3].checked == false) {
			alert("신청부서를 체크해주세요.");
			return;
		}
		f.submit();
	}
	
	function rewrite() {
		if (confirm("다시 작성하시겠습니까?") == true) {
			alert("정보를 지우고 처음부터 다시 입력합니다!");
			f.reset();
			f.w_workno.focus();
		} else {
	        return ;
	    }
	}
</script>
</head>
<body>
<%@ include file="header.jsp" %>
	<%
		sql = "select nvl(max(req_no), 0)+1 as req_no from equipment_postulat_14";
	
		rs = stmt.executeQuery(sql);
		rs.next();
		String req_no = rs.getString(1);
	%>
	<section>
		<div>
			<h2>비품신청등록</h2>
		</div>
		<form action="insert2Pro.jsp" name="f" method="post">
			<table border="1" width="400px"style="margin: 0 auto;">
				<tr>
					<th>신청번호</th>
					<td>
						<input type="text" value="<%=req_no %>" name="req_no" size="30" readonly>
					</td>
				</tr>
				<tr>
					<th>비품번호</th>
					<td>
						<input type="text" value="" name="equipment_no" size="30" maxlength="6">
					</td>
				</tr>
				<tr>
					<th>신청일자</th>
					<td>
						<input type="text" value="" name="req_date" size="30">
					</td>
				</tr>
				<tr>
					<th>신청수량</th>
					<td>
						<input type="text" value="" name="req_qty" size="30">
					</td>
				</tr>
				<tr>
					<th>신청부서</th>
					<td>
						&nbsp;<label><input type="radio" name="req_dept" value="A1">총무</label>
						&nbsp;<label><input type="radio" name="req_dept" value="A2">회계</label>
						&nbsp;<label><input type="radio" name="req_dept" value="B1">경영</label>
						&nbsp;<label><input type="radio" name="req_dept" value="B2">인사</label>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="등록" onclick="check(); return false">
						<input type="button" value="다시쓰기" onclick="rewrite(); return false">
						<input type="button" value="조회" onclick="location='select.jsp'">
					</th>
				</tr>
			</table>
		</form>
	</section>
<%@ include file="footer.jsp" %>
</body>
</html>