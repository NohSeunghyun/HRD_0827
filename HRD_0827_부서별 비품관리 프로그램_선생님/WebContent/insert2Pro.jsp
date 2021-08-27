<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%
	try {
		sql = "insert into equipment_postulat_14 values (?, ?, ?, ?, ?)";
		
		ps = conn.prepareStatement(sql);
		
		ps.setString(1, request.getParameter("req_no"));
		ps.setString(2, request.getParameter("equipment_no"));
		ps.setString(3, request.getParameter("req_date"));
		ps.setString(4, request.getParameter("req_qty"));
		ps.setString(5, request.getParameter("req_dept"));
		
		ps.executeUpdate();
%>
<script>
	alert("비품신청등록이 완료되었습니다.");
	location="insert2.jsp";
</script>
<%
	} catch (Exception e) {
%>
<script>
	alert("비품신청등록이 실패하였습니다.");
	history.back();
</script>
<%
	} finally {
		try {
			if (conn != null) conn.close();
			if (stmt != null) stmt.close();
			if (ps != null) ps.close();
			if (rs != null) rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>