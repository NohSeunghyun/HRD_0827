<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 한글로 된 값 넘길 때 한글처리하기위해 추가한 소스 -->
<%@ page import="java.net.URLEncoder" %>
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
			<h2>비품목록조회/수정</h2>
		</div>
		<table border="1" width="90%" style="margin: 0 auto;">
			<tr>
				<th>비품번호</th>
				<th>비품명</th>
				<th>비품분류</th>
				<th>등록일자</th>
				<th>비품상태</th>
				<th>비품단위</th>
			</tr>
			<%
				// as 별칭명 은 rs.getString("별칭명")을 사용할때 씀. rs.getString(1)을 쓴다면 as 별칭 사용 안해도됨
				sql += "select equipment_no, equipment_name, ";
				sql += " decode(equipment_group, '1', '기계가구', '2', '집기비품') as equipment_group, ";
				sql += " to_char(reg_date, 'yyyy-mm-dd') as reg_date, ";
				sql += " decode(equipment_status, 'Y', '사용', 'N', '미사용') as equipment_status,";
				sql += " equipment_unit";
				sql += " from equipment_list_14";
				sql += " order by 1 desc";
				
				rs = stmt.executeQuery(sql);
				
				while (rs.next()) {
			%>
			<tr align="center">
				<td><%=rs.getString(1) %></td>
				<td>
				<!-- 요청 타겟에서 유효하지 않은 문자가 발견되었습니다. ··· 
					 해결법 : 한글을 반드시 UTF-8로 인코딩 처리해서 값을 넘겨야함 맨 위 코드 참조 -->
				<a href="update.jsp?equipment_name=<%=URLEncoder.encode(rs.getString(2), "UTF-8") %>"> <!-- 비품번호(pk,한글이 아닌 수로 되어있음)를 가져오는게 제일 편리하지만 비품명을 가져온다. -->
				<%=rs.getString(2) %>
				</a>
				</td>
				<td><%=rs.getString(3) %></td>
				<td><%=rs.getString(4) %></td>
				<td><%=rs.getString(5) %></td>
				<td><%=rs.getString(6) %></td>
			</tr>
			<%
				}
			%>
		</table>
	</section>
<%@ include file="footer.jsp" %>
</body>
</html>