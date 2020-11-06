<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String user_id = (String) session.getAttribute("user_id");
	int cnt = (Integer) request.getAttribute("likeResult");
	int user_uid = (Integer) session.getAttribute("user_uid"); 
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>OP.IT</title>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<!--구글폰트-->
<link
	href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Noto+Sans+KR&display=swap"
	rel="stylesheet">

<!--합쳐지고 최소화된 최신 CSS-->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

<!--부가적인 테마-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

	
<!-- 파비콘 설정-->
<link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon"> 

<style>
* {
	margin: 0;
	padding: 0;
}

.commentCntDiv {
	background-color: lightgray;
	width: 100%;
	height: 100px;
	margin-bottom: 50px;
	margin-top: 100px;
}

.commentTxt1 {
	float: left;
	font-size: 30px;
	margin-top: 30px;
	margin-left: 20px;
}

.commentTxt2 {
	float: left;
	font-size: 20px;
	margin-top: 35px;
	margin-left: 20px;
}

.commentHr {
	background-color: gray;
	height: 1px;
}

#commentTextArea {
	margin-top: 50px;
	margin-bottom: 50px;
}

#replySubmitBt {
	float: right;
	margin-bottom: 50px;
}

thead tr th {
	color: #686868;
}

#listBtn {
	float: right;
}

#commentBt {
	float: right;
}

.commentContent {
	width: 100%;
	height: 100px;
	color: black;
}

#likeBt {
	background-color: white;
	border: none;
	float: right;
}

#likeBt:focus {
	outline: none;
}

.material-icons {
	font-size: 50px;
	color: black;
}

#textflow {
	overflow: hidden;
	word-wrap: break-word;
}

#imgwidth img {
	max-width: 100%;
}
</style>

</head>


<body>


	<jsp:include page="thema.jsp" />

	<div class="container">
		<br> <br> <br> <br>
		<h1 id="textflow">${list[0].board_title.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "")}</h1>
		<br> <br> <br> <br>

		<table class="table">
			<thead>
				<tr class="row">

					<th class="col-sm-2">추천수${list[0].board_likeCnt }</th>
					<th class="col-sm-3">작성자 ${list[0].board_writer }</th>
					<th class="col-sm-2">조회수 ${list[0].board_viewCnt }</th>
					<th class="col-sm-2">댓글 ${list[0].board_replyCnt }</th>
					<th class="col-sm-3">작성시간 ${list[0].board_regDate }</th>

				</tr>
			</thead>

			<tbody>
				<tr class="row">
					<td id="imgwidth" colspan="5">${list[0].board_content }</td>

				</tr>
			</tbody>
		</table>
		<hr class="commentHr">
		<c:choose>
			<c:when test="${likeViewResult % 2 == 0 }">
				<form id="likeForm" method="POST" action="likeOk.do">
			</c:when>
			<c:when test="${likeViewResult == 1 }">
				<form id="likeForm" method="POST" action="likeCancle.do">
			</c:when>
		</c:choose>


		<input type="hidden" name="board_id" value="${list[0].board_id }" />
		<input type="hidden" name="board_champion" value="${list[0].board_champion }" />

		<c:if test="${user_uid != -1 }">
			<c:choose>
				<c:when test="${likeViewResult == 0 }">
					<input id="likeBt" type="submit" class="material-icons" value="favorite_border">
				</c:when>
				<c:when test="${likeViewResult == 1 }">
					<input id="likeBt" type="submit" class="material-icons" value="favorite">
				</c:when>
			</c:choose>
		</c:if>

		</form>

		<div class="commentCntDiv">
			<p class="commentTxt1">댓글</p>
			<p class="commentTxt2">총 ${list[0].board_replyCnt }개</p>
		</div>
		<form action="replyWriteOk.do" method="POST">
			<input type="hidden" name="reply_writer" value="<%=user_id%>" />
			<textarea rows="5" cols="30" class="form-control"
				name="reply_content" id="commentTextArea" style="resize: none;"></textarea>
			<input type="hidden" name="board_id" value="${param.board_id }" /> <input
				type="hidden" name="board_champion" value="${param.board_champion }" />
			<input class="btn btn-outline-dark" id="replySubmitBt" type="submit"
				value="댓글 작성" />
		</form>

		<h3>최신순</h3>


		<hr class="commentHr">
		<div class="comment">
			<c:choose>
				<c:when test="${empty list2 || fn:length(list2) == 0 }">
				</c:when>
				<c:otherwise>
					<c:forEach var="dto" items="${list2 }" varStatus="status">
						<%-- request.getAttribute("list") --%>
						<div id="commentDiv" class="col-sm-12">
							<div class="commentWriter">작성자 : ${dto.reply_writer }</div>
							<div class="commentDate">작성시간 : ${dto.reply_regDate }</div>
							<textarea class="commentContent" style="resize: none;" disabled>${dto.reply_content }</textarea>
							<div id="commentBt">
								<button class="commentUpdateBt btn btn-outline-dark"
									data-toggle="modal" data-target="#updateModal${status.index}">수정</button>
								<button class="btn btn-outline-dark"
									onclick="location.href='replyDeleteOk.do?reply_id=${dto.reply_id }&board_id=${list[0].board_id }&board_champion=${list[0].board_champion }'">삭제</button>
							</div>
						</div>
						<form action="replyUpdateOk.do" method="POST">
							<div class="modal" id="updateModal${status.index}">
								<div class="modal-dialog">
									<div class="modal-content">

										<!-- Modal Header -->
										<div class="modal-header">
											<h4 class="modal-title">댓글 수정</h4>
											<button type="button" class="close" data-dismiss="modal">&times;</button>
										</div>

										<input type="hidden" name="reply_writer" value="<%=user_id%>" />
										<input type="hidden" name="board_id"
											value="${param.board_id }" /> <input type="hidden"
											name="board_champion" value="${param.board_champion }" />
										<!-- Modal body -->
										<div class="modal-body">
											<textarea class="commentContent" style="resize: none;"
												name="reply_content">${dto.reply_content }</textarea>
										</div>
										<input type="hidden" name="reply_id" value="${dto.reply_id }" />
										<!-- Modal footer -->
										<div class="modal-footer">
											<button type="submit" class="btn btn-primary">수정</button>
										</div>
									</div>
								</div>
							</div>
						</form>
						<br>
						<hr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
		<hr class="commentHr">



		<button class="btn btn-outline-dark"
			onclick="location.href='boardDeleteOk.do?board_id=${list[0].board_id }&board_champion=${list[0].board_champion }&board_writer=${list[0].board_writer }'">삭제</button>
		<button class="btn btn-outline-dark"
			onclick="location.href='boardUpdate.do?board_id=${list[0].board_id }&board_champion=${list[0].board_champion }'">수정</button>
		<a href="boardListTable.do?board_champion=${list[0].board_champion }"
			class="btn btn-outline-dark" id="listBtn">목록</a>
	</div>

	<jsp:include page="footer.jsp" />

</body>

<script>


</script>

</html>