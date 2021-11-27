<%@ page contentType="text/html; charset=utf-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ETW routine_detials</title>
<style>
.menu {
	height: 50px;
	background-color: #213963;
	text-align: center;
}

.menu ul {
	display: inline-block;
	list-style: none;
	margin: 0;
}

.menu a {
	text-decoration: none;
	color: white;
}

.menu li:hover>a {
	color: #919191;
}

.menu li:hover>.subMenu li {
	display: block;
	background-color: #90ABDA;
}

.mainMenu li {
	float: left;
	width: 400px;
	height: 50px;
	line-height: 50px;
	text-align: center;
}

.subMenu li {
	float: none;
	display: none;
	position: relative;
	width: 300px;
	margin-left: 10px;
	z-index: 1;
}

.container {
	display: flex;
	justify-content: center;
}

#memberDataTable {
	border-collapse: collapse;
	width: 400px;
	height: 230px;
	table-layout: fixed;
}

#routineInfoOutput {
	width: 700px;
	height: 600px;
	border: 1px solid;
}

#routineTable {
	border-collapse: collapse;
	width: 700px;
	height: 350px;
	float: center;
}

#routineTableTr {
	height: 30px;
	width: 700px;
	table-layout: fixed;
}

#routineUpdateButton, #backButton {
	width: 150px;
	height: 45px;
	text-align: center;
	margin: 10px;
	background-color: #90ABDA;
}

#createButton {
	width: 400px; 
	height: 50px;	
	background-color: #90ABDA;
}

th, td {
	text-align: center;
	
}
</style>
</head>

<body>
	<!-- 운동하기 편하군&로고 -->
	<div style="text-align: center">
		<a href="<c:url value='/main' />"><img src="<c:url value='/images/logo.PNG' />" width=500px
			height=130px /></a> 
	</div>

	<hr>
	<!-- 메뉴바 -->
	<nav class="menu">
		<ul class="mainMenu">
			<li><a href='<c:url value='/club/list' />'>모임</a></li>
			<li><a href='<c:url value='/routine/list' />'>루틴</a></li>
			<li><a href='#'>다이어리</a>
				<ul class="subMenu">
					<li><a href='<c:url value='/diary/my/list' />'>MY 다이어리</a></li>
					<li><a href='<c:url value='/diary/all/list' />'>전체 다이어리</a></li>
				</ul></li>
		</ul>
	</nav>


	<hr>
	<div class="container">
		<!-- 회원정보 틀 -->
		<div style="width: 400px; height: 600px; border: 1px solid; float: left; margin-right: 10px;">
			<div style="height: 530px;">
				<h3 style="margin: 20px;">회원정보</h3>
				<table id="memberDataTable">
					<tr>
						<td><img src="<c:url value='/images/somsom.jpg' />" width=150px height=230px />
						</td>
						<td>이름 : 김동덕
							<p /> 등급 : 새싹
							<p /> <br> <a href='#'>회원정보 수정</a>
							<p>
								<a href='#'>로그아웃</a>
						</td>
					</tr>
				</table>
				<br><hr>
				<article>
					<h4 style="margin: 20px;">내 모임 목록</h4>
					<ul>
						<li><a href='#'>투현진</a></li>
						<li><a href='#'>ETW</a></li>
					</ul>
				</article>
			</div>
			<div style="height: 50px;">
				<!-- 루틴 등록 버튼 -->
				<input id="createButton" type="button" value="루틴 등록" onclick="location.href='<c:url value='/exercise/list' />'">
			</div>
		</div>

		<div style="float: right">
			<!-- 루틴 상세 정보 출력 부분  -->
			<div id="routineInfoOutput">
				<h3 style="margin: 20px;">루틴 상세 정보</h3>
				<hr>
				<table id="routineTable">
					<tr id="routineTableTr">
						<td style="width: 130px; font-size: 15px;">루틴명 :</td>
						<td style="text-align:left; font-size: 13px;">
							<p>${routine.rName}
						</td>
					</tr>
					<tr id="routineTableTr">
						<td style="width: 130px; font-size: 15px;">등록자 :</td>
						<td style="text-align:left; font-size: 13px;">
							<p>${routine.routineCreater}
						</td>
					</tr>
					<tr id="routineTableTr">
						<td style="width: 130px; font-size: 15px;">운동 부위 :</td>
						<td style="text-align:left; font-size: 13px;">
							<p>${routine.part}
						</td>
					</tr>
					<tr id="routineTableTr">
						<td style="width: 130px; font-size: 15px;">소요시간 :</td>
						<td style="text-align:left; font-size: 13px;">
							<p>${routine.rTime}분
						</td>
					</tr>
					<tr id="routineTableTr">
						<td style="width: 130px; font-size: 15px;">운동 강도 :</td>
						<td style="text-align:left; font-size: 13px;">
							<p>${routine.difficulty} (1~5)
						</td>
					</tr>
					<tr id="routineTableTr">
						<td style="width: 130px; font-size: 15px;">루틴 유형 :</td>
						<td style="text-align:left; font-size: 13px;">
							<p><c:choose>
									<c:when test="${routine.rType == 0}">전체</c:when>
									<c:otherwise>개인</c:otherwise>
								</c:choose>
						</td>
					</tr>
					<tr id="routineTableTr">
						<td style="width: 130px; font-size: 15px;">선택된 운동:</td>
						<td style="text-align:left; font-size: 13px;">
							<p><c:forEach var="exercise" items="${exerciseList}">
									<c:choose>
										<c:when test="${exercise == exerciseList[0]}">${exercise.name}</c:when>
										<c:otherwise>, ${exercise.name}</c:otherwise>
									</c:choose> 
								</c:forEach>
						</td>
					</tr>
					<tr id="routineTableTr">
						<td style="width: 130px; font-size: 15px;">운동 방법 :</td>
						<td style="text-align:left; font-size: 13px;">
							<textarea rows=8
							 cols=60
								style="overflow: scroll;resize: none; font-size: 13px;" readonly="readonly" disabled>
								<c:forEach var="exercise" items="${exerciseList}">
									${exercise.name} : ${exercise.method}
								</c:forEach>
							</textarea></td>
					</tr>
				</table>
				<div style="text-align: center;">
					<input id="routineUpdateButton" type="button" value="루틴 수정"
						onclick=""> 
					<input id="backButton" type="button" value="돌아가기" 
						onclick="location.href='<c:url value='/routine/list' />'">
				</div>
			</div>
		</div>
	</div>
</body>
</html>