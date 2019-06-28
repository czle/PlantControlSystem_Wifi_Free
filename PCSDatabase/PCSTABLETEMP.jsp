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
		sqlTempTable = "select id,temp,date_format(datestamp,'%m월 %d일 %H시') from " + DBTABLE
				+ " order by id DESC";
		pstmt = conn.prepareStatement(sqlTempTable);
		rs = pstmt.executeQuery();
		Jobject = new JSONObject(); // 제이슨 객체.
		JSONArray jArray = new JSONArray(); // 제이슨 배열
		int count = 0;

		while (rs.next()) {
			JSONObject JOB = new JSONObject();
			JOB.put("id", rs.getString("id"));
			JOB.put("Temp", rs.getString("temp"));
			JOB.put("Date", rs.getString("date_format(datestamp,'%m월 %d일 %H시')"));
			jArray.add(count, JOB);
			count++;
		}
		Jobject.put("sendTampTable", jArray);
		out.println(Jobject);

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
