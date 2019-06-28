<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*"%>
<%@ include file="PCSConnect.jsp"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
	request.setCharacterEncoding("UTF-8");
	String DATESTAMP = request.getParameter("DATESTAMP");

	try {
		readDiary = "select * from " + DIARYTABLE + " where DATESTAMP = ?";
		pstmt = conn.prepareStatement(readDiary);
		pstmt.setString(1, DATESTAMP);
		rs = pstmt.executeQuery();
		Jobject = new JSONObject(); // 제이슨 객체.
		JSONArray jArray = new JSONArray(); // 제이슨 배열
		int count = 0;
		while (rs.next()) {
			JSONObject jObj = new JSONObject();
			jObj.put("NO", rs.getString("NO"));
			jObj.put("CONTENT", rs.getString("CONTENT"));
			jObj.put("DATESTAMP", rs.getString("DATESTAMP"));
			jArray.add(count, jObj);
			count++;
		}

		Jobject.put("sendreadDiary", jArray);
		diaryResult = Jobject.toJSONString();
		readDiary(diaryResult);
		out.print(diaryResult);

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
<%!private String readDiary(String a) {
		return a;
	}%>