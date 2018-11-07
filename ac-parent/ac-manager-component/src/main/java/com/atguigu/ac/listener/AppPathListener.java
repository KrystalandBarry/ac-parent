package com.atguigu.ac.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class AppPathListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		
		//1.获取ServletContext对象
		ServletContext servletContext = sce.getServletContext();
		
		//2.获取ContextPath
		String contextPath = servletContext.getContextPath();
		
		//3.将contextPath存入ServletContext域中
		servletContext.setAttribute("APP_PATH", contextPath);
		
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {}

}
