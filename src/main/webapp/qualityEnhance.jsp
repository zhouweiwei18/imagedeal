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
<link href="${pageContext.request.contextPath }/css/animate.css" rel="stylesheet">
<!--首页动态效果样式end-->
<!--首页banner效果样式-->
<link href="${pageContext.request.contextPath }/css/global.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/fix.css" rel="stylesheet">
<!--首页banner效果样式end-->

<link href="${pageContext.request.contextPath }/css/bootstrap.css" rel="stylesheet">
<link href="http://www.bootcss.com/p/buttons/css/buttons.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/slick.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/slick-theme.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/css/style.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-1.11.2.min.js"></script>
<script src="${pageContext.request.contextPath }/js/checkform.js"></script>
<style type="text/css">
        .content {
            color: #ffffff;
            font-size: 40px;
        }
        .bg {
            background: url('${pageContext.request.contextPath }/images/boy.jpg.png');
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
            filter: blur(30px);
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
							<a target="_self" href="${pageContext.request.contextPath }/index.jsp">首页</a>
						</span>
					</li>
					<li class="nli first" id="nav1_1"><span><a
							target="_self" href="${pageContext.request.contextPath }/people.jsp">人像</a></span></li>
					<li class="nli" id="nav1_2"><span>
					<a target="_blank" href="${pageContext.request.contextPath }/plants.jsp">植物</a></span>
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
		
	</div>
	
	<div class="bg bg-blur"></div>
	
	<div style="width: 599px;float: left;margin-left: 72px;margin-top: 100px;position:absolute;background:#000; color:#FFF">
		
		<c:if test="${!empty qualityImagePath}">
			<img alt="" src="../../img/${qualityImagePath}"
				style="border-radius:10px;width:530px;height:330px;margin-left: 36px;margin-top: 20px;">
		</c:if>
		
		<c:if test="${empty qualityImagePath}">
			<%-- <img alt="" id="simg" src="${pageContext.request.contextPath }/images/fog.jpg" style="border-radius:10px;"> --%>
		<img src="${pageContext.request.contextPath }/images/boy.jpg.png" id="simg" style="border-radius:10px;width:530px;height:330px;margin-left: 36px;margin-top: 20px;">
		</c:if>
	 
		<br>
	 	<br>
		<div style="float: left;margin-left: 215px;margin-top: 15px;margin-bottom: 5px;">
			<a class="button button-glow button-border button-rounded button-primary" onclick="$('input[id=lefile]').click();">选择图片</a>
		</div>
	</div>
	
	<form action="${pageContext.request.contextPath }/quality/qualityChange.action"
		enctype="multipart/form-data" method="post" id="picForm">
		<input id="lefile" type="file" name="file" style="display: none;"/>
	</form>
	
	<div style="width: 710px;float: right;margin-left: 750px;margin-top: 100px;position:absolute;">
		<img alt=""  style="border-radius:10px;" id="Base64">
		<br>
	 	<br>
		<div style="float: left;margin-left: 303px;margin-top: 0px;">
		<a style="display: none" id="butId" onclick="downloadFile('download.jpg',$('#Base64')[0].src)" class="button button-glow button-border button-rounded button-primary">下载图片</a>
		</div>
	</div>
	
	
	<!-- 打开本地文件(图片) -->
	<script type="text/javascript">
	  $('input[id=lefile]').change(function(){ //file点击事件
		   var file = this.files[0];                                                             //获取文件
		   if (window.FileReader) {  //如果浏览器支持FileReader
		       var reader = new FileReader(); //新建一个FileReader对象
		       reader.readAsDataURL(file); //读取文件url
		       reader.onloadend = function (e) { 
		           console.log(e);                                                             //输出e,查看其参数
		           console.log(e.target.result); //通过e,输出图片的base64码
		           $("#simg").attr("src",e.target.result);//将base64码填入src,用于预览

		           //提交表单
		           $("#picForm").submit();
		       };    
		   }
		 });
	</script>
	
	<script type="text/javascript">
	$(function() {
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath }/quality/qualityEnhance.action",
			data : {},//json序列化       这里对应的是图片的id
			async : false,//这里必须要同步
			datatype : "json", //此处不能省略 
			contentType : "application/json; charset=utf-8",//此处不能省略 
			success : function(data) {
				//获取img
				//var img = $("#Base64");
				$("#Base64").attr("src", "data:image/jpg;base64,"+data);

				$("#butId").css('display','block');
			},
			error : function(data) {
				alert("error");
			}
		})
	});
	
	
function downloadFile(fileName, content) {
		
		//fileName = fileName.substring(str.length-5);
        let aLink = document.createElement('a');
        let blob = this.base64ToBlob(content); //new Blob([content]);

        let evt = document.createEvent("HTMLEvents");
        evt.initEvent("click", true, true);//initEvent 不加后两个参数在FF下会报错  事件类型，是否冒泡，是否阻止浏览器的默认行为
        aLink.download = fileName;
        aLink.href = URL.createObjectURL(blob);
        // aLink.dispatchEvent(evt);
       // aLink.click()
        aLink.dispatchEvent(new MouseEvent('click', {bubbles: true, cancelable: true, view: window}));//兼容火狐
      }
      //base64转blob
     function base64ToBlob(code) {
        let parts = code.split(';base64,');
        let contentType = parts[0].split(':')[1];
        let raw = window.atob(parts[1]);
        let rawLength = raw.length;

        let uInt8Array = new Uint8Array(rawLength);

        for (let i = 0; i < rawLength; ++i) {
          uInt8Array[i] = raw.charCodeAt(i);
        }
        return new Blob([uInt8Array], {type: contentType});
      }
	</script>
	
</body>
</html>