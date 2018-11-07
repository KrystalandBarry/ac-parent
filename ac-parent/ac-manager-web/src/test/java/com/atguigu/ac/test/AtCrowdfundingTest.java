package com.atguigu.ac.test;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.atguigu.ac.entities.User;
import com.atguigu.ac.services.UserService;
import com.github.pagehelper.PageInfo;

public class AtCrowdfundingTest {
	
	private ApplicationContext iocContainer = new ClassPathXmlApplicationContext("spring-tx.xml");
	private UserService userService = iocContainer.getBean(UserService.class);
	
	
	@Test
	public void testSaveUser10() {
		for(int i = 0; i < 50; i++) {
			userService.saveUser(new User(null, "tom"+i, "pwd"+i, "name"+i, "email"+i, new Date().toString()));
		}
	}
	
	@Test
	public void testDataSource() throws SQLException {
		
		DataSource dataSource = iocContainer.getBean(DataSource.class);
		
		Connection connection = dataSource.getConnection();
		
		System.out.println("connection="+connection);
		
	}

}
