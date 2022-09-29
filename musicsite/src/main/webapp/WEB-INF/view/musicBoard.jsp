<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@include file="/WEB-INF/view/layer/header.jsp"%>
</head>
<body>
	<div class="container w-50 p-3">
		<c:if test="${param.bdType eq 's'}">
			<h3>싱글 게시판</h3>
		</c:if>
		<c:if test="${param.bdType eq 'a'}">
			<h3>앨범 게시판</h3>
		</c:if>
		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col" style="width: 60%">제목</th>
					<th scope="col">작성일</th>
					<th scope="col">조회수</th>
					<th scope="col">추천</th>
					<th scope="col" style="width: 15%">작성날짜</th>
				</tr>
			</thead>
			<tbody class="table-group-divider">
				<c:forEach var="i" items="${mbList}">
					<tr>
						<td><a
							href="${pageContext.request.contextPath}/board/musicboardpost?no=${i.no}">
								<c:if test="${param.bdType eq 's' || param.bdType eq 'a'}">
							${i.artist} - ${i.title}
								</c:if> <c:if test="${param.bdType eq 'l'}">
								${i.title}
								</c:if>
						</a>
						</th>
						<td>${i.userNickname}</td>
						<td>${i.readcnt}</td>
						<td>${i.recocnt}</td>
						<td><fmt:formatDate value="${i.boardDate}"
								pattern="yyyy.MM.dd" /></td>
					</tr>
				</c:forEach>


			</tbody>
		</table>
		<div class="hasMarg">
			<c:if test="${param.bdType eq 's'}">
				<button class="btn btn-light rightButton" id="likeButton"
					onclick="location.href='${pageContext.request.contextPath}/board/addmusicboard?bdType=s'">글쓰기</button>
			</c:if>
			<c:if test="${param.bdType eq 'a'}">
				<button class="btn btn-light rightButton" id="likeButton"
					onclick="location.href='${pageContext.request.contextPath}/board/addmusicboard?bdType=a'">글쓰기</button>
			</c:if>
			<c:if test="${param.bdType eq 'l'}">
				<button class="btn btn-light rightButton" id="likeButton"
					onclick="location.href='${pageContext.request.contextPath}/board/addmusicboard?bdType=l'">글쓰기</button>
			</c:if>
			<c:if test="${param.bdType eq 'm'}">
				<button class="btn btn-light rightButton" id="likeButton"
					onclick="location.href='${pageContext.request.contextPath}/board/addmusicboard?bdType=m'">글쓰기</button>
			</c:if>
		</div>

	</div>
</body>
</html>