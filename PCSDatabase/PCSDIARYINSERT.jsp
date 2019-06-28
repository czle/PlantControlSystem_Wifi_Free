<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*"%>
<%@ include file="PCSConnect.jsp"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
	request.setCharacterEncoding("UTF-8");
	//String NO = request.getParameter("NO");
	String CONTENT = request.getParameter("CONTENT");
	String DATESTAMP = request.getParameter("DATESTAMP");

	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = DriverManager.getConnection(url, dbid, dbpw);
		overLapWriteCheck = "select DATESTAMP from " + DIARYTABLE + " where DATESTAMP = ?";
		pstmt = conn.prepareStatement(overLapWriteCheck);
		pstmt.setString(1, DATESTAMP);
		rs = pstmt.executeQuery();

		if (rs.next()) {
			insertReturns = "이미 일지가 존재합니다. 수정해주세요.";
			diaryInsert(insertReturns);
			out.println(insertReturns);
		} else {
			insertDiary = "insert into " + DIARYTABLE + "(CONTENT,DATESTAMP) values(?,?)";
			pstmt = conn.prepareStatement(insertDiary);
			pstmt.setString(1, CONTENT);
			pstmt.setString(2, DATESTAMP);
			pstmt.executeUpdate();
			insertReturns = "작성완료";
			diaryInsert(insertReturns);
			out.println(insertReturns);
		}

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
%>
<%!private String diaryInsert(String insertReturns) {
		return insertReturns;
	}%>