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
<link href="css/slick.css" rel="stylesheet">
<link href="css/slick-theme.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
<script src="js/checkform.js"></script>

</head>
<body>
	<div class="top visible-lg">
		<div class="container">
			<div class="menu">
				<ul>
					<li class="nli first" id="nav1_1"><span><a
							target="_self" href="javascript:void(0)">人像</a></span></li>
					<li class="nli" id="nav1_2"><span> <a target="_blank"
							href=plants.jsp>植物</a></span></li>
					<li class="nli" id="nav1_3"><span><a target="_blank"
							href=animals.jsp>动物</a></span></li>

					<li class="nli" id="nav1_4"><span><a target="_blank"
							href=scenery.jsp>风景</a></span></li>

					<li class="nli" id="nav1_5"><span><a target="_blank"
							href=stilllife.jsp>静物</a></span></li>

					<li class="nli" id="nav1_6"><span><a target="_blank"
							href=home.jsp>家居</a></span></li>

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
	<h4 align=center>植物</h4>
	
	
	

	<script type="text/javascript">
	alert("ajax");
	$(function() {
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath }/plants/plantsIdent.action",
			data : {},//json序列化       这里对应的是图片的id
			async : false,//这里必须要同步
			datatype : "json", //此处不能省略 
			contentType : "application/json; charset=utf-8",//此处不能省略 
			success : function(data) {
				alert("数据接收成功！");
				/*这是数据格式
				"result": [{
					"score": 0.99979120492935,
					"name": "莲",
					"baike_info": {
						"baike_url": "http://baike.baidu.com/item/%E8%8E%B2/2717141",
						"description": "莲(Nelumbo nucifera)，又称荷、荷花、莲花、芙蕖、鞭蓉、水芙蓉、水芝、水芸、水旦、水华等，溪客、玉环是其雅称，未开的花蕾称菡萏，已开的花朵称鞭蕖，莲科，属多年生水生宿根草本植物，其地下茎称藕，能食用，叶入药，莲子为上乘补品，花可供观赏。是我国十大名花之一。是印度的国花。莲，双子叶植物，睡莲科。多年生挺水草本植物。根状茎横走，粗而肥厚，节间膨大，内有纵横通气孔道，节部缢缩。叶基生，挺出水面，盾形，直径30-90cm，波状边缘，上面深绿色，下面浅绿色。叶柄有小刺，长1-2m，挺出水面。花单生，直径10-25cm，椭圆花瓣多数，白色或粉红色；花柄长1-2m。花托在果期膨大，直径5-10cm，海绵质。坚果椭圆形和卵圆形，长1.5-2.0cm，灰褐色。种子卵圆形，长1.2-1.7cm，种皮红棕色。生于池塘、浅湖泊及稻田中。中国南北各省有自生或栽培，经济价值高。人们习惯上称种子为“莲子”、地下茎为“藕”、花托为“莲蓬”、叶为“荷叶”。"
					}
				},
				{
					"score": 0.00015144718054216,
					"name": "红睡莲"
				},
				{
					"score": 1.2172759852547e-05,
					"name": "白睡莲"
				},
				{
					"score": 6.305016540864e-06,
					"name": "延药睡莲"
				},
				{
					"score": 3.6133328649157e-06,
					"name": "华夏慈姑"
				}]
				*/
				
				
				
				
				
				
				
				
				
				if (data.length > 0) {
					alert("数据接收成功！");
				}
			},
			error : function(data) {
				alert("error");
			}
		})
	});
	</script>

</body>
</html>