<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="icon" href="http://www3.junsobao.com/static/jsb/favicon.ico"
	type="image/x-icon">
<!--动态效果样式-->
<link href="${pageContext.request.contextPath }/files/animate.css" rel="stylesheet">
<link href="http://www.bootcss.com/p/buttons/css/buttons.css" rel="stylesheet">
<!--动态效果样式end-->
<link href="${pageContext.request.contextPath }/files/style.css" rel="stylesheet">
    
    <style>
        .wrapper{
            text-align: center;
        }
        .face canvas{
            display: none;
        }
        .tip {
            color: red;
        }
    </style>
</head>

<body id="particles">
	<canvas class="pg-canvas" width="1536" height="706"></canvas>
	<div class="intro" id="app">
		<form accept-charset="UTF-8" role="form" id="loginform" action="${pageContext.request.contextPath }/user/userLoginNoFace.action">
			<div class="pf1 pf2">
				<div class="c_form1" id="logindiv">
					<div class="title1">客户登录</div>
					<div class="c_input1" id="div1_1">
						<label class="label2">用户名</label><input class="input2" id="div1"
							type="text" v-model="username" name="username">
					</div>
					<div class="c_input1" id="div2_1">
						<label class="label2">密码</label><input class="input2 mm" id="div2"
							type="password" v-model="password" name="password">
					</div>
					<div class="c_input1 c_4" id="div3_1">
						<label class="label2">验证码</label><input class="input2" id="div3"
							type="text" name="yzm">
					</div>
					<div class="fr1">
						<img src="${pageContext.request.contextPath }/files/captcha.html" alt="" width="100" height="35"
							onclick="reImg()" id="yzm"
							style="cursor: pointer; border: solid 1px #ccc; float: right;">
					</div>
					<input type="submit" class="a2" style="width: 150px;margin-left: 70px;" value="登录">
					<a href="javascript:void(0)" @click="toggleLoginType"><input type="button" class="a2" onclick="hide()" style="width: 150px;margin-left: 50px;" value="刷脸登录"></a>
					<!-- <input type="button" class="a2"  style="width: 150px;margin-left: 50px;" value="刷脸登录"> -->
					<div class="d_link1">
						<a href="javascript:void(0);">忘记密码？</a><span>&nbsp;|&nbsp;&nbsp;</span><a
							href="${pageContext.request.contextPath }/reg.jsp" class="a3">立即注册</a>
					</div>
				</div>
			</div>
		</form>
		<div>
        <div class="wrapper">
        
            <!-- <div class="username">
                <label>用户名</label>
                <input v-model="username" value="$('#nameid').value">
            </div>
            
            <div v-show="passwordLogin">
                <label>密码</label>
                <input type="password" value="$('#nameid').value" v-model="password">
            </div> -->
            
            <!-- <div v-show="!passwordLogin">
                <label>进行活体检测：</label><input type="checkbox" v-model="aliveCheck">
            </div> -->
            
           
            <div class="tip">
                {{tip}}
            </div>
            <div class="face" v-show="!passwordLogin">
                <video ref="video" width="300" height="300"></video>
                <canvas ref="canvas" width="300" height="300"></canvas>
                <!--<img ref="previewImg" src="">-->
            </div>
            <div style="color: white;display: none;" id="loginbutton">
              <!-- <input  style="width: 100px;height: 30px;" type="button" @click="login" value="登陆"> -->
              <a class="button button-glow button-border button-rounded button-primary" @click="login">登陆</a>
            </div>
        </div>
    </div>
	</div>
	
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery-3.3.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.21/dist/vue.js"></script>

	<script type="text/javascript"
		src="${pageContext.request.contextPath }/files/jquery.particleground.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/files/demo.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/files/wow.min.js"></script>
	<script type="text/javascript">
	
		function hide() {

			//将原来的div隐藏
			$('#logindiv').hide();
			$('#loginbutton').show();
		}
	
	
		$("#loginform").submit(function() {
			$.ajax({
				url : '${pageContext.request.contextPath }/member/login/login.html',
				type : "POST",
				data : $("#loginform").serialize(),
				success : function(data) {
					if (data.code != 1) {
						alert(data.msg);
						reImg();
					} else {
						alert(data.msg);
						location.href = data.url;
					}
				},
			});
			return false;
		});

		function reImg() {
			var img = document.getElementById("yzm");
			img.src = "files/captcha.html?" + Math.random();
			$("#loginform input[name='yzm']").val("");
		}
	</script>
	
	   

   
    <script>

        const CODE_SUCCESS = 0
        const CODE_ERROR = 1

        // 活体检测类型
        const [CHECK_TYPE_MOUTH, CHECK_TYPE_EYE] = ['mouth', 'eye']

        // 活体检测结果 1：通过 0：需要继续检测 -1：失败，摄像头前的对象没有活动
        const [CHECK_SUCCESS, CHECK_NORMAL, CHECK_FAILED] = [1, 0, -1]

        const vm = new Vue({
            el: '#app',
            data: {
                username: '',
                password: '',
                passwordLogin: true, // 密码登陆方式
                tip: '',
                aliveCheck: false   // 登陆时是否进行活体检测，默认 false
            },
            mounted() {
                this._initMedia()
            },
            methods: {
                // 初始化摄像头
                _initMedia() {
                    let constraints = {
                        audio: false,
                        video: {width: 300, height: 300}
                    }

                    let _this = this
                    // 调用浏览器摄像头
                    navigator.mediaDevices.getUserMedia(constraints)
                        .then((mediaStream) => {
                            _this.video = this.$refs.video
                            // 将结果分配给 video 标签
                            _this.video.srcObject = mediaStream
                            _this.video.onloadedmetadata = function (e) {
                                // 元数据加载后，播放
                                _this.video.play()
                            }
                        })
                        .catch((err) => {
                            console.log(err.name + ":" + err.message)
                        })
                },
                // canvas 截取图片
                _captureImg() {
                    // 取到 canvas
                    this.canvas = this.$refs.canvas;
                    // 获取 canvas 上下文
                    let ctx = this.canvas.getContext('2d')
                    // 截图
                    ctx.drawImage(this.video,0, 0, 300, 300)
                    // 将截图转换成 base64
                    this.image = this.canvas.toDataURL('image/png')
                    // 只保留 base64 部分
                    let base64Str = this.image.split('base64,')[1]

                    // console.log(base64Str)

                    return base64Str
                },
                login() {

                    if (this.username === '') {
                        this.tip = '用户名不能为空！'
                        return
                    }

                    this.tip = ''

                    let _this = this

                    let base64Str = ''

                    // 判断登陆方式
                    if (!this.passwordLogin) {
                        // 刷脸登陆
                        base64Str = this._captureImg()
                    }

                    this.tip = '正在登陆...'

                    // 登陆请求
                    $.ajax({
                        url: '${pageContext.request.contextPath }/user/userLogin.action',
                        data: {
                            username: _this.username,
                            password: _this.password,
                            facecode: base64Str,
                            passwordLogin: _this.passwordLogin
                        },
                        success(resp) {
                            console.log(resp)
                            if (resp) {
                                if (resp.code === CODE_SUCCESS) {
                                    // 判断是否还要进行活体检测，即检测 张张嘴和眨眨眼
                                    if (_this.aliveCheck) {
                                        _this.tip = '对比成功'
                                        // resp.data 为 后台返回的 user 对象
                                        _this._handleAliveCheck(resp.data)
                                    } else {
                                        //alert("登陆成功！")
                                        location.href = "${pageContext.request.contextPath }/index.jsp"
                                    }
                                } else {
                                    alert(resp.message)
                                }
                            }
                            // _this.tip = ''
                        },
                        error(error) {
                            console.log(error)
                        }
                    })

                },
                // 切换登陆方式
                toggleLoginType() {
                    this.passwordLogin = !this.passwordLogin
                },
                // 处理活体检测
                _handleAliveCheck(user) {

                    // 延时一下执行
                    setTimeout(() => {
                        this._postAliveCheck(CHECK_TYPE_MOUTH, user.id)
                    }, 2000)
                },
                // 活体检测请求，这里会递归调用，其实也可以用定时，这里
                // 用递归主要是希望每一次检测请求都在检测完成之后才继续调下一次
                
            }
        })
    </script>
</body>
 
</html>
