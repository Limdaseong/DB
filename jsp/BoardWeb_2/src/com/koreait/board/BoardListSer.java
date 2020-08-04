package com.koreait.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/boardList") // /뒤까지 비워도 됨
public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public BoardListSer() {
    	super();
    }

    // 생성자는 이름명으로 적고 메소드는 리턴 타입을 안받는다 super는 내 바로 위에 부모를 받는다 this는 나 자신, super는 부모 (메소드아님)
    // object -> http -> survlet  / 호출할 때는 반대로 맨 밑부터
    
    //오버라이딩할 때 생략보다는 적어주는게 제일 좋음 클래스명이나 바꿨을 때 오류가 나기 때문에
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { // 여기 위에 request에서 DB작업을 한다 /
    	String strI_board = request.getParameter("i_board");
    	System.out.println("Servlet i_board : " + strI_board);
    	
    	RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/boardList.jsp");
		rd.forward(request, response);
	} // get방식 : 쿼리스트링이 주소에 찍힌다
	// request dispatcher는 주소값은 안바꾸는데 jsp파일로 이동한다
	// 고객이 보낸 모든 정보는 request에 있다
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	} // post방식 : 폼으로 보내지 않는 이상 다른 것들은 get방식으로 나간다, 주소 url에 쿼리스트링이 찍히지 않는다, 대신에 많은 양을 보낼 수 있다 ex) 보통 id 이런 것들, 화면 띄울 때 많이 씀
	
	// jsp는 뷰 담당
}
