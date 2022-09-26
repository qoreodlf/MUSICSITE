<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
<h2>Hello World!</h2>
${userEmail}
${userNickname}
<a href="${pageContext.request.contextPath}/board/addalbumboard">앨범보드추가</a>
<a href="${pageContext.request.contextPath}/board/musicboard?bdType=a">앨범보드</a>
<a href="${pageContext.request.contextPath}/board/addsingleboard">싱글보드추가</a>
<a href="${pageContext.request.contextPath}/board/musicboard?bdType=s">싱글보드</a>
<a href="${pageContext.request.contextPath}/user/login">로그인</a>
<a href="${pageContext.request.contextPath}/user/join">회원가입</a>
</body>
</html>
