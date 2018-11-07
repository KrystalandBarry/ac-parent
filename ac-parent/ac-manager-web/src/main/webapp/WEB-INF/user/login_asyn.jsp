<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <base href="http://${pageContext.request.serverName }:${pageContext.request.serverPort }${pageContext.request.contextPath }/"/>
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link rel="stylesheet" href="css/login.css">
	<style>

	</style>
  </head>
  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container">

      <form class="form-signin" role="form" method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
          <p>${requestScope.MESSAGE }</p>
		  <div class="form-group has-success has-feedback">
			<input name="loginacct" type="text" class="form-control" id="loginacctInput" placeholder="请输入登录账号" autofocus >
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input name="userpswd" type="text" class="form-control" id="userpswdInput" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<select class="form-control" >
                <option value="member">会员</option>
                <option value="user" selected="selected">管理</option>
            </select>
		  </div>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住我
          </label>
          <br>
          <label>
            忘记密码
          </label>
          <label style="float:right">
            <a href="reg.html">我要注册</a>
          </label>
        </div>
        <button id="submitBtn" class="btn btn-lg btn-success btn-block"> 登录</button>
      </form>
    </div>
    <script src="jquery/jquery-2.1.1.min.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="layer/layer.js"></script>
    <script>
	    
	 	//一、初始化选择“会员”和“管理”的下拉列表
	 	var memberLoginUrl = "${pageContext.request.contextPath }/member/doAsynLogin.atguigu";
	 	var userLoginUrl = "${pageContext.request.contextPath }/user/doAsynLogin.atguigu";
	 	
	 	//二、给登录按钮绑定单击响应函数
	 	$("#submitBtn").click(function(){
	 		
	 		//1.收集用户账号、密码数据
	 		var loginacct = $("#loginacctInput").val();
	 		var userpswd = $("#userpswdInput").val();
	 		
	 		//2.将账号、密码封装到JSON对象中
	 		var param = {
	 			"loginacct":loginacct,
	 			"userpswd":userpswd,
	 			"random":Math.random() //防止浏览器使用缓存
	 		};
	 		
	 		//3.根据用户在下拉列表中选择的选项决定url的值
	 		var optionVal = $(":selected").val();
	 		
	 		var url = null;
	 		
	 		if(optionVal == "member") {
	 			url = memberLoginUrl;
	 		}
	 		
	 		if(optionVal == "user") {
	 			url = userLoginUrl;
	 		}
	 		
	 		//4.声明回调函数
	 		//response是服务器返回的响应数据
	 		//在服务器确实返回JSON字符串的前提下，type值指定为json
	 		//jQuery就能将JSON字符串解析为JSON对象
	 		var callBack = function(response){
	 			
	 			//获取服务器对当前请求处理的结果
	 			var result = response.result;
	 			
	 			//根据result判断服务器返回的是成功还是失败
	 			if(result == "SUCCESS") {
	 				
	 				//跳转到登录后的页面
	 				window.location.href = "${pageContext.request.contextPath }/user/main.html";
	 				
	 				//当前函数停止执行
	 				return ;
	 			}

	 			if(result == "FAILED") {
	 				
	 				//从响应数据中获取提示消息
	 				var message = response.message;
	 				
	 				//alert(message);
	 				layer.msg(message);
	 				
	 			}
	 		};
	 		
	 		//5.jQuery对服务器返回的响应数据的解析方式
	 		var type = "json";
	 		
	 		$.post(url, param, callBack, type);
	 		
	 		//取消控件的默认行为，不让表单的提交按钮提交表单
	 		return false;
	 	});
    
    </script>
  </body>
</html>