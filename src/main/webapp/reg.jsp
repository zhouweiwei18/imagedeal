<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>

<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta name="format-detection" content="telephone=no">
<title></title>
<link rel="icon" href="javascript:void(0);" type="image/x-icon">
<!--动态效果样式-->
<link href="${pageContext.request.contextPath }/files/animate.css"
	rel="stylesheet">
<link href="http://www.bootcss.com/p/buttons/css/buttons.css" rel="stylesheet">
<!--动态效果样式end-->
<link href="${pageContext.request.contextPath }/files/style.css"
	rel="stylesheet">

<style>
.wrapper {
	text-align: center;
}

.face-wrapper {
	margin: 20px;
}

.face-wrapper canvas {
	display: none;
}
</style>

<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/files/jquery.particleground.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/files/demo.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/files/wow.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.21/dist/vue.js"></script>
</head>
<body id="particles">
	<canvas class="pg-canvas" width="1536" height="706"></canvas>
	<div class="intro" id="app">
		<div class="pf1">
			<form role="form" id="regform"
				action="${pageContext.request.contextPath }/user/userRegister.action">
				<div class="c_form1" id="registediv">
					<div class="title1">新用户注册</div>
					<div class="c_input" id="div1_1">
						<label class="label1">用户名</label><input class="input1" id="div1"
							type="text" name="username" v-model="username">
					</div>
					<div class="c_input mr_0" id="div2_1">
						<label class="label1">联系人</label><input class="input1" id="div2"
							type="text" name="contacts" v-model="contacts">
					</div>
					<div class="c_input" id="div3_1">
						<label class="label1">密码</label><input class="input1" id="div3"
							type="password" name="password" v-model="password">
					</div>
					<div class="c_input mr_0" id="div4_1">
						<label class="label1">确认密码</label><input class="input1" id="div4"
							type="password">
					</div>
					<div class="c_input c_7" id="div5_1">
						<label class="label1">手机号码</label><input class="input1" id="div5"
							type="text" name="phonenumber" v-model="phonenumber">
					</div>
					<div class="c_input mr_0 c_7" id="div6_1">
						<label class="label1 c_1">手机验证码</label><input class="input1 c_2"
							id="div6" type="text" v_model="eyzm"><a class="a1"
							href="javascript:void(0);" onclick="settime(this)">获取验证码</a>
					</div>

					<div class="c_input" id="div7_1">
						<label class="label1">邮箱</label><input class="input1" id="div7"
							type="text" name="email" v-model="email">
					</div>
					<div class="c_input mr_0" id="div8_1">
						<label class="label1">QQ</label><input class="input1" id="div8"
							type="text" name="qq" v-model="qq">
					</div>
					<div class="c_input c_3" id="div9_1">
						<label class="label1">验证码</label><input class="input1" id="div9"
							type="text">
					</div>
					<div class="c_input mr_0 bg0">
						<img src="${pageContext.request.contextPath }/files/captcha.html"
							alt="" width="100" onclick="reImg()" id="yzm"
							style="cursor: pointer; border: solid 1px #ccc;">
						<div class="text1">
							已有账号？<a href="${pageContext.request.contextPath }/login.jsp">立即登录</a>
						</div>
					</div>

					<div class="link1" style="width: 40%; margin-left: 55px;">
						<a href="javascript:sub();">注册</a>
					</div>

					<div class="link1"
						style="width: 40%; margin-left: 60px; float: left;">
						<a href="javascript:image();">头像采集</a>
					</div>
				</div>
			</form>
		</div>

		<div>
			<div class="wrapper">

				<div style="height: 20px; color: white;"></div>
				<div class="info">{{info}}</div>
				<div class="face-wrapper">
					<video ref="video" width="300" height="300"></video>
					<canvas ref="canvas" width="300" height="300"></canvas>
					<img ref="previewImg" src="">
				</div>
				<div style="color: white;" id="loginbutton">
					<!-- <input style="width: 100px; height: 30px;" type="button"
						@click="handleSubmit" value="提交"> -->
						<a class="button button-glow button-border button-rounded button-primary" @click="handleSubmit">提交</a>
				</div>
			</div>
		</div>

	</div>

	<script type="text/javascript">
		 
	    
		 function sub() {
			 
			 //alert();
			 //获取用户名，密码
			 var username = $("#div1").val();
			 
			 var password = $("#div3").val();
			 
			 location.href="${pageContext.request.contextPath }/user/userReg.action?username="+username+"&&password="+password;
		} 
		
		function image() {
			
			//获取原来输入框中的name值
			//将原来的div隐藏
			$('#registediv').hide();
		}
	</script>

	<script>
        const CODE_SUCCESS = 0
        const CODE_ERROR = 1
        const vm = new Vue({
            el: '#app',
            data: {
                username: '',
                password: '',
                qq: '',
                email:'',
                contacts:'',
                phonenumber:'',
                info: ''
            },
            mounted() {
                this._intiMedia()
            },
            methods: {
                _intiMedia() {
                    let constraints = {
                        audio: false,
                        video: {width: 300, height: 300}
                    }

                    let _this = this
                    navigator.mediaDevices.getUserMedia(constraints)
                        .then((mediaStream) => {
                            _this.video = this.$refs.video
                            _this.video.srcObject = mediaStream
                            _this.video.onloadedmetadata = function (e) {
                                _this.video.play()
                            }
                        })
                        .catch((err) => {
                            console.log(err.name + ":" + err.message)
                        })
                },
                handleSubmit() {

                    this.info = ''

                    this.canvas = this.$refs.canvas;
                    let ctx = this.canvas.getContext('2d')
                    ctx.drawImage(this.video,0, 0, 300, 300)
                    this.image = this.canvas.toDataURL('image/png')

                    this.$refs.previewImg.src = this.image

                    let base64Str = this.image.split('base64,')[1]

                    console.log(base64Str)

                    this.info = '正在录入...'

                    let _this = this
                    
                    $.ajax({
                        url: "${pageContext.request.contextPath }/user/userRegister.action",
                        data: {
                           username: _this.username,
                           password: _this.password,
                           qq: _this.qq,
                           email: _this.email,
                           contacts: _this.contacts,
                           phonenumber: _this.phonenumber,
                           facecode: base64Str
                        },
                         success: function (resp) {
                            console.log(resp)
                            if (resp.code === CODE_SUCCESS) {
                                /* _this.info = resp.message */
                                location.href = "${pageContext.request.contextPath }/login.jsp"
                            } else {
                                _this.info = resp.message
                            }
                        },
                        error: function (error) {
                            console.log(error)
                        } 
                    })
                }
            }
        })
</script>

</body>
</html>