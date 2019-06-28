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
		sqlIllGraph = "select id,avg(ill),date_format(datestamp,'%d일') from " + DBTABLE
				+ " group by date_format(datestamp,'%d일') order by ID desc";
		pstmt = conn.prepareStatement(sqlIllGraph);
		rs = pstmt.executeQuery();
		Jobject = new JSONObject(); // 제이슨 객체.
		JSONArray jArray = new JSONArray(); // 제이슨 배열
		int count = 0;

		while (rs.next()) {
			JSONObject JOB = new JSONObject();
			JOB.put("id", rs.getString("id"));
			JOB.put("Ill", rs.getString("avg(ill)"));
			JOB.put("Date", rs.getString("date_format(datestamp,'%d일')"));
			jArray.add(count, JOB);
			count++;
		}
		Jobject.put("sendillGraph", jArray);
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