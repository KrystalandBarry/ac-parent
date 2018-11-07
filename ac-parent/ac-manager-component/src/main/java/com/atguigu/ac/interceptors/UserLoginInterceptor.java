package com.atguigu.ac.interceptors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.atguigu.ac.entities.User;
import com.atguigu.ac.utils.ACConst;

/**
 * 使用SpringMVC提供的拦截器和Servlet标准中定义的过滤器时候的三个要素
 * 要素1：拦截
 * 		Filter放行方式：web.xml配置filter-mapping
 * 		Interceptor放行方式：SpringMVC配置文件中配置mvc:interceptors。注意：只能拦截SpringMVC请求
 * 要素2：过滤
 * 		根据业务需求设定过滤条件
 * 要素3：放行
 * 		Filter放行方式：chain.doFilter(req,resp);
 * 		Interceptor放行方式：preHandle()方法返回true表示放行，返回false将不执行后续所有操作
 * @author Lenovo
 *
 */
public class UserLoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//1.通过request对象获取HttpSession对象
		HttpSession session = request.getSession();
		
		//2.从Session域中尝试获取登录的用户
		User user = (User) session.getAttribute(ACConst.LOGIN_USER);
		
		//3.判断user是否为null
		if(user == null) {
			
			//4.说明当前没有用户登录，将请求转发到登录页面并显示提示消息
			request.setAttribute(ACConst.MESSAGE_ATTR_NAME, ACConst.MESSAGE_ACCESS_FORBIDDEN);
			request.getRequestDispatcher("/WEB-INF/user/login.jsp").forward(request, response);
			
			//不能执行后续操作
			//※注意：这里仅仅return false是没有任何响应的，上面的转发操作一方面是去登录页面，同时也是提供响应数据
			return false;
			
		}
		
		//5.说明用户已登录，放行，继续执行后续操作
		return true;
	}

}
