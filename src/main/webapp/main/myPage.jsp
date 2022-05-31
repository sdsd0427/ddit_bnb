<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
	Cookie[] cookies = request.getCookies();
	
	String user = "";
	String check = "";
	
	if(cookies != null){
		for(Cookie cookie : cookies){
			if(cookie.getName().equals("user")){
				user = cookie.getValue();
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대덕비앤비:마이페이지</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Fira+Sans:ital,wght@1,900&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="../js/login.js"></script>
<script type="text/javascript" src="../js/util.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="../style/reset.css">
<link rel="stylesheet" href="../style/myPage.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="../js/kakaoLogin.js"></script>
<script type="text/javascript">
$(function(){

	$.ajax({
		url : "/dditBnb/getReserList.do",
		type : "post",
		data : {
			"memId" : "<%= user%>"
		},
		success : function(res){
			
			code = "";
			
			if(res.length == 0){
				code += `
					<p class="empty">아직 예약된 여행이 없습니다!</p>
					<a href="./index.jsp" class="toSearch">숙소 검색하기</a>
				`;
				
				$('#reservation').html(code);
			}else{
				code += '<div id="reserList" class="list">';
				modalCode = '<div id="reserList">';
				
				$.each(res, function(i, v){			
					if(new Date(v.check_in) > new Date()){	
						if(i < 3){							
							code += '	<div class="listItem" id="' + v.reser_id + '">';
							code += '		<div class="itemImg">';
							code += '			<img src="' + v.img_link[0] + '" class="img">';
							code += '		</div>';
							code += '		<div class="itemDes">';
							code += '			<p class="itemName">' + v.prod_name + '</p>'
							code += '		</div>';
							code += '			<div class="scheduleCon">'
							code += '				<p class="schedule">여행 일정</p>'
							code += '				<p class="schedule">' + v.check_in.split("00")[0] + ' ~ ' + v.check_out.split("00")[0] + '</p>'
							code += '			</div>'
							code += '	</div>'
						}
						modalCode += '	<div class="modalListItem" id="' + v.reser_id + '">';
						modalCode += '		<div class="itemImg">';
						modalCode += '			<img src="' + v.img_link[0] + '" class="img">';
						modalCode += '		</div>'
						modalCode += '		<div class="itemDes">';
						modalCode += '			<p class="itemName">' + v.prod_name + '</p>'
						modalCode += '		</div>';
						modalCode += '			<div class="scheduleCon">'
						modalCode += '				<p class="schedule">여행 일정</p>'
						modalCode += '				<p class="schedule">' + v.check_in.split("00")[0] + ' ~ ' + v.check_out.split("00")[0] + '</p>'
						modalCode += '			</div>'
						modalCode += '	</div>'
					}
				})
				
				modalCode += '</div>';
				code += '</div>';
				
				if(res.length > 3){					
					code += '<button id="moreReser" data-toggle="modal" data-target="#moreReserModal">더 많은 예약보기</button>'
				}
				
				
				$('#reservation').html(code);
				$('#moreReserModal .modal-body').html(modalCode);
			}
			
			
		},
		error : function(xhr){
			alert("상태 : " + xhr.status)
		},
		dataType:'json'
	})
	
	$.ajax({
		url : "/dditBnb/getFavorList.do",
		type : "post",
		data : {
			"memId" : "<%= user%>"
		},
		success : function(res){
			code = "";
			
			if(res.length == 0){
				code += `
					<p class="empty">아직 찜 한 상품이 없습니다!</p>
					<a href="./index.jsp" class="toSearch">숙소 검색하기</a>
				`;
				
				$('#favorite').html(code);
			}else{
				code += '<div id="favorList" class="list">';
				modalCode = '<div id="favorList">';
				$.each(res, function(i, v){			

					if(i < 3){							
						code += '	<div class="listItem" id="' + v.prod_id + '">';
						code += '		<div class="itemImg">';
						code += '			<img src="' + v.img_link[0] + '" class="img">';
						code += '		</div>';
						code += '		<div class="itemDes">';
						code += '			<p class="itemName">' + v.prod_name + '</p>'
						code += '		</div>';
						code += '		<button class="remove">삭제</button>'
						code += '	</div>'
					}
					
					
					modalCode += '	<div class="modalListItem" id="' + v.prod_id + '">';
					modalCode += '		<div class="itemImg">';
					modalCode += '			<img src="' + v.img_link[0] + '" class="img">';
					modalCode += '		</div>';
					modalCode += '		<div class="itemDes">';
					modalCode += '			<p class="itemName">' + v.prod_name + '</p>'
					modalCode += '		</div>';
					modalCode += '		<button class="remove">삭제</button>'
					modalCode += '	</div>'
					
				})
				
				modalCode += '</div>'
				code += '</div>';
				
				if(res.length > 3){					
					code += '<button id="moreFavor" data-toggle="modal" data-target="#moreFavorModal">더 많은 찜 보기</button>'
				}

				
				$('#moreFavorModal .modal-body').html(modalCode);
				$('#favorite').html(code);
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status)
		},
		dataType:'json'
	})
	
	$.ajax({
		url : "/dditBnb/myInfo.do",
		type : "post",
		data : {
			"memId" : "<%= user %>"
		},
		success : function(res){
			$('#infoname').html(res.mem_name);
			$('#infoid').html(res.mem_id);
			
			if(res.mem_pass != null) {	
				$('#infopass').html(res.mem_pass);
			} else {
				$('#infopass').html("정보를 추가해주세요.");
			}
			
			if(res.mem_birth != null){				
				$('#infobirth').html(res.mem_birth.split(" ")[0]);
			} else {
				$('#infobirth').html("정보를 추가해주세요.");
			}
			
			$('#infoemail').html(res.mem_email);
			
			if(res.mem_tel != null){				
				$('#infotel').html(res.mem_tel.split());
			} else {
				$('#infotel').html("정보를 추가해주세요.");
			}
			
			if(res.mem_addr != null) {	
				$('#infoadd').html(res.mem_addr); 
			} else {
				$('#infoadd').html("정보를 추가해주세요.");
			}
		},
		error : function(xhr){
			alert("상태 : " + xhr.status)
		},
		dataType:'json'
	}) 
	
	$.ajax({
		url : "/dditBnb/myInfo.do",
		type : "post",
		data : {
			"memId" : "<%= user %>"
		},
		success : function(res){
			$('#infpass').val(res.mem_pass);	
			$('#infemail').val(res.mem_email);	
			$('#inftel').val(res.mem_tel);	
			$('#infbirth').val(res.mem_birth);	
			$('#infadd').val(res.mem_addr);	
			$('#infans').val(res.mem_ans);	
		},
		error : function(xhr){
			alert("상태 : " + xhr.status)
		},
		dataType:'json'
	}) 
	
	$('#updateMem').on('click', function(){	
		$.ajax({
			url : "/dditBnb/changeMem.do",
			type : "post",
			data : {
				"memId" : "<%= user %>",
				"pass" : $('#infpass').val(),
				"email" : $('#infemail').val(),
				"birth" : $('#infbirth').val(),
				"tel" : $('#inftel').val(),
				"add" : $('#infadd').val(),
				"hint" : $('#infhint').val(),
				"ans" : $('#infans').val()
			},
			success : function(res){
				alert('회원 정보를 수정했습니다.')
				location.reload();
			},
			error : function(xhr){
				alert("상태 : " + xhr.status)
			},
			dataType:'json'
		}) 
	})
	
	<%-- $(document).on('click', '.remove',function(){
		$.ajax({
			url : '/dditBnb/removeFavorite.do',
			type : 'post',
			data : {
				"mem_id" : "<%= user%>",
				"prod_id" : $(this).parents().attr('id')
			},
			success : function(res){
				alert(res)
				location.reload();
			},
			error : function(xhr){
				alert("상태 : " + xhr.status)
			}
		})
	}) --%>
	
	$('main').on('click','#reserList .listItem',function(){
		location.href = './reserDetail.jsp?reser_id=' + $(this).attr('id');
	})
	
	$('#moreReserModal').on('click','.modalListItem',function(){
		location.href = './reserDetail.jsp?reser_id=' + $(this).attr('id');
	})
	
	$('main').on('click','#favorList .listItem',function(e){
		if($(e.target).hasClass('remove')){
			removeFavor(e.target)
		}else{		
			location.href = './prodDetail.jsp?prodId=' + $(this).attr('id') + "&check_in=&check_out=&person=" + 0;
		}
	})
	
	$('#moreFavorModal').on('click','.modalListItem',function(e){
		if($(e.target).hasClass('remove')){
			removeFavor(e.target)
		}else{
			location.href = './prodDetail.jsp?prodId=' + $(this).attr('id') + "&check_in=&check_out=&person=" + 0;
		}
	})
	
	function removeFavor(target){
		$.ajax({
			url : '/dditBnb/removeFavorite.do',
			type : 'post',
			data : {
				"mem_id" : "<%= user%>",
				"prod_id" : $(target).parents().attr('id')
			},
			success : function(res){
				alert(res)
				location.reload();
			},
			error : function(xhr){
				alert("상태 : " + xhr.status)
			}
		})
	}
})
</script>
</head>
<body>
<header>
	<div id="headerTop">
		<div id="logoContainer">
			<a href="./index.jsp">
				<svg width="35" height="32" fill="hotpink" style="display:block;">
					<path d="
						M 16 1 c 2.008 0 3.463 0.963 4.751 3.269 l 0.533 1.025 c 1.954 3.83 6.114 12.54 7.1 14.836 l 0.145 0.353 c 0.667 1.591 0.91 2.472 0.96 3.396 l 0.01 0.415 l 0.001 0.228 c 0 4.062 -2.877 6.478 -6.357 6.478 c -2.224 0 -4.556 -1.258 -6.709 -3.386 l -0.257 -0.26 l -0.172 -0.179 h -0.011 l -0.176 0.185 c -2.044 2.1 -4.267 3.42 -6.414 3.615 l -0.28 0.019 l -0.267 0.006 C 5.377 31 2.5 28.584 2.5 24.522 l 0.005 -0.469 c 0.026 -0.928 0.23 -1.768 0.83 -3.244 l 0.216 -0.524 c 0.966 -2.298 6.083 -12.989 7.707 -16.034 C 12.537 1.963 13.992 1 16 1 Z m 0 2 c -1.239 0 -2.053 0.539 -2.987 2.21 l -0.523 1.008 c -1.926 3.776 -6.06 12.43 -7.031 14.692 l -0.345 0.836 c -0.427 1.071 -0.573 1.655 -0.605 2.24 l -0.009 0.33 v 0.206 C 4.5 27.395 6.411 29 8.857 29 c 1.773 0 3.87 -1.236 5.831 -3.354 c -2.295 -2.938 -3.855 -6.45 -3.855 -8.91 c 0 -2.913 1.933 -5.386 5.178 -5.42 c 3.223 0.034 5.156 2.507 5.156 5.42 c 0 2.456 -1.555 5.96 -3.855 8.907 C 19.277 27.766 21.37 29 23.142 29 c 2.447 0 4.358 -1.605 4.358 -4.478 l -0.004 -0.411 c -0.019 -0.672 -0.17 -1.296 -0.714 -2.62 l -0.248 -0.6 c -1.065 -2.478 -5.993 -12.768 -7.538 -15.664 C 18.053 3.539 17.24 3 16 3 Z m 0.01 10.316 c -2.01 0.021 -3.177 1.514 -3.177 3.42 c 0 1.797 1.18 4.58 2.955 7.044 l 0.21 0.287 l 0.174 -0.234 c 1.73 -2.385 2.898 -5.066 2.989 -6.875 l 0.006 -0.221 c 0 -1.906 -1.167 -3.4 -3.156 -3.421 h -0.001 Z
					">
					</path>
				</svg>
				<span id="logoTitle">
					dditBnB
				</span>
			</a>
		</div>
		
		<div class="userContent">
			<button class="hostingBtn"><a href="./hosthome.jsp">호스트 되기</a></button>
			<button class="userMenu">
				<span class="material-icons">
					reorder
				</span>
				<span class="material-icons" style="font-size:35px;">
					account_circle
				</span>
			</button>
		</div>
		<ul id="userMenu_list" style="display: none;">
			<li class="userMenu_item" id="message">메세지</li>
			<li class="userMenu_item" id="myPage"><a href="./myPage.jsp">마이페이지</a></li>
			<hr>
			<li class="userMenu_item" id="prodManage"><a href="./manageHostprod.jsp">숙소관리</a></li>
			<li class="userMenu_item" id="help"><a href="./helpBoard.jsp">도움말</a></li>
			<li class="userMenu_item" id="logOut">로그아웃</li>
		</ul>
		
	</div>
	<hr>
</header>
<main>
	<div id="content">
		<div id="reservationContainer" class="myPageCon">
			<h2 id="reservationCon_title" class="title">예정된 여행</h2>
			<hr>
			<div id="reservation" class="myPageItem">
				
			</div>
		</div>
		<hr>
		<div id="favoriteContainer" class="myPageCon">
			<h2 id="favoriteCon_title" class="title">위시리스트</h2>
			<hr>
			<div id="favorite" class="myPageItem">
			
			</div>
		</div>
	</div>

	<div id="memberinfo">
	 			<h2>회원정보</h2>
	 			<button data-toggle="modal" data-target="#infochgModal" id="infochange" class="toSearch">수정하기</button><hr><br>
	 			<div id="helpSelect_kind">
	 					<p>이름</p>
	 				<div id="infoname" class="info">
	 				</div><br><br>
	 					<p>아이디</p>
	 				<div id="infoid" class="info">
	 				</div><br><br>
	 					<p>비밀번호</p>
	 				<div id="infopass" class="info">
	 				</div><br><br>
	 					<p>생년월일</p>
	 				<div id="infobirth" class="info">
	 				</div><br><br>
	 					<p>이메일 주소</p>
	 				<div id="infoemail" class="info">
	 				</div><br><br>
	 					<p>전화번호</p>
	 				<div id="infotel" class="info">
	 				</div><br><br>
	 					<p>주소</p>
	 				<div id="infoadd" class="info">
	 				</div>
	 			</div>
	</div>
</main>

 		
<!-- The Modal -->
<div class="modal fade" id="infochgModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h2 style="font-size:1.3em"><%= user %>님의 회원 정보 수정</h2>
        <button type="button" class="close"  data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
			<form action="">
				<div id="helpSelect_kind">
 					<label for="infpass">비밀번호</label>
 				<input type="text" class="form-control" id="infpass">
 				<br><br>
 					<label for="infemail">이메일</label>
 				<input type="text" class="form-control" id="infemail">
 				<br><br>
 					<label for="infbirth">생년월일</label>
 				<input type="text" class="form-control" id="infbirth" placeholder="1998/08/11">
 				<br><br>
 					<label for="inftel">전화번호</label>
 				<input type="text" class="form-control" id="inftel">
 				<br><br>
 					<label for="infadd">주소</label>
 				<input type="text" class="form-control" id="infadd">
 				<br><br>
 					<label for="infhint">힌트질문</label><br>
 					<select name="findPwd" id="infhint" style="width:100%;">
			    	<option>
			    		보물 1호는?
			    	</option>
			    	<option>
			    		졸업한 고등학교는?
			    	</option>
			    	<option>
			    		가장 좋아했던 여자친구 이름은?
			    	</option>
			    	<option>
			    		가장 좋아했던 남자친구 이름은?
			    	</option>
			   		</select><br><br><br>
 					<label for="infans">힌트정답</label>
 				<input type="text" class="form-control" id="infans">
 				<br><br>
 					
 				</div>
			</form>
		</div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal" id="updateMem"
                style="background : white; color : black; border : 1px solid black;">수정</button>
      </div>
    </div>
  </div>
</div>

<footer id="footer">
	<div id="footer_list">
		<div id="footer_support">
			<h3>대덕비앤비 지원</h3>
			<ul>
				<li>도움말 센터</li>
				<li>안전 정보</li>
				<li>예약 취소 옵션</li>
				<li>에어비앤비의 코로나19 대응 방안</li>
				<li>장애인 지원</li>
				<li>이웃 민원 신고</li>
			</ul>
		</div>
		<div id="footer_community">
			<h3>커뮤니티</h3>
			<ul>
				<li>dditBnB.org:재난 구호 숙소</li>
				<li>아프간 난민 지원</li>
				<li>차별 철폐를 위한 노력</li>
			</ul>
		</div>
		<div id="footer_hosting">
			<h3>호스팅</h3>
			<ul>
				<li>호스팅 시작하기</li>
				<li>커뮤니티 포럼 방문하기</li>
				<li>에어커버:호스트를 위한 보호 프로그램</li>
				<li>책임감 있는 호스팅</li>
				<li>호스팅 자료 둘러보기</li>
			</ul>
		</div>
		<div id="footer_introduce">
			<h3>소개</h3>
			<ul>
				<li>뉴스룸</li>
				<li>채용정보</li>
				<li>새로운 기능에 대해 알아보기</li>
				<li>투자자 정보</li>
				<li>대덕비앤비 공동창업자의 메시지</li>
				<li>대덕비앤비 Luxe</li>
			</ul>
		</div>
	</div>
	<div id="footer_mark">
		<span>
			&copy; 2022 dditBnB,Inc
		</span>
	</div>
</footer>

</body>
<!-- 더 많은 예약  -->
<div class="modal" id="moreReserModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">예약 목록</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
<div class="modal" id="moreFavorModal">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">찜 목록</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
</html>