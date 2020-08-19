package com.koreait.pjt.db;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public interface JdbcUpdateInterface {
	void update(PreparedStatement ps) throws SQLException;
	// 인터페이스는 선언부만 있지 객체화가 안된다
	// 객체생성 private을 써서 막을 수 있다
	
	// 인터페이스에 public abstract가 붙어있다
	// 누구를 가리킨다는 것은 객체이다 객체는 구현이 되어있어야 객체이다
}
