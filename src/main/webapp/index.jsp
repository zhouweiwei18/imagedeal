<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>PICTURE DEAL</title>

<link href="${pageContext.request.contextPath }/css/demo.css" rel="stylesheet" media="all">

<script src="${pageContext.request.contextPath }/js/hm.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/js/jquery.qrcode.min.js"></script>
<script type="text/javascript">
	$(document)
	.ready(
	function() {
		function fixHeight() {
			var headerHeight = $("#switcher").height();
			$("#iframe").attr("height",
					$(window).height() - 54 + "px");
		}
		$(window).resize(function() {
			fixHeight();
		}).resize();

		$('.icon-monitor').addClass('active');

		$(".icon-mobile-3")
		.click(
		function() {
			$("#by").css("overflow-y", "auto");
			$('#iframe-wrap').removeClass()
					.addClass('mobile-width-3');
			$(
					'.icon-tablet,.icon-mobile-1,.icon-monitor,.icon-mobile-2,.icon-mobile-3')
					.removeClass('active');
			$(this).addClass('active');
			return false;
		});

		$(".icon-mobile-2")
			.click(
			function() {
				$("#by").css("overflow-y", "auto");
				$('#iframe-wrap').removeClass()
						.addClass('mobile-width-2');
				$(
						'.icon-tablet,.icon-mobile-1,.icon-monitor,.icon-mobile-2,.icon-mobile-3')
						.removeClass('active');
				$(this).addClass('active');
				return false;
			});

		$(".icon-mobile-1")
		.click(
			function() {
				$("#by").css("overflow-y", "auto");
				$('#iframe-wrap').removeClass()
						.addClass('mobile-width');
				$(
						'.icon-tablet,.icon-mobile,.icon-monitor,.icon-mobile-2,.icon-mobile-3')
						.removeClass('active');
				$(this).addClass('active');
				return false;
			});

		$(".icon-tablet")
			.click(
				function() {
					$("#by").css("overflow-y", "auto");
					$('#iframe-wrap').removeClass()
							.addClass('tablet-width');
					$(
							'.icon-tablet,.icon-mobile-1,.icon-monitor,.icon-mobile-2,.icon-mobile-3')
							.removeClass('active');
					$(this).addClass('active');
					return false;
				});

		$(".icon-monitor")
			.click(
				function() {
					$("#by")
							.css("overflow-y", "hidden");
					$('#iframe-wrap').removeClass()
							.addClass('full-width');
					$(
							'.icon-tablet,.icon-mobile-1,.icon-monitor,.icon-mobile-2,.icon-mobile-3')
							.removeClass('active');
					$(this).addClass('active');
					return false;
				});
				});
</script>

<script type="text/javascript">
	function Responsive($a) {
		if ($a == true)
			$("#Device").css("opacity", "100");
		if ($a == false)
			$("#Device").css("opacity", "0");
		$('#iframe-wrap').removeClass().addClass('full-width');
		$(
				'.icon-tablet,.icon-mobile-1,.icon-monitor,.icon-mobile-2,.icon-mobile-3')
				.removeClass('active');
		$(this).addClass('active');
		return false;
	};
</script>


</head>
<body id="by">

	<div id="iframe-wrap" style="top:18px;">
		<iframe id="iframe" src="${pageContext.request.contextPath }/frame.jsp" frameborder="0" width="100%"
			height="652px"></iframe>
	</div>

	<!--百度流量统计代码-->
	<script>
		var _hmt = _hmt || [];
		(function() {
			var hm = document.createElement("script");
			hm.src = "https://hm.baidu.com/hm.js?382f81c966395258f239157654081890";
			var s = document.getElementsByTagName("script")[0];
			s.parentNode.insertBefore(hm, s);
		})();
	</script>

</body>
</html>