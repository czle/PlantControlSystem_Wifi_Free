<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*"%>

<%@ page language="java" import="java.sql.*"%>
<%
	String domain = "rds-mysql-10mintutorial.cvo10huevbgp.ap-northeast-2.rds.amazonaws.com";
	// LocalHost IP 주소, cmd 에서 ipconfig 를 하기바람.
	String url = "jdbc:mysql://" + domain
			+ ":3306/PCS?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=CONVERTTONULL&serverTimezone=GMT";
	// MYSQL의 주소.
	// mysql에 연결하기 위한것, 포트 주소 후에 스키마 이름을 적고, 유니코드, 언어인코딩, 시간설정 등을 해줘야만
	// 제대로 mysql에 연동된다.
	String dbid = "masterUsername";
	String dbpw = "12345678";
	String DBTABLE = "PCS.pcs";
	String DIARYTABLE = "PCS.diary";
	// 각 디비 테이블들의 이름

	String sqlRead;
	String sqlLogin;
	String sqlTotalGraph;
	String sqlTempGraph;
	String sqlHumiGraph;
	String sqlIllGraph;
	String sqlTempTable;
	String sqlHumiTable;
	String sqlIllTable;
	String TempTableFind;
	String HumiTableFind;
	String IllTableFind;
	String insertDiary;
	String readDiary;
	String updateDiary;
	String deleteDiary;
	String overLapWriteCheck;
	String insertReturns;
	String overLapReadCheck;
	String diaryResult;
	String checkDiary;
	// 쿼리문 모임

	JSONObject Jobject;
	// 리턴될 JsonObject 객체.

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		// mysql에 연결하기 위해 드라이버 로드.
		conn = DriverManager.getConnection(url, dbid, dbpw);
	} catch (Exception e) {
		e.printStackTrace();

	}
%>