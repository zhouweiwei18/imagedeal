<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta name="format-detection" content="telephone=no">
<title></title>
<meta name="keywords" content=" ">
<meta name="description" content=" ">

<!--首页动态效果样式-->
<link href="css/animate.css" rel="stylesheet">
<!--首页动态效果样式end-->
<!--首页banner效果样式-->
<link href="css/global.css" rel="stylesheet">
<link href="css/fix.css" rel="stylesheet">
<!--首页banner效果样式end-->

<link href="css/bootstrap.css" rel="stylesheet">
<link href="http://www.bootcss.com/p/buttons/css/buttons.css" rel="stylesheet">
<link href="css/slick.css" rel="stylesheet">
<link href="css/slick-theme.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script src="js/checkform.js"></script>
<style type="text/css">
        .content {
            color: #ffffff;
            font-size: 40px;
        }
        .bg {
            background: url('images/girlface.jpg');
            height:670px;
            text-align: center;
            line-height: 900px;
        }
        .bg-blur {
            float: left;
            width: 100%;
            background-repeat: no-repeat;
            background-position: center;
            background-size: cover;
            -webkit-filter: blur(15px);
            -moz-filter: blur(15px);
            -o-filter: blur(15px);
            -ms-filter: blur(15px);
            filter: blur(15px);
        }
        .content-front {
          position:absolute;
          left: 10px;
          right: 10px;
          height:600px;
          line-height: 600px;
          text-align: center;
        }
    </style>
</head>
<body>
	<div class="top visible-lg">
		<div class="container">
			<div class="menu">
				<ul>
				<li class="nli first" id="nav1_1">
						<span>
							<a target="_self" href="index.jsp">首页</a>
						</span>
					</li>
					<li class="nli first" id="nav1_1"><span><a
							target="_self" href="${pageContext.request.contextPath }/people.jsp">人像</a></span></li>
					<li class="nli" id="nav1_2"><span>
					<a target="_self" href="${pageContext.request.contextPath }/plants.jsp">植物</a></span>
					</li>
					<li class="nli" id="nav1_3"><span><a target="_self"
							href="${pageContext.request.contextPath }/animals.jsp">动物</a></span></li>

					<li class="nli" id="nav1_4"><span><a target="_self"
							href="${pageContext.request.contextPath }/defogging.jsp">去雾</a></span></li>

					<li class="nli" id="nav1_5"><span><a target="_self"
							href="${pageContext.request.contextPath }/qualityEnhance.jsp">放大</a></span></li>

					<li class="nli" id="nav1_6"><span><a target="_self"
							href="${pageContext.request.contextPath }/contrastEnhance.jsp">对比</a></span></li>

					<!-- 用户没有登录 -->
					<c:if test="${empty user}">
						<li class="nli" id="nav1_7"><span><a target="_self"
								href="login.jsp">登录</a></span></li>
						<li class="nli" id="nav1_7"><span><a target="_self"
								href="reg.jsp">注册</a></span></li>
					</c:if>
					<!-- 用户已经登录 -->
					<c:if test="${!empty user}">

						<li class="nli" id="nav1_7"><span style="font-style: italic;"><a
								target="_self" href="javascript:void(0);">${user.username }</a></span></li>
						<li class="nli" id="nav1_7"><span><a target="_self"
								href="javascript:void(0);">退出</a></span></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
	<div class="pz_main">
		<script>
			$('.z_ul1 li').each(function() {
				var num = $(this).index();
				$(this).attr('data-wow-delay', num * 0.2 + 's');
			})
		</script>
		
	</div>
	<div class="bg bg-blur"></div>
	
	<div style="width: 599px;float: left;margin-left: 80px;margin-top: 100px;position:absolute;">
		<img alt="" src="images/girlface.jpg" style="border-radius:10px;">
		<br>
	 	<br>
		<div style="float: left;margin-left: 215px;margin-top: 18px;"></div>
		<a class="button button-glow button-border button-rounded button-primary">选择图片</a>
	</div>
	
	<div style="float: right;position:absolute;margin-left: 850px;margin-top: 130px;">
		<table id="info" class="table table-hover" style="text-align: center;width: 200px;float:right;">
		</table>
	</div>
	
	<script type="text/javascript">
		$(function() {
			$.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath }/face/faceIdent.action",
				data : {},//json序列化       这里对应的是图片的路径
				async : false,//这里必须要同步
				datatype : "json", //此处不能省略 
				contentType : "application/json; charset=utf-8",//此处不能省略 
				success : function(data) {
					var tab = $("#info");
					
					//alert("数据接收成功！");
					
					 $.each(data['result'].face_list, function(i, item) {
						 //alert(data.result[i].score);
						 //alert(data.result[i].name);
					     //alert(data.result[i].baike_info.baike_url);
						 //alert(data.result[i].baike_info.description);
						 //下面将数据写入页面
						 //获取表格
					
						 var age = data.result.face_list[i].age ;
						 
						 var sex = data.result.face_list[i].gender.type;
						 if(sex=='female'){
							 sex=sex.replace(/female/, "女性");
						 }else{
							 sex=sex.replace(/male/, "男性");
						 }
						 
						 var race = data.result.face_list[i].race.type;
						 if(race=='yellow'){
							 race=race.replace(/yellow/, "黄种人");
						 }else if(race=='white'){
							 race=race.replace(/white/, "白种人");
						 }
						 
						 var beauty = data.result.face_list[i].beauty;
						 
						 var emotion = data.result.face_list[i].emotion.type;
						 if(emotion=='happy'){
							 emotion=emotion.replace(/happy/, "高兴");
						 }else if(emotion=='none'){
							 emotion=emotion.replace(/none/, "无情绪");
						 }
						 
						 var glasses = data.result.face_list[i].glasses.type;
						 if(glasses=='none'){
							 glasses=glasses.replace(/none/, "无眼镜");
						 }else if(glasses=='common'){
							 glasses=glasses.replace(/common/, "普通眼镜");
						 }
						 
						 var expression = data.result.face_list[i].expression.type;
						 if(expression=='none'){
							 expression=expression.replace(/none/, "不笑");
						 }else if(expression=='smile'){
							 expression=expression.replace(/smile/, "微笑");
						 }
						 
						 var trs = 
							"<tr >"+"<td class='td1'>年龄:</td><td class='td2'>"+age+"岁</td>"+"</tr>"+
	 						"<tr >"+"<td class='td1'>性别:</td><td class='td2'>"+sex+"</td>"+"</tr>"+
						 	"<tr >"+"<td class='td1'>种族:</td><td class='td2'>"+race+"</td>"+"</tr>"+
							"<tr >"+"<td class='td1'>颜值:</td><td class='td2'>"+beauty+"</td>"+"</tr>"+
							"<tr >"+"<td class='td1'>情绪:</td><td class='td2'>"+emotion+"</td>"+"</tr>"+
							"<tr >"+"<td class='td1'>眼镜:</td><td class='td2'>"+glasses+"</td>"+"</tr>"+
							"<tr >"+"<td class='td1'>表情:</td><td class='td2'>"+expression+"</td>"+"</tr>"	;

						tab.append(trs);
					});
				},
				error : function(data) {
					alert("error");
				}
			})
		})
	</script>
</body>
</html>