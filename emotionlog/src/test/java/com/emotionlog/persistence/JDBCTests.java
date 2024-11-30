package com.emotionlog.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.java.Log;

@Log
public class JDBCTests {
	static {
		try {
			Class.forName("oracle.jdbc.OracleDriver"); //메이븐에서 이미 집어넣음 pom.xml에 138-141번째 줄/ maven dependency의 옆에 창에서 확인
		
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	@Test //단위케스트를 지원하는 어노테이션
	public void testConnection() {
		try(Connection con = 
				DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xepdb1", 
						"emo", 
						"emo")){
			System.out.println(con);
			//log.info(con);
		} catch(Exception e) {
			fail(e.getMessage());
		}
	}
}
