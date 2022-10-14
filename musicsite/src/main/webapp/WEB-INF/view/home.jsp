<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<body>
	<%@include file="/WEB-INF/view/layer/header.jsp"%>

	<div class="conainer-index">
		<div class="row" style="margin: 10px">
			<div class="col hasMarg2">
				<div class="row">
					<div class="col-9">
						<h3>오늘의 라이브</h3>
					</div>
					<div class="col">
						<a style="float: right"
							href="${pageContext.request.contextPath}/board/musicboard?bdType=l&nowPage=1">더보기</a>
					</div>
				</div>
				<div class="row">
					<div class="indexVideo" id="toLive" style=""></div>
				</div>
			</div>

			<div class="col hasMarg2">
				<div class="row">
					<div class="col-9">
						<h3>오늘의 뮤비</h3>
					</div>
					<div class="col">
						<a style="float: right"
							href="${pageContext.request.contextPath}/board/musicboard?bdType=m&nowPage=1">더보기</a>
					</div>
				</div>
				<div class="row">
					<div class="indexVideo" id="toMV"></div>
				</div>
			</div>
		</div>
		<br>
		<div class="row" style="margin: 10px">
			<div class="col hasMarg2">
				<div class="row">
					<div class="col-9">
						<h3>BEST 앨범</h3>
					</div>
					<div class="col">
						<a style="float: right"
							href="${pageContext.request.contextPath}/board/musicboard?bdType=a&nowPage=1">더보기</a>
					</div>
				</div>
				<div class="row hasMarg">
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col" style="width: 60%">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">조회수</th>
								<th scope="col">추천</th>
							</tr>
						</thead>
						<tbody class="table-group-divider">
							<c:forEach var="i" items="${abList}" end="4">
								<tr>
									<td><a
										href="${pageContext.request.contextPath}/board/musicboardpost?no=${i.no}">
											${i.artist} - ${i.title} </a></td>
									<td>${i.userNickname}</td>
									<td>${i.readcnt}</td>
									<td>${i.recocnt}</td>		
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div class="col hasMarg2">
				<div class="row">
					<div class="col-9">
						<h3>BEST 싱글</h3>
					</div>
					<div class="col">
						<a style="float: right"
							href="${pageContext.request.contextPath}/board/musicboard?bdType=s&nowPage=1">더보기</a>
					</div>
				</div>
				<div class="row hasMarg">
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col" style="width: 60%">제목</th>
								<th scope="col">작성자</th>
								<th scope="col">조회수</th>
								<th scope="col">추천</th>
							</tr>
						</thead>
						<tbody class="table-group-divider">
							<c:forEach var="i" items="${sbList}" end="4">
								<tr>
									<td><a
										href="${pageContext.request.contextPath}/board/musicboardpost?no=${i.no}">
											${i.artist} - ${i.title} </a></td>
									<td>${i.userNickname}</td>
									<td>${i.readcnt}</td>
									<td>${i.recocnt}</td>		
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</div>
</body>
<script src="https://www.youtube.com/iframe_api"></script>
<content tag="local_script"> <script type="text/javascript"
	src="${pageContext.request.contextPath}/js_css_img/js/funtions.js"></script>
<script type="text/javascript">
	var todayLive = "${liveVideoId}"
	var todayMV = "${MBVideoId}"

	window.onload = loadIndexVideo("toLive", todayLive, 1)
	window.onload = loadIndexVideo("toMV", todayMV, 2)
</script>
</html>
