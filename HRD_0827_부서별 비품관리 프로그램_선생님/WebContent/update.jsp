<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비품관리 프로그램</title>
<script type="text/javascript">
	function check() {
		if (f.equipment_no.value == "") {
			alert("비품번호가 입력되지 않았습니다.");
			return f.equipment_no.focus();
		}
		if (f.equipment_name.value == "") {
			alert("비품명이 입력되지 않았습니다.");
			return f.equipment_name.focus();
		}
		if (f.equipment_group[0].checked == false && f.equipment_group[1].checked == false) {
			alert("비품종류를 체크해주세요.");
			return;
		}
		if (f.equipment_price.value == "") {
			alert("비품단가가 입력되지 않았습니다.");
			return f.equipment_price.focus();
		}
		if (f.reg_date.value == "") {
			alert("등록일자가 입력되지 않았습니다.");
			return f.reg_date.focus();
		}
		if (f.equipment_status[0].checked == false && f.equipment_status[1].checked == false) {
			alert("비품상태를 체크해주세요.");
			return;
		}
		if (f.equipment_unit.value == "") {
			alert("비품단위가 입력되지 않았습니다.");
			return f.equipment_unit.focus();
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
		sql += "select equipment_no, equipment_name, equipment_group, equipment_price, ";
		sql += " to_char(reg_date, 'yyyy-mm-dd'), ";
		sql += " equipment_status, equipment_unit ";
		sql += " from equipment_list_14 ";
		sql += " where equipment_name = ?";
		
		ps = conn.prepareStatement(sql);
		ps.setString(1, request.getParameter("equipment_name"));
		
		rs = ps.executeQuery();
		
		rs.next();
		
		String equipment_no = rs.getString(1);
		String equipment_name = rs.getString(2);
		String equipment_group = rs.getString(3);
		String equipment_price = rs.getString(4);
		String reg_date = rs.getString(5);
		String equipment_status = rs.getString(6);
		String equipment_unit = rs.getString(7);
	%>
	<section>
		<div>
			<h2>비품수정</h2>
		</div>
		<form action="updatePro.jsp" name="f" method="post">
			<table border="1" width="400px"style="margin: 0 auto;">
				<tr>
					<th>비품번호</th>
					<td>
						<input type="text" value="<%=equipment_no %>" name="equipment_no" size="30" maxlength="6" readonly>
					</td>
				</tr>
				<tr>
					<th>비품명</th>
					<td>
						<input type="text" value="<%=equipment_name %>" name="equipment_name" size="30" maxlength="50">
					</td>
				</tr>
				<tr>
					<th>비품분류</th>
					<td>
						<label><input type="radio" name="equipment_group" value="1"
						<%if (equipment_group != null && equipment_group.equals("1")){out.print("checked");} %>>기계기구</label>
						<label><input type="radio" name="equipment_group" value="2"
						<%if (equipment_group != null && equipment_group.equals("2")){out.print("checked");} %>>집기비품</label>
					</td>
				</tr>
				<tr>
					<th>비품단가</th>
					<td>
						<input type="text" value="<%=equipment_price %>" name="equipment_price" size="30">
					</td>
				</tr>
				<tr>
					<th>등록일자</th>
					<td>
						<input type="text" value="<%=rs.getString(4) %>" name="reg_date" size="30">
					</td>
				</tr>
				<tr>
					<th>비품상태</th>
					<td>
						<label><input type="radio" name="equipment_status" value="Y"
						<%if (equipment_status != null && equipment_status.equals("Y")){out.print("checked");} %>>사용</label>
						<label><input type="radio" name="equipment_status" value="N"
						<%if (equipment_status != null && equipment_status.equals("N")){out.print("checked");} %>>미사용</label>
					</td>
				</tr>
				<tr>
					<th>비품단위</th>
					<td>
						<input type="text" value="<%=equipment_unit %>" name="equipment_unit" size="30" maxlength="20">
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="수정" onclick="check(); return false">
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