<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%
	try {
		sql += "update equipment_list_14 ";
		sql += " set equipment_name = ?, ";
		sql += " equipment_group = ?, ";
		sql += " equipment_price = ?, ";
		sql += " reg_date = ?, ";
		sql += " equipment_status = ?, ";
		sql += " equipment_unit = ? ";
		sql += " where equipment_no = ?";
		
		ps = conn.prepareStatement(sql);
		
		ps.setString(1, request.getParameter("equipment_name"));
		ps.setString(2, request.getParameter("equipment_group"));
		ps.setString(3, request.getParameter("equipment_price"));
		ps.setString(4, request.getParameter("reg_date"));
		ps.setString(5, request.getParameter("equipment_status"));
		ps.setString(6, request.getParameter("equipment_unit"));
		ps.setString(7, request.getParameter("equipment_no"));
		
		ps.executeUpdate();
%>
<script>
	alert("비품정보 수정이 완료되었습니다.");
	location="select.jsp";
</script>
<%
	} catch (Exception e) {
%>
<script>
	alert("비품정보 수정이 실패하였습니다.");
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