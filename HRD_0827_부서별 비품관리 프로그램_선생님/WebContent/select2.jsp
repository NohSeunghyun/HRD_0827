<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비품관리 프로그램</title>
</head>
<body>
<%@ include file="header.jsp" %>
	<section>
		<div>
			<h2>비품구매현황조회</h2>
		</div>
		<table border="1" width="70%" style="margin: 0 auto;">
			<tr>
				<th>부서명</th>
				<th>신청건수</th>
				<th>비품 총 개수</th>
				<th>총 구입 금액</th>
			</tr>
			<%
				// as 별칭명 은 rs.getString("별칭명")을 사용할때 씀. rs.getString(1)을 쓴다면 as 별칭 사용 안해도됨
				sql += "select decode(req_dept, 'A1', '총무', 'A2', '회계', 'B1', '경영', 'B2', '인사') as req_dept, ";
				sql += " count(equipment_no) as equipment_no, ";
				sql += " sum(req_qty) as req_qty, ";
				sql += " to_char(sum(price), '999,999,999') as price ";
				sql += " from equipment_dept_14 natural join (select req_dept, equipment_no, req_qty, equipment_price*req_qty as price ";
				sql += " from equipment_list_14 natural join equipment_postulat_14) ";
				sql += " group by req_dept ";
				sql += " order by price desc";
				
				rs = stmt.executeQuery(sql);
				
				while (rs.next()) {
			%>
			<tr align="center">
				<td><%=rs.getString(1) %></td>
				<td><%=rs.getString(2) %></td>
				<td><%=rs.getString(3) %></td>
				<td align="right"><%=rs.getString(4) %></td>
			</tr>
			<%
				}
			%>
		</table>
	</section>
<%@ include file="footer.jsp" %>
</body>
</html>