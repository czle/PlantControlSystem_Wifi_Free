<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="org.json.simple.*"%>
<%@ include file="PCSConnect.jsp"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
	request.setCharacterEncoding("UTF-8");

	String NO = request.getParameter("NO");
	String CONTENT = request.getParameter("CONTENT");

	try {
		updateDiary = "update " + DIARYTABLE + " SET Content = ? where NO = ?";
		pstmt = conn.prepareStatement(updateDiary);
		pstmt.setString(1, CONTENT);
		pstmt.setString(2, NO);
		pstmt.executeUpdate();

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (rs != null)
				rs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (pstmt != null)
				pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	out.clear();
	out.print("전송완료!");
	out.flush();
%>