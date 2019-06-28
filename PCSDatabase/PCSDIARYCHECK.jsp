<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="org.json.simple.*"%>
<%@ include file="PCSConnect.jsp"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
	request.setCharacterEncoding("UTF-8");
	try {
		checkDiary = "select date_format(DATESTAMP,'%Y-%c-%d') from " + DIARYTABLE;
		pstmt = conn.prepareStatement(checkDiary);
		rs = pstmt.executeQuery();
		Jobject = new JSONObject(); // 제이슨 객체.
		JSONArray jArray = new JSONArray(); // 제이슨 배열
		int count = 0;
		while (rs.next()) {
			JSONObject jObj = new JSONObject();
			jObj.put("DATESTAMP", rs.getString("date_format(DATESTAMP,'%Y-%c-%d')"));
			jArray.add(count, jObj);
			count++;
		}
		Jobject.put("sendCheckDiary", jArray);
		//diaryResult = Jobject.toJSONString();
		//checkDiary(diaryResult);
		out.print(Jobject);

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

<%!private String checkDiary(String a) {
		return a;
	}%>