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
					<li class="nli first" id="nav1_1">
						<span>
							<a target="_blank" href="${pageContext.request.contextPath }/index.jsp">首页</a>
						</span>
					</li>
					
					<li class="nli first" id="nav1_1">
						<span>
							<a target="_blank" href="${pageContext.request.contextPath }/people.jsp">人像</a>
						</span>
					</li>
					
					<li class="nli" id="nav1_2">
						<span>
							<a target="_blank" href="${pageContext.request.contextPath }/plants.jsp">植物</a>
						</span>
					</li>
					<li class="nli" id="nav1_3"><span><a target="_blank"
							href="${pageContext.request.contextPath }/animals.jsp">动物</a></span></li>

					<li class="nli" id="nav1_4"><span><a target="_blank"
							href="${pageContext.request.contextPath }/defogging.jsp">去雾</a></span></li>

					<li class="nli" id="nav1_5"><span><a target="_blank"
							href="${pageContext.request.contextPath }/qualityEnhance.jsp">放大</a></span></li>

					<li class="nli" id="nav1_6"><span><a target="_blank"
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
		<div class="c_0100_2">
			<div class="container">
				<div class="tit_1">
					<h3 class="wow fadeInUp">Picture Catelogy</h3>
					<h4 class="wow fadeInUp" data-wow-delay="0.2s">图像处理/选择你需要的种类</h4>
				</div>
				<div class="row_2">
					<ul class="ul_1">
					
					
					<li class="wow fadeInUp">
							<div class="zbox">
								<div class="img" data-href="javascript:void(0);">
									<img alt="" src="images/face.PNG" width="100%">
									<div class="bian"></div>
									<div class="name elli">人像</div>
									<div class="p">在你面前我很傻，疯疯癫癫到天涯。</div>
									<div class="more">
										<a href="${pageContext.request.contextPath }/people.jsp"><img alt="" src="images/btn3.png"></a>
									</div>
								</div>
								<div class="title">
									<h4 data-href="javascript:void(0)">
										<a href="javascript:;" class="elli">人像</a>
										<!-- <span><img alt="" src="images/64145427964285.png"></span> -->
									</h4>
									<div class="p">
										<div class="p_l">
											  <script
													src="./c(1).aspx"></script></span> <script
													src="./zan_case(2).aspx"></script></span> <span><div
													class="bshare-custom">
													<div class="bsPromo bsPromo2"></div>
													 
												</div></span>
										</div>
										 
									</div>
								</div>
							</div>
						</li>

						<li class="wow fadeInUp">
							<div class="zbox">
								<div class="img" data-href="javascript:void(0)">
									<img alt="图伽汽车科技" src="images/11912080.jpg" width="100%">
									<div class="bian"></div>
									<div class="name elli">植物</div>
									<div class="p">娇艳欲滴的花朵</div>
									<div class="more">
										<a href="${pageContext.request.contextPath }/plants.jsp"><img alt="" src="images/btn3.png"></a>
									</div>
								</div>
								<div class="title">
									<h4 data-href="javascript:void(0)">
										<a href="javascript:;" class="elli">植物</a>
									</h4>
									<div class="p">
										<div class="p_l">
											<span> <script src="images/c.aspx"></script></span> <span>
													<script
													src="images/zan_case.aspx"></script></span> <span><div
													class="bshare-custom">
													<div class="bsPromo bsPromo2"></div>
												
												</div></span>
										</div>
									
									</div>
								</div>
							</div>
						</li>
						
						<li class="wow fadeInUp">
							<div class="zbox">
								<div class="img" data-href="javascript:void(0)">
									<img alt="北京乐益口腔健康品牌" src="images/11845961.jpg" width="100%">
									<div class="bian"></div>
									<div class="name elli">动物</div>
									<div class="p">守候着，陪伴着你的一生</div>
									<div class="more">
										<a href="${pageContext.request.contextPath }/animals.jsp"><img alt="" src="images/btn3.png"></a>
									</div>
								</div>
								<div class="title">
									<h4 data-href="javascript:void(0)">
										<a href="javascript:;" class="elli">动物</a>
										<!-- <span><img alt="" src="images/116985794.png"></span> -->
									</h4>
									<div class="p">
										<!-- <div class="p_l">
											<span><img alt="" src="images/ico3_2.png"> <script
													src="./c(4).aspx"></script></span>
										</div> -->
										<div class="p_l">
										  <script
													src="./c(3).aspx"></script></span>   <script
													src="./zan_case(4).aspx"></script></span> <span><div
													class="bshare-custom">
													<div class="bsPromo bsPromo2"></div>
													 
												</div></span>
										</div>
										 
									</div>
								</div>
							</div>
						</li>

						<li class="wow fadeInUp">
							<div class="zbox">
								<div class="img" data-href="javascript:void(0);">
									<img alt="东大建筑设计集团" src="images/11786146.jpg" width="100%">
									<div class="bian"></div>
									<div class="name elli">去雾</div>
									<div class="p">不要怕，我们大多数遇见的人，只是看起来很厉害而已。</div>
									<div class="more">
										<a href="${pageContext.request.contextPath }/defogging.jsp"><img alt="" src="images/btn3.png"></a>
									</div>
								</div>
								<div class="title">
									<h4 data-href="javascript:void(0)">
										<a href="javascript:;" class="elli">去雾</a>
									</h4>
									<div class="p">
										<div class="p_l">
											 <script
													src="images/zan_case(1).aspx"></script></span> <span><div
													class="bshare-custom">
													<div class="bsPromo bsPromo2"></div>
													
												</div></span>
										</div>
										
									</div>
								</div>
							</div>
						</li>

						

						<li class="wow fadeInUp">
							<div class="zbox">
								<div class="img" data-href="javascript:void(0)">
									<img alt="北京声达木业有限公司" src="images/1005319.jpg" width="100%">
									<div class="bian"></div>
									<div class="name elli">无损放大</div>
									<div class="p">我们总回忆过去，因为在现实面前一筹莫展。</div>
									<div class="more">
										<a href="${pageContext.request.contextPath }/qualityEnhance.jsp"><img alt="" src="images/btn3.png"></a>
									</div>
								</div>
								<div class="title">
									<h4 data-href="javascript:void(0)">
										<a href="javascript:;" class="elli">无损放大</a>
									</h4>
									<div class="p">
										<div class="p_l">
											 <script
													src="./c(2).aspx"></script></span>   <script
													src="./zan_case(3).aspx"></script></span> <span><div
													class="bshare-custom">
													<div class="bsPromo bsPromo2"></div>
													 
												</div></span>
										</div>
										 
									</div>
								</div>
							</div>
						</li>

						<li class="wow fadeInUp">
							<div class="zbox">
								<div class="img" data-href="javascript:void(0)">
									<img alt="大智金科" src="images/14554088.jpg" width="100%">
									<div class="bian"></div>
									<div class="name elli">对比增强</div>
									<div class="p">我在杯子里看到你的容颜，却已是匆匆那年。</div>
									<div class="more">
										<a href="${pageContext.request.contextPath }/contrastEnhance.jsp"><img alt="" src="images/btn3.png"></a>
									</div>
								</div>
								<div class="title">
									<h4 data-href="javascript:void(0)">
										<a href="javascript:;" class="elli">对比增强</a>
									</h4>
									<div class="p">
										<div class="p_l">
										  <script
													src="./c(3).aspx"></script></span>  <script
													src="./zan_case(4).aspx"></script></span> <span><div
													class="bshare-custom">
													<div class="bsPromo bsPromo2"></div>
													 
												</div></span>
										</div>
										 
									</div>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>