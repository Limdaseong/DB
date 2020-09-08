package com.koreait.matzip;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.jni.Proc;

@WebServlet("/")
public class Container extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private HandlerMapper mapper;
	
	public Container() { 
		mapper = new HandlerMapper(); 
	}
	
	// 호출만하면 라이브러리를 쓰는 것
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		proc(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		proc(request, response);
	}
	
	protected void proc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String temp = mapper.nav(request); //보통 템플릿 파일명
		
		//System.out.println("sub : " + temp.subString(temp.substring);
		if(temp.indexOf(":") >= 0) {
			String prefix = temp.substring(0, temp.indexOf(":"));
			String value = temp.substring(temp.indexOf(":") + 1);
			
			if("redirect".equals(prefix)) {
				response.sendRedirect(value);
				return;
			} else if("ajax".equals(prefix)) {
				response.setCharacterEncoding("UTF-8");
				response.setContentType("application/json");
				PrintWriter out = response.getWriter();
				out.print(value);
				return;
			}
		}
		
		switch(temp) {
		case "405":
			temp = "/WEB-INF/view/error.jsp";
			break;
		case "404":
			temp = "/WEB-INF/view/notfound.jsp";
			break;
		}
		
		request.getRequestDispatcher(temp).forward(request, response); // 몰아주면 관리하기 편하다
	}

}
