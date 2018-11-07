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
			<input name="loginacct" type="text" class="form-control" id="inputSuccess4" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-user form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input name="userpswd" type="password" class="form-control" id="inputSuccess5" placeholder="请输入登录密码" style="margin-top:10px;">
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
    <script>
	    $("#submitBtn").click(function(){
	    	//0.声明action变量，用来存储当前表单将要请求的URL地址
	    	var action = null;
	    	
	    	//1.通过jQuery的:selected选中下拉列表中被选中的选项。
	    	//也就是获取当前在“会员”和“管理”二者之间选择的option
	        var type = $(":selected").val();
	        if ( type == "user" ) {
	        	//2.表示当前表单执行后台管理员登录
	            action = "user/doLogin.html";
	        } else {
	        	//3.表示当前表单执行前台会员登录
	            action = "member/doLogin.html";
	        }
	        
	        //4.设置当前表单的action属性，让它能够将数据提交到指定的URL地址
	        $("form").attr("action",action);
	    });
    </script>
  </body>
</html>