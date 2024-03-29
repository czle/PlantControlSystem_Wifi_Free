<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="org.json.simple.*"%>
<%@ include file="PCSConnect.jsp"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>


<%
	try {
		sqlRead = "select * from " + DBTABLE + " order by ID asc"; // 전체를 가져오기 위한 쿼리문
		pstmt = conn.prepareStatement(sqlRead);
		// pstmt에 쿼리문을 넣고
		rs = pstmt.executeQuery();

		Jobject = new JSONObject(); // 제이슨 객체.
		JSONArray jArray = new JSONArray(); // 제이슨 배열
		int count = 0;

		while (rs.next()) {
			JSONObject JOB = new JSONObject();
			JOB.put("ID", rs.getString("ID"));
			JOB.put("TEMP", rs.getString("TEMP"));
			JOB.put("HUMI", rs.getString("HUMI"));
			JOB.put("ILL", rs.getString("ILL"));
			JOB.put("DATESTAMP", rs.getString("DATESTAMP"));
			// 이건 여러개 생성하기.
			jArray.add(count, JOB);
			count++;
		}
		Jobject.put("sendData", jArray);
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