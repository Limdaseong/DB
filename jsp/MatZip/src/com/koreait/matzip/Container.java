package com.koreait.matzip;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/")
@MultipartConfig(
		fileSizeThreshold = 10_485_760, // 10MB
		maxFileSize = 52_428_800, // 50MB
		maxRequestSize = 104_857_600 // 100MB
)
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
		// 로그인 되어 있으면 login, join 접속 x
		
		String routerCheckResult = LoginChkInterceptor.routerChk(request);
		
		if(routerCheckResult != null) {
			response.sendRedirect(routerCheckResult);
			return;
		}
		
		
		// 로그인에 따른 접속 가능여부 판단
		// (로그인이 안 되어 있으면 접속할 수 있는 주소만 나머지 전부 로그인이 되어 있어야 함)
		
		String temp = mapper.nav(request); //보통 템플릿 파일명
		
		if(temp.indexOf(":") >= 0) {
			String prefix = temp.substring(0, temp.indexOf(":"));
			String value = temp.substring(temp.indexOf(":") + 1);
			
			if("redirect".equals(prefix)) {
				response.sendRedirect(value);
				return;
			} else if("ajax".equals(prefix)) {
				response.setCharacterEncoding("UTF-8");
				response.setContentType("application/json");
				PrintWriter out = response.getWriter(); // 
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
