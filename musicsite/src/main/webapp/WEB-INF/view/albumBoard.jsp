<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
	crossorigin="anonymous">
</head>
<body>
	<div class="container w-50 p-3">
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">추천</th>
					<th scope="col">작성날짜</th>
				</tr>
			</thead>
			<tbody class="table-group-divider">
			<c:forEach var="i" items="${abList}">
				<tr>
					<td class="w-50"><a href="${pageContext.request.contextPath}/board/albumboardpost?no=${i.no}">${i.artist} - ${i.album}</a></th>
					<td class="w-10">${i.userNickname}</td>
					<td class="w-10">-</td>
					<td class="w-10"><fmt:formatDate value="${i.boardDate}"
							pattern="yyyy.MM.dd" /></td>
				</tr>
				</c:forEach>
			</tbody>
		</table>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>
</body>
</html>