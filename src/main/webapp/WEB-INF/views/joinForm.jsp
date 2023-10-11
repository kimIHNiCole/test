<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
    table, th, td{
        border: 1px solid black;
        border-collapse: collapse;
        padding: 5px 10px;
    }
</style>
</head>
<body>
     <table>
         <tr>
             <th>아이디</th>
             <th>
                 <input type="text" name="id"/>
                 <input type="button" id="overlay" value="ID 중복 체크">
             </th>
         </tr>
			<tr>
				<th>관리자</th>
				<td><input type="checkbox" name="auth" />관리자 여부</td>
			</tr>
			<tr>
             <th>비밀번호</th>
             <th>
                 <input type="password" name="pw"/>
             </th>
         </tr>
         <tr>
             <!--공백문자-->
             <th>이&nbsp;&nbsp;&nbsp;름</th>
             <th>
                 <input type="text" name="name"/>
             </th>
         </tr>
         <tr>
             <th>나&nbsp;&nbsp;&nbsp;이</th>
             <th>
                 <input type="text" name="age"/>
             </th>
         </tr>
         <tr>
             <th>이메일</th>
             <th>
                 <input type="email" name="email"/>
             </th>
         </tr>
         <tr>
             <th>성&nbsp;&nbsp;&nbsp;별</th>
             <th>
                 <input type="radio" name="gender" value="남"/>남자
                 <input type="radio" name="gender" value="여"/>여자
             </th>
         </tr>
         <tr>
             <th colspan="2">
                 <input type="button" id="join" value="회원가입"/>
             </th>
         </tr>
     </table>
</body>
<script>
var overlayChk = false;

$('#join').on('click',function(){
	//id,pw,name,age,gender,email,author 가져오기
	// $가 붙으면 jquery 로 불러온 게 들어 있다는 약속
	var $id= $('input[name="id"]');
	var $pw= $('input[name="pw"]');
	var $name=$('input[name="name"]');
	var $age=$('input[name="age"]');
	var $gender=$('input[name="gender"]:checked');
	var $email=$('input[name="email"]');
	var $auth=$('input[name="auth"]:checked');
	
	console.log($id,"/",$pw,"/",$name,"/",$age,"/",$gender,"/",$email,"/",$auth);
	
	if(overlayChk){ // 아이디 중복 체크를 하고 나서야 다음 검사를 시작
		
		if($id.val() == ''){
			alert('아이디를 입력해 주세요!');
			$id.focus();
		}else if($pw.val() == ''){
			alert('비밀번호를 입력해 주세요!');
			$pw.focus();
		}else if($name.val() == ''){
			alert('이름을 입력해 주세요!');
			$name.focus();
		}else if($age.val() == '' ){
			alert('나이를 입력해 주세요!');
			$age.focus();
		}else if($gender.val()==null){
			alert('성별을 입력해 주세요!');
			$gender.focus();
		}else if($email.val()==''){
			alert('email 을 입력해 주세요!');
			$email.focus();
		}else{
			//모두 입력되었으면 받아온 값을 서버에 전송한다.
			var param ={};
			param.id = $id.val();
			param['pw']=$pw.val();
			param.name=$name.val();
			// 나이에 문자(알파벳)가 섞여 있을 경우 처리
			var regex = new RegExp('[a-zA-Zㄱ-ㅎ가-힣]');
			var match=regex.test($age.val()); // 패턴이 일치하면 true, 아니면 false
			console.log("match"+match);
			if(match){
				alert('숫자만 넣어주세요!');
				return false;
			}
			param.age= $age.val();
			
			param.gender=$gender.val();
			param.email=$email.val();
			if($auth.val() !=null){
				param.auth=$auth.val();
			}
			console.log(param);
			
			$.ajax({
				type:'post',
				url:'join',
				data:param,
				dataType:'JSON',
				success:function(data){
					// ajax 방식은 요청과 응답이 모두 같은 페이지에서 일어난다.
					// 그래서 요청 후 결과값을 다른 페이지에서 받아야 한다면 적합하지 않다.
					console.log(data);
					if(data.success>0){
						alert('회원 가입에 성공했습니다.');
						location.href='./'; //ajax 에서는 이렇게 view 에서 다른 페이지로 이동시켜 줘야 한다.
					}else{
						alert('회원가입에 실패했습니다.');
					}
				},
				error:function(e){
					console.log(e);
				}
			});
		}
	}else{
		alert('아이디 중복 체크를 해주세요!');
	}
});

$('#overlay').on('click', function(){
	var id= $('input[name="id"]').val();
	console.log('id='+id);
	// location.href='overlay?id='+id; // 동기 방식
	
	$.ajax({
		type:'get', // get|post
		url:'overlay', //action
		data:{'id':id}, // parameter
		dataType:'JSON', // 반환받을 데이터 형태(JSON,TEXT,HMLM,XML)
		success:function(data){
			console.log(data);
			overlayChk = data.use;
			if(data.use){
				alert('사용 가능한 아이디입니다.');
			}else{
				alert('이미 사용 중인 아이디입니다.');
				$('input[name="id"]').val('');
			}
		}, // 성공했을 경우 실행할 함수(결과값은 매개변수로 들어온다.)
		error:function(error){
			console.log(error);
		}, // 실패했을 경우(에러 정보)
	});
	
});

</script>
</html>