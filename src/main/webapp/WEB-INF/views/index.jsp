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
    
    input[type="submit"]{
    	height: 50px;
    }    
</style>
</head>
<body>
	<h2>LOGIN</h2>
	<hr/>
	    <table>
	        <tr>
	            <th>ID</th>
	            <th>
	                <input type="text" name="id" value="" placeholder="아이디를 입력하세요"/>
	            </th>
	            <th rowspan="2">
	                <input type="button" id="login" value="login"/>
	            </th>
	        </tr>
	        <tr>
	            <th>PW</th>
	            <th>
	                <input type="password" name="pw" value="" placeholder="비밀번호를 입력하세요"/>
	            </th>                
	        </tr>
	        <tr>
	            <th colspan="3">
	                <input id="regist" type="button" value="회원가입"/>
	                <input type="button" value="아이디/비번 찾기"/>
	            </th>    
	        </tr>
	    </table>
</body>
<script>
	$('#regist').on('click',function(){
		location.href='joinForm';
	});
	
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	
	// 1. ajax 방식으로 로그인 요청
	
$('#login').on('click',function(){
		var id = $('input[name="id"]').val();
		var pw = $('input[name="pw"]').val();
		console.log(id+"/"+pw);
		
		$.ajax({
			type:'post',
			url:'login',
			data:{'id':id, 'pw':pw},
			dataType:'JSON',
			success:function(data){
				console.log(data);
				alert(data.msg);
				if(data.id != null){
					if(data.perm != null){
						location.href = 'memberList';
					}else{
						location.href = 'boardList';
					}
				}
			},
			error:function(e){
				console.log(e);
			}
		});	
});
	
	// 2. 결과 값에 따라 관리자(admin) 일 경우 memberList 보여 줄 것
	// ** ajax 는 페이지를 이동하면서 데이터를 전달할 수 없다.
	// ** 특정 페이지에 먼저 와서, 그 페이지에서 데이터를 요청해서 받은 다음 그려야 한다.


</script>
</html>