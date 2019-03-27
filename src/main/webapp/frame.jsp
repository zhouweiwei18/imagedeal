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
							target="_self" href="javascript:void(0)">首页</a></span></li>
					<li class="nli" id="nav1_2"><span><a target="_self"
							href="javascript:void(0)">产品&amp;服务</a></span>
						<div class="sub">
							<div class="container">
								<div class="c_378">
									<h2>产品&amp;服务</h2>
									<h3>Products&amp;Services</h3>
									<div class="bian"></div>
								</div>
								<ul class="ul1">
									<li class="l1"><a target="_self" href="javascript:void(0)">
											<div class="ico">
												<img src="images/ico1_12589561.png" alt="产品&amp;服务"
													class="img_1"> <img src="images/ico1_1_h6054932.png"
													alt="产品&amp;服务" class="img_2">
											</div>
											<h4>网站建设</h4>
									</a></li>
									<li class="l1"><a target="_self" href="javascript:void(0)">
											<div class="ico">
												<img src="images/ico1_29788755.png" alt="产品&amp;服务"
													class="img_1"> <img src="images/ico1_2_h5422278.png"
													alt="产品&amp;服务" class="img_2">
											</div>
											<h4>SEO排名</h4>
									</a></li>
									<li class="l1"><a target="_self" href="javascript:void(0)">
											<div class="ico">
												<img src="images/ico1_32337037.png" alt="产品&amp;服务"
													class="img_1"> <img src="images/ico1_3_h6584472.png"
													alt="产品&amp;服务" class="img_2">
											</div>
											<h4>软文营销</h4>
									</a></li>

									<li class="l1"><a target="_self" href="javascript:void(0)">
											<div class="ico">
												<img src="images/ico1_46812594.png" alt="产品&amp;服务"
													class="img_1"> <img src="images/ico1_4_h4308426.png"
													alt="产品&amp;服务" class="img_2">
											</div>
											<h4>域名空间</h4>
									</a></li>

									<li class="l1"><a target="_self" href="javascript:void(0)">
											<div class="ico">
												<img src="images/ico1_53967141.png" alt="产品&amp;服务"
													class="img_1"> <img src="images/ico1_5_h2603855.png"
													alt="产品&amp;服务" class="img_2">
											</div>
											<h4>网站认证</h4>
									</a></li>

									<li class="l1"><a target="_self" href="javascript:void(0)">
											<div class="ico">
												<img src="images/ico1_68137942.png" alt="产品&amp;服务"
													class="img_1"> <img src="images/ico1_6_h5676011.png"
													alt="产品&amp;服务" class="img_2">
											</div>
											<h4>物联平台</h4>
									</a></li>
								</ul>
							</div>
						</div></li>
					<li class="nli" id="nav1_3"><span><a target="_self"
							href="javascript:void(0);">方案&amp;报价</a></span></li>

					<li class="nli" id="nav1_4"><span><a target="_self"
							href="javascript:void(0);">网站案例</a></span></li>

					<li class="nli" id="nav1_5"><span><a target="_self"
							href="javascript:void(0);">互联网课堂</a></span></li>

					<li class="nli" id="nav1_6"><span><a target="_self"
							href="javascript:void(0);">十七缘起</a></span></li>

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
					<h3 class="wow fadeInUp">brand case</h3>
					<h4 class="wow fadeInUp" data-wow-delay="0.2s">品牌案例 /
						用设计帮助企业创造更大的商业价值</h4>
				</div>
				<div class="row_2">
					<ul class="ul_1">

						<li class="wow fadeInUp">
							<div class="zbox">
								<div class="img" data-href="javascript:void(0)">
									<img alt="图伽汽车科技" src="images/9522327.jpg" width="100%">
									<div class="bian"></div>
									<div class="name elli">图伽汽车科技</div>
									<div class="p">你只想要酒桌上的迷离，却没在意是谁把你扶起。</div>
									<div class="more">
										<a href="javascript:;"><img alt="" src="images/btn3.png"></a>
									</div>
								</div>
								<div class="title">
									<h4 data-href="javascript:void(0)">
										<a href="javascript:;" class="elli">图伽汽车科技</a>
										<!-- <span><img
											alt="" src="images/12987083479469.png"></span> -->
									</h4>
									<div class="p">
										<div class="p_l">
											<span><img alt="" src="images/ico3_2.png"> <script
													src="images/c.aspx"></script></span> <span><img alt=""
												src="images/ico3_3.png"> <script
													src="images/zan_case.aspx"></script></span> <span><div
													class="bshare-custom">
													<div class="bsPromo bsPromo2"></div>
													<a title="更多平台"
														class="bshare-more bshare-more-icon more-style-addthis"><img
														alt="" style="height: 100%" src="images/ico3_4.png"></a>
												</div></span>
										</div>
										<div class="p_r">
											<a href="javascript:void(0);"><img alt=""
												src="images/ico3_5.png"></a>
										</div>
									</div>
								</div>
							</div>
						</li>

						<li class="wow fadeInUp">
							<div class="zbox">
								<div class="img" data-href="javascript:void(0);">
									<img alt="东大建筑设计集团" src="images/2582330.jpg" width="100%">
									<div class="bian"></div>
									<div class="name elli">东大建筑设计集团</div>
									<div class="p">不要怕，我们大多数遇见的人，只是看起来很厉害而已。</div>
									<div class="more">
										<a href="javascript:;"><img alt="" src="images/btn3.png"></a>
									</div>
								</div>
								<div class="title">
									<h4 data-href="javascript:void(0)">
										<a href="javascript:;" class="elli">东大建筑设计集团</a>
										<!-- <span><img
											alt="" src="images/45411698740906.png"></span> -->
									</h4>
									<div class="p">
										<div class="p_l">
											<span><img alt="" src="images/ico3_2.png">965</span> <span><img
												alt="" src="images/ico3_3.png"> <script
													src="images/zan_case(1).aspx"></script></span> <span><div
													class="bshare-custom">
													<div class="bsPromo bsPromo2"></div>
													<a title="更多平台"
														class="bshare-more bshare-more-icon more-style-addthis"><img
														alt="" style="height: 100%" src="images/ico3_4.png"></a>
												</div></span>
										</div>
										<div class="p_r">
											<a href="javascript:void(0);"><img alt=""
												src="images/ico3_5.png"></a>
										</div>
									</div>
								</div>
							</div>
						</li>

						<li class="wow fadeInUp">
							<div class="zbox">
								<div class="img" data-href="javascript:void(0);">
									<img alt="君搜宝官网" src="images/9492988.jpg" width="100%">
									<div class="bian"></div>
									<div class="name elli">君搜宝官网</div>
									<div class="p">在你面前我很傻，疯疯癫癫到天涯。</div>
									<div class="more">
										<a href="javascript:;"><img alt="" src="images/btn3.png"></a>
									</div>
								</div>
								<div class="title">
									<h4 data-href="javascript:void(0)">
										<a href="javascript:;" class="elli">君搜宝官网</a>
										<!-- <span><img alt="" src="images/64145427964285.png"></span> -->
									</h4>
									<div class="p">
										<div class="p_l">
											<span><img alt="" src="images/ico3_2.png"> <script
													src="./c(1).aspx"></script></span> <span><img alt=""
												src="images/ico3_3.png"> <script
													src="./zan_case(2).aspx"></script></span> <span><div
													class="bshare-custom">
													<div class="bsPromo bsPromo2"></div>
													<a title="更多平台"
														class="bshare-more bshare-more-icon more-style-addthis"><img
														alt="" style="height: 100%" src="images/ico3_4.png"></a>
												</div></span>
										</div>
										<div class="p_r">
											<a href="javascript:void(0);"><img alt=""
												src="images/ico3_5.png"></a>
										</div>
									</div>
								</div>
							</div>
						</li>

						<li class="wow fadeInUp">
							<div class="zbox">
								<div class="img" data-href="javascript:void(0)">
									<img alt="北京声达木业有限公司" src="images/3522574.jpg" width="100%">
									<div class="bian"></div>
									<div class="name elli">北京声达木业有限公司</div>
									<div class="p">我们总回忆过去，因为在现实面前一筹莫展。</div>
									<div class="more">
										<a href="javascript:;"><img alt="" src="images/btn3.png"></a>
									</div>
								</div>
								<div class="title">
									<h4 data-href="javascript:void(0)">
										<a href="javascript:;" class="elli">北京声达木业有限公司</a>
										<!-- <span><img alt="" src="images/111111281933.png"></span> -->
									</h4>
									<div class="p">
										<div class="p_l">
											<span><img alt="" src="images/ico3_2.png"> <script
													src="./c(2).aspx"></script></span> <span><img alt=""
												src="images/ico3_3.png"> <script
													src="./zan_case(3).aspx"></script></span> <span><div
													class="bshare-custom">
													<div class="bsPromo bsPromo2"></div>
													<a title="更多平台"
														class="bshare-more bshare-more-icon more-style-addthis"><img
														alt="" style="height: 100%" src="images/ico3_4.png"></a>
												</div></span>
										</div>
										<div class="p_r">
											<a href="javascript:void(0);"><img alt=""
												src="images/ico3_5.png"></a>
										</div>
									</div>
								</div>
							</div>
						</li>

						<li class="wow fadeInUp">
							<div class="zbox">
								<div class="img" data-href="javascript:void(0)">
									<img alt="大智金科" src="images/7712653.jpg" width="100%">
									<div class="bian"></div>
									<div class="name elli">大智金科</div>
									<div class="p">我在杯子里看到你的容颜，却已是匆匆那年。</div>
									<div class="more">
										<a href="javascript:;"><img alt="" src="images/btn3.png"></a>
									</div>
								</div>
								<div class="title">
									<h4 data-href="javascript:void(0)">
										<a href="javascript:;" class="elli">大智金科</a>
										<!-- <span><img alt="" src="./116897887.png"></span> -->
									</h4>
									<div class="p">
										<div class="p_l">
											<span><img alt="" src="images/ico3_2.png"> <script
													src="./c(3).aspx"></script></span> <span><img alt=""
												src="images/ico3_3.png"> <script
													src="./zan_case(4).aspx"></script></span> <span><div
													class="bshare-custom">
													<div class="bsPromo bsPromo2"></div>
													<a title="更多平台"
														class="bshare-more bshare-more-icon more-style-addthis"><img
														alt="" style="height: 100%" src="images/ico3_4.png"></a>
												</div></span>
										</div>
										<div class="p_r">
											<a href="javascript:void(0)"><img alt=""
												src="images/ico3_5.png"></a>
										</div>
									</div>
								</div>
							</div>
						</li>

						<li class="wow fadeInUp">
							<div class="zbox">
								<div class="img" data-href="javascript:void(0)">
									<img alt="北京乐益口腔健康品牌" src="images/9242065.jpg" width="100%">
									<div class="bian"></div>
									<div class="name elli">北京乐益口腔健康品牌</div>
									<div class="p">再见，再也找不到那家店。</div>
									<div class="more">
										<a href="javascript:;"><img alt="" src="images/btn3.png"></a>
									</div>
								</div>
								<div class="title">
									<h4 data-href="javascript:void(0)">
										<a href="javascript:;" class="elli">北京乐益口腔健康品牌</a>
										<!-- <span><img alt="" src="images/116985794.png"></span> -->
									</h4>
									<div class="p">
										<!-- <div class="p_l">
											<span><img alt="" src="images/ico3_2.png"> <script
													src="./c(4).aspx"></script></span>
										</div> -->
										<div class="p_l">
											<span><img alt="" src="images/ico3_2.png"> <script
													src="./c(3).aspx"></script></span> <span><img alt=""
												src="images/ico3_3.png"> <script
													src="./zan_case(4).aspx"></script></span> <span><div
													class="bshare-custom">
													<div class="bsPromo bsPromo2"></div>
													<a title="更多平台"
														class="bshare-more bshare-more-icon more-style-addthis"><img
														alt="" style="height: 100%" src="images/ico3_4.png"></a>
												</div></span>
										</div>
										<div class="p_r">
											<a href="javascript:void(0)"><img alt=""
												src="images/ico3_5.png"></a>
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