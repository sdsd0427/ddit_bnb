<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String prod_id = request.getParameter("prodId");
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
	
	String check_in = request.getParameter("check_in");
	String check_out = request.getParameter("check_out");
	int person = Integer.parseInt(request.getParameter("person"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대덕비앤비:숙소 상세보기</title>
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="../style/reset.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
      rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Fira+Sans:ital,wght@1,900&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="../js/util.js"></script>
<script type="text/javascript" src="../js/signUp.js"></script>
<script type="text/javascript" src="../js/login.js"></script>
<link href="../style/prodDetailStyle.css" rel="stylesheet">
<link href="../datepicker/css/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<!-- Air datepicker css -->
<script src="../datepicker/js/datepicker.js"></script> <!-- Air datepicker js -->
<script src="../datepicker/js/i18n/datepicker.ko.js"></script> <!-- 달력 한글 추가를 위해 커스텀 -->
<script type="text/javascript">
$(function(){
	
	
	$.ajax({
		url : '/dditBnb/getProdDetail.do',
		type : 'post',
		data : {
			"prod_id" : "<%= prod_id%>",
			"check_in" : "<%= check_in%>",
			"check_out" : "<%= check_out%>"
		},
		success : function(res){
			titleCode = "<div id='prodName'>" + res.prodDetail.prod_name + " - " + res.prodDetail.prod_part + "</div>"
			titleCode += ' 	<div class="review">'
			titleCode += '		<span class="star">'
			titleCode += '			<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: #FF385C; height: 14px; width: 14px;">'
			titleCode += ' 				<path d="M15.094 1.579l-4.124 8.885-9.86 1.27a1 1 0 0 0-.542 1.736l7.293 6.565-1.965 9.852a1 1 0 0 0 1.483 1.061L16 25.951l8.625 4.997a1 1 0 0 0 1.482-1.06l-1.965-9.853 7.293-6.565a1 1 0 0 0-.541-1.735l-9.86-1.271-4.127-8.885a1 1 0 0 0-1.814 0z" fill-rule="evenodd">'
			titleCode += '				</path>'		
			titleCode += '			</svg>'	
			titleCode += '		</span>'
			titleCode += '		<span class="starNum">'
			titleCode += res.star 
			titleCode += '		</span>'
			titleCode += '		<span class="addFavorite">'
			titleCode += '			<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: transparent; height: 24px; width: 24px; stroke: black; stroke-width: 2; overflow: visible;">'
			titleCode += ' 				<path d="m16 28c7-4.733 14-10 14-17 0-1.792-.683-3.583-2.05-4.95-1.367-1.366-3.158-2.05-4.95-2.05-1.791 0-3.583.684-4.949 2.05l-2.051 2.051-2.05-2.051c-1.367-1.366-3.158-2.05-4.95-2.05-1.791 0-3.583.684-4.949 2.05-1.367 1.367-2.051 3.158-2.051 4.95 0 7 7 12.267 14 17z">'
			titleCode += '				</path>'		
			titleCode += '			</svg>'	
			titleCode += '		</span>'	
			titleCode += ' 	</div>'
			
			$('#prodTitle').html(titleCode);
			
			
			imgCode = "	<img src='" + res.prodDetail.link[0] + "' style='border-radius:20px;'>"
		
			
			$('#prodImgContainer').html(imgCode);
			
			infoTitleCode = "<span class='type'>[" + res.prodDetail.prod_type + "]</span>" 
			infoTitleCode += "<span class='title'>" + res.prodDetail.prod_name + "의 " + res.prodDetail.prod_part + "</span>"
			infoTitleCode += "<p class='person'>최대 인원 " + res.prodDetail.prod_per + "명</p>"
			
			$('#InfoTitle').html(infoTitleCode)
			
			$('#InfoDes').append(res.prodDetail.prod_des)
			
			infoConven = ""
			$.each(res.prodDetail.convenVo, function(i,v){				
				infoConven += "<div class='convenItem'>"
				infoConven += "		<span class='convenImg'>"
				infoConven += "			<img src='../convenimage/" + v.conven_link + "'>"
				infoConven += "		</span>"
				infoConven += "		<span class='convenName'>"
				infoConven += v.conven_name
				infoConven += "		</span>"
				infoConven += "</div>"
			})
			
			$('#InfoConven').append(infoConven);
			
			reviewTitleCode = "";
			reviewTitleCode += '		<span class="star">'
			reviewTitleCode += '			<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" role="presentation" focusable="false" style="display: block; fill: #FF385C; height: 20px; width: 20px;">'
			reviewTitleCode += ' 				<path d="M15.094 1.579l-4.124 8.885-9.86 1.27a1 1 0 0 0-.542 1.736l7.293 6.565-1.965 9.852a1 1 0 0 0 1.483 1.061L16 25.951l8.625 4.997a1 1 0 0 0 1.482-1.06l-1.965-9.853 7.293-6.565a1 1 0 0 0-.541-1.735l-9.86-1.271-4.127-8.885a1 1 0 0 0-1.814 0z" fill-rule="evenodd">'
			reviewTitleCode += '				</path>'		
			reviewTitleCode += '			</svg>'	
			reviewTitleCode += '		</span>'
			reviewTitleCode += '		<span class="starNum">'
			reviewTitleCode += res.star + ' · 후기'
			reviewTitleCode += '		</span>'
			
			$('#reviewTitle').html(reviewTitleCode);
			
			if(res.schePrice > 0){
				priceCode = "₩" + priceToString(res.prodDetail.prod_price)+ " / 박"
				$('#calPrice').html(priceCode);
				
				checkIn = new Date("<%= check_in%>")
				checkOut = new Date("<%= check_out%>")
				day = (checkOut - checkIn) / (1000 * 3600 * 24)
				
				schePriceCode = "<p class='calTotal'>"
				schePriceCode += "<span>"
				schePriceCode += "₩" + priceToString(res.prodDetail.prod_price) + " X " + day + "박"
				schePriceCode += "</span>"
				schePriceCode += "<span>"
				schePriceCode += "₩" + priceToString(res.schePrice)
				schePriceCode += "</span>"
				schePriceCode += "</p><hr>"
				schePriceCode += "<p class='totalPrice'>총 합계 ₩\r\r" + priceToString(res.schePrice) + "</p>"
				
				$('#schedulePrice').html(schePriceCode);
			}
			
			$('#hostName').append("호스트 : " + res.prodDetail.mem_id + "님")
			$('#hostDate').text("회원 가입일 : " + res.prodDetail.host_date.split(" ")[0])
			$('#hostDes').text(res.prodDetail.host_des)
			
				$('#contact').click(function(){
					location.href = "./message.jsp?mem_id=<%= user%>" + "&host_id=" + res.prodDetail.mem_id + "&prod_id=<%= prod_id%>"; 
				})
		},
		error : function(xhr){
			alert("상태 : " + xhr.status)
		},
		dataType : 'json'
	})
	
	$.ajax({
		url : '/dditBnb/getReview.do',
		type : 'post',
		data : {
			"prod_id" : "<%=prod_id%>"
		},
		success : function(res){
			reviewCode = "";
			
			$.each(res, function(i, v){
				reviewCode += "<div class='reviewItem'>"
				reviewCode += "	<div class='userInfo'>"
				reviewCode += "		<p class='userId'>" + v.mem_id + "</p>"
				reviewCode += "		<p class='reviewDate'>" + v.review_date.split(" ")[0] + "</p>"
				reviewCode += "	</div><hr>"
				reviewCode += "	<div class='reviewInfo'>"
				reviewCode += "		<p class='review_title'>" + v.review_title + "</p>"
				reviewCode += "		<p class='review_con'>" + v.review_con + "</p>"
				reviewCode += "	</div>"
				reviewCode += "</div>"
			})
			
			$('#reviewContainer').html(reviewCode);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status)
		},
		dataType : 'json'
	})
	
	function priceToString(price) {
    	return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
	
	$('.checkPossible').on('click',function(){
		if($('#checkIn').val() == "" || $('#checkOut').val() == ""){
			alert("여행 일정을 입력해주세요.")
		}else{
			
			person = 0;
	
			let animal = $('.animal_count').text();
			
			personCounts = document.getElementsByClassName('person_count')
			
			for(i = 0; i < personCounts.length; i++){
				person += parseInt(personCounts[i].innerText);
			}
			
			$.ajax({
				url : '/dditBnb/checkSchedule.do',
				type : 'post',
				data : {
					"prod_id" : "<%= prod_id%>",
					"check_in" : $('#checkIn').val(),
					"check_out" : $('#checkOut').val()
				},
				success : function(res){
					if(res == "success"){
						alert("예약 가능")
						location.href = "../main/prodDetail.jsp?prodId=<%= prod_id%>&check_in=" + $('#checkIn').val() + 
								"&check_out=" + $('#checkOut').val() + "&person=" + person;
					}else{
						alert("예약 불가능")
					}
				},
				error : function(xhr){
					alert("상태 : " + xhr.status)
				}
			})
		}
	})
	
	$('.reserBtn').click(function(){
		person = 0;

		let animal = $('.animal_count').text();
		
		personCounts = document.getElementsByClassName('person_count')
		
		for(i = 0; i < personCounts.length; i++){
			person += parseInt(personCounts[i].innerText);
		}
		
		if("<%= user%>" == ""){
			alert("로그인 후 이용해주세요.")
		}else{
			location.href="../main/scheReservation.jsp?prodId=<%= prod_id%>&check_in=" + $('#checkIn').val() +
					"&check_out=" + $('#checkOut').val() + "&person=" + person;
			
		}
	})	
	
	
	$(document).on('click', '.addFavorite', function(){		
		$('path', this).attr("fill","#FF385C")
		$.ajax({
			url : '/dditBnb/addFavorite.do',
			type : 'post',
			data : {
				"prod_id" : "<%= prod_id%>",
				"mem_id" : "<%= user%>"
			},
			success : function(res){
				alert(res);
			},
			error : function(xhr){
				alert("상태 : " + xhr.status)
			}
		}) 
	})
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
		<%
			if(user.equals("")){	
		%>
				<ul id="userMenu_list" style="display: none;">
					<li class="userMenu_item" id="signUp" data-toggle="modal" data-target="#signUpForm">회원가입</li>
					<li class="userMenu_item" id="login" data-toggle="modal" data-target="#loginForm">로그인</li>
					<hr>
					<li class="userMenu_item" id="doHost"><a href="./hosthome.jsp">숙소 호스트 되기</a></li>
					<li class="userMenu_item" id="help"><a href="./helpBoard.jsp">도움말</a></li>
				</ul>
		<%		
			}else{
		%>
				<ul id="userMenu_list" style="display: none;">
					<li class="userMenu_item" id="message">메세지</li>
					<li class="userMenu_item" id="myPage"><a href="./myPage.jsp">마이페이지</a></li>
					<hr>
					<li class="userMenu_item" id="prodManage"><a href="./manageHostprod.jsp">숙소관리</a></li>
					<li class="userMenu_item" id="help"><a href="./helpBoard.jsp">도움말</a></li>
					<li class="userMenu_item" id="logOut">로그아웃</li>
				</ul>
		<%
			}
		%>
	</div>
</header>
<hr>
<main>
	<div id="prodDetailContainer">
		<div id="prodTitle">
		</div>
		<div id="prodImgContainer">
		</div>
		<div id="prodInfo_reser_con">
			<div id="prodInfo">
				<div id="InfoTitle">
				</div>
				<hr>
				<div id="InfoDes">
				<p class="title">숙소 설명</p>
				</div>
				<hr>
				<div id="InfoConven">
				<p class="title">편의 시설</p>
				</div>
			</div>
			<div id="reservationContainer">
				<%
					if(check_in.equals("") && check_out.equals("")){
				%>
				<div id="calTotalPriceCon">				
					<div id="calPrice">요금을 확인하려면 날짜를 입력하세요.</div>
					<table id="reserInfo">
						<tr>
							<td>
								<p>체크인</p>
								<input type='text'  data-language='ko' id="checkIn"  placeholder="체크인"/>
							</td>
							<td>
								<p>체크아웃</p>
								<input type='text'  data-language='ko' id="checkOut"  placeholder="체크아웃"/>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="inputPersonContainer">				
									<p>인원</p>
									<span id="person">게스트 추가</span>
								</div>
								<div id="inputPerson" >
									<div id="adult" class="inputPerson_list">
										<div class="personDes">
											<p>일반</p>
											<span>만13세 이상</span>
										</div>
										<div class="personCount">
											<button class="personInput_Btn perMinus">
												<span>
													<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
													style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
														<path d="m2 16h28"></path>
													</svg>
												</span>
											</button>
											<span class="person_count">0</span>
											<button class="personInput_Btn perPlus">
												<span>
													<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
													style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
														<path d="m2 16h28m-14-14v28"></path>
													</svg>
												</span>
											</button>
										</div>
									</div>
									<hr>
									<div id="child" class="inputPerson_list">
										<div class="personDes">
											<p>어린이</p>
											<span>만 2 ~ 12세</span>
										</div>
										<div class="personCount">
											<button class="personInput_Btn perMinus">
												<span>
													<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
													style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
														<path d="m2 16h28"></path>
													</svg>
												</span>
											</button>
											<span class="person_count">0</span>
											<button class="personInput_Btn perPlus">
												<span>
													<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
													style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
														<path d="m2 16h28m-14-14v28"></path>
													</svg>
												</span>
											</button>
										</div>
									</div>
									<hr>
									<div id="animal" class="inputPerson_list">
										<div class="personDes">
											<p>반려동물</p>
										</div>
										<div class="personCount">
											<button class="personInput_Btn aniMinus">
												<span>
													<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
													style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
														<path d="m2 16h28"></path>
													</svg>
												</span>
											</button>
											<span class="animal_count">0</span>
											<button class="personInput_Btn aniPlus">
												<span>
													<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
													style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
														<path d="m2 16h28m-14-14v28"></path>
													</svg>
												</span>
											</button>
										</div>
									</div>
								</div>
							</td>
						</tr>
					</table>
					<button class="checkPossible" type="button">예약 여부 확인</button>
				</div>
				<%			
					}else{
				%>
				<div id="calTotalPriceCon">
					<div id="calPrice"></div>
					<table id="reserInfo">
						<tr>
							<td>
								<p>체크인</p>
								<input type='text' id="checkIn" value="<%= check_in%>" disabled/>
							</td>
							<td>
								<p>체크아웃</p>
				 				<input type='text' id="checkOut" value="<%= check_out%>" disabled/>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div class="inputPersonContainer">				
									<p>인원</p>
									<span id="person">게스트 추가</span>
								</div>
								<div id="inputPerson" >
									<div id="adult" class="inputPerson_list">
										<div class="personDes">
											<p>일반</p>
											<span>만13세 이상</span>
										</div>
										<div class="personCount">
											<button class="personInput_Btn perMinus">
												<span>
													<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
													style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
														<path d="m2 16h28"></path>
													</svg>
												</span>
											</button>
											<span class="person_count">0</span>
											<button class="personInput_Btn perPlus">
												<span>
													<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
													style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
														<path d="m2 16h28m-14-14v28"></path>
													</svg>
												</span>
											</button>
										</div>
									</div>
									<hr>
									<div id="child" class="inputPerson_list">
										<div class="personDes">
											<p>어린이</p>
											<span>만 2 ~ 12세</span>
										</div>
										<div class="personCount">
											<button class="personInput_Btn perMinus">
												<span>
													<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
													style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
														<path d="m2 16h28"></path>
													</svg>
												</span>
											</button>
											<span class="person_count">0</span>
											<button class="personInput_Btn perPlus">
												<span>
													<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
													style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
														<path d="m2 16h28m-14-14v28"></path>
													</svg>
												</span>
											</button>
										</div>
									</div>
									<hr>
									<div id="animal" class="inputPerson_list">
										<div class="personDes">
											<p>반려동물</p>
										</div>
										<div class="personCount">
											<button class="personInput_Btn aniMinus">
												<span>
													<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
													style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
														<path d="m2 16h28"></path>
													</svg>
												</span>
											</button>
											<span class="animal_count">0</span>
											<button class="personInput_Btn aniPlus">
												<span>
													<svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
													style="display: block; fill: none; height: 12px; width: 12px; stroke: currentcolor; stroke-width: 5.33333; overflow: visible;">
														<path d="m2 16h28m-14-14v28"></path>
													</svg>
												</span>
											</button>
										</div>
									</div>
								</div>
							</td>
						</tr>
					</table>
					<button class="reserBtn" type="button">예약 하기</button>
					<div id="schedulePrice">
					
					</div>
				</div>	
				<%
					}
				%>
			</div>
		</div>
		<br><hr>
		<div id="prodReview">
			<p class="title review" id="reviewTitle"></p>
			<div id="reviewContainer">
			</div>
		</div>
		<br><hr>
		<div id="hostInfo">
			<div id="hostName">
				<span class="material-icons" style="font-size:35px;">
						account_circle
				</span>
			</div>
			<div id="hostDate">
			</div>
			<div id="hostDes">
			</div>
			<p>응답률 : 96%</p>
			<p>응답 시간 : 1시간 이내</p>
			<button id="contact">호스트에게 연락하기</button>
		</div>
	</div>
</main>

<!-- signup modal -->
	<div class="modal" id="signUpForm">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">회원가입</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        <form class="was-validated">
			  <div class="form-group">
			    <label for="uname">이름:</label>
			    <input type="text" class="form-control" id="uname" placeholder="이름을 입력해주세요." name="uname" autocomplete="off" required>
			    <div class="valid-feedback">Valid.</div>
			    <div class="invalid-feedback">Please fill out this field.</div>
			  </div>
			  <div class="form-group">
			    <label for="uid">아이디:</label>
			    <input type="text" class="form-control" id="uid" placeholder="아이디를 입력해주세요." name="uid" autocomplete="off" required>
			    <div class="valid-feedback">Valid.</div>
			    <div class="invalid-feedback">Please fill out this field.</div>
			  </div>
			  <div class="form-group">
			    <label for="password">비밀번호:</label>
			    <input type="password" class="form-control" id="password" placeholder="8자~12자 사이" name="password" autocomplete="off" required>
			    <div class="valid-feedback">Valid.</div>
			    <div class="invalid-feedback">Please fill out this field.</div>
			  </div>
			  <div class="form-group">
			    <label for="pwdCheck">비밀번호 확인:</label>
			    <input type="password" class="form-control" id="pwdCheck" placeholder="비밀번호를 다시 입력해주세요." name="pwdCheck" autocomplete="off" required>
			    <div class="valid-feedback">Valid.</div>
			    <div class="invalid-feedback">Please fill out this field.</div>
			  </div>
			  <div class="form-group">
			    <label for="ubirth">생년월일:</label>
			    <input type="date" class="form-control" id="ubirth" name="ubirth" autocomplete="off" required>
			    <div class="valid-feedback">Valid.</div>
			    <div class="invalid-feedback">Please fill out this field.</div>
			  </div>
			  <div class="form-group">
			    <label for="email">email:</label>
			    <input type="text" class="form-control" id="email" placeholder="이메일을 입력해주세요." name="email" autocomplete="off" required>
			    <div class="valid-feedback">Valid.</div>
			    <div class="invalid-feedback">Please fill out this field.</div>
			  </div>
			  <div class="form-group">
			    <label for="tel">전화번호:</label>
			    <input type="text" class="form-control" id="tel" placeholder="전화번호를 입력해주세요." name="tel" autocomplete="off" required>
			    <div class="valid-feedback">Valid.</div>
			    <div class="invalid-feedback">Please fill out this field.</div>
			  </div>
			  <div class="form-group">
			    <label for="addr">주소:</label>
			    <input type="text" class="form-control" id="addr" placeholder="주소를 입력해주세요." name="addr" autocomplete="off" required>
			    <div class="valid-feedback">Valid.</div>
			    <div class="invalid-feedback">Please fill out this field.</div>
			  </div>
			  <div class="form-group">
			    <label for="findPwdAns">비밀번호 힌트</label>
			    <select name="findPwd" id="findPwd">
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
			    </select>
			    <input type="text" class="form-control" id="findPwdAns" placeholder="질문의 정답을 입력해주세요." name="findPwdAns" autocomplete="off" required>
			    <div class="valid-feedback">Valid.</div>
			    <div class="invalid-feedback">Please fill out this field.</div>
			  </div>
			  <div class="form-group">
			  	<div id="captchaImg">
			  		<img src="../captchaImg/1650083349174.jpg"/>
			  	</div>
			  	<br>
			  	 <input type="text" class="form-control" id="imgAnswer" placeholder="이미지속 글자를 입력해주세요." name="imgAnswer" autocomplete="off" required>
			  </div>
			  <button type="button" class="btn btn-primary" id="signUpBtn">회원가입</button>
			</form>
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	<!-- login modal -->
	<div class="modal" id="loginForm">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">로그인</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	        <form>
			  <div class="form-group">
			    <label for="loginId">아이디:</label>
			    <input type="text" class="form-control" placeholder="Enter email" id="loginId" autocomplete="off">
			  </div>
			  <div class="form-group">
			    <label for="loginPwd">비밀번호:</label>
			    <input type="password" class="form-control" placeholder="Enter password" id="loginPwd" autocomplete="off">
			  </div>
			  <div class="form-group form-check">
			    <label class="form-check-label">
			      <input class="form-check-input" type="checkbox"> 아이디 기억하기
			    </label>
			  </div>
			  <button type="button" class="btn btn-primary" id="loginBtn">로그인</button>
			  <a class="btn btn-warning" style="margin-left: 100px;" data-toggle="modal" href="#findIdForm" id="findId" >아이디 찾기</a>
			  <a class="btn btn-warning" data-toggle="modal" href="#findPwdForm">비밀번호 찾기</a>
			  
			  <ul>			  
				<li onclick="kakaoLogin();">
			      <a href="javascript:void(0)">
			          <img alt="" src="../image/kakao_login_medium_wide.png">
			      </a>
				</li>
				<li onclick="kakaoLogout();">
			      <a href="javascript:void(0)">
			          <span>카카오 로그아웃</span>
			      </a>
				</li>
			  </ul>
			  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	<!-- findId Modal -->
	<div class="modal" id="findIdForm" data-backdrop="static">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">아이디 찾기</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	        <form action="">
			  <div class="form-group">
			    <label for="uname">이름</label>
			    <input type="text" class="form-control" placeholder="이름을 입력하세요" id="uname" autocomplete="off">
			  </div>
			  <div class="form-group">
			    <label for="tel">전화번호</label>
			    <input type="text" class="form-control" placeholder="전화번호를 입력하세요" id="tel" autocomplete="off">
			  </div>
			  <button type="button" class="btn btn-primary" id="findIdBtn">찾기</button>		  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	<!-- findPwd Modal -->
	<div class="modal" id="findPwdForm" data-backdrop="static">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">비밀번호 찾기</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	        <form action="">
			  <div class="form-group">
			    <label for="uname">이름</label>
			    <input type="text" class="form-control" placeholder="이름을 입력하세요" id="uname" autocomplete="off">
			  </div>
			  <div class="form-group">
			    <label for="uid">아이디</label>
			    <input type="text" class="form-control" placeholder="아이디를 입력하세요" id="uid" autocomplete="off">
			  </div>
			  <div class="form-group">
			    <label>힌트</label>
			    <input type="text" class="form-control" placeholder="질문에 대한 정답을 입력하세요" id="answer" autocomplete="off">
			  </div>
			  <button type="button" class="btn btn-primary" id="findPwdBtn">찾기</button>		  
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
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
</html>