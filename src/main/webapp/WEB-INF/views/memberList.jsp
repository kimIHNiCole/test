<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
 <style>
 table, th, td{
 	border: 2px solid black;
 	border-collapse: collapse;
 	padding: 5px 10px;
 }
 </style>
</head>
<body>
 	<h3>회원 리스트</h3>
	<table>	
	<thead>
 		<tr>
 			<th>아이디</th>
 			<th>이름</th>
 			<th>이메일</th>
 		</tr>
 		</thead>
 		<tbody id="list" >
 		</tbody>
 	</table>
</body>
<script>
	// 1. member 들의 리스트를 ajax 로 요청해 온다.
	// 2. 그리고 console.log() 로 찍어본다.
	$.ajax({
				type:'get',
				url:'mList',
				data:{},
				dataType:'JSON',
				success:function(data){
					console.log(data);
					if(data.success == -1){
						alert("이 페이지의 권한이 없습니다.");
						location.href = './';
					}else{
						var content='';
						for(var i=0; i < data.size; i++){
							content +='<tr>';
							content +='<td>'+data.mList[i].id+'</td>';
							content +='<td>'+data.mList[i].name+'</td>';
							content +='<td>'+data.mList[i].email+'</td>';
							content +='</tr>';
						}
						$('#list').append(content);
					}
					/*
					var str = '<tr>';
                    $.each(data, function(i){// 3. 그다음 그려야 한다.
                        str += 
                        	   '<th>' + data[i].id + '</th>'+
                        	   '<td>' + data[i].name + '</td>'+
                        	   '<td>' + data[i].email + '</td>'
                        str += '</tr>';
                    });
                $('#list').append(str);
                */
				},
				error:function(e){
					console.log(e);
				}
			});
</script>
</html>