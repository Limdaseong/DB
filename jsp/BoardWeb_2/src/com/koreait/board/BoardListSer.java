package com.koreait.board;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.db.BoardDAO;
import com.koreait.board.db.DbCon;
import com.koreait.board.vo.BoardVO;


@WebServlet("/boardList") // /뒤까지 비워도 됨 ()이 주소값으로 파라미터를 보냄
public class BoardListSer extends HttpServlet { // http는 요청하고 응답하고 끊는다
	private static final long serialVersionUID = 1L;

    public BoardListSer() {
    	super();
    }

    // 생성자는 이름명으로 적고 메소드는 리턴 타입을 안받는다 super는 내 바로 위에 부모를 받는다 this는 나 자신, super는 부모 (메소드아님)
    // object -> http -> survlet  / 호출할 때는 반대로 맨 밑부터
    
    //오버라이딩할 때 생략보다는 적어주는게 제일 좋음 클래스명이나 바꿨을 때 오류가 나기 때문에
    @Override               //get방식은 화면 띄우려고 쓰는 것임
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { // 여기 위에 request에서 DB작업을 한다 /
    	
    	List<BoardVO> list = BoardDAO.selBoardList();
    	request.setAttribute("data", list);
    
    	RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/boardList.jsp");
    	rd.forward(request, response);
    	// sendredirect : 	1.
    	//					2. 주소값 변환
    	//					3. 무조건 get방식으로 날라감
    	//
    	// requestdispatcher : 3. doGet으로 보내면 get방식이 되고, doPost로 보내면 post방식이 된다
    	//jsp파일을 연다
    	//주소값 변환 x 
    	// sendredirect : 1.
    	//				  2.
    	//				  3.
    	// requestDispatcher
    	
    	try {
    		Connection con = DbCon.getCon();
    		PreparedStatement ps = null;
    		ResultSet rs = null;
    		
    		DbCon.close(con, ps, rs);
    		DbCon.close(con, ps);
    	//  ~~~. 에서 .앞에 있는 것은 클래스명이다
    		
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	
		rd.forward(request, response); // request객체가 response객체를 이용해서 jsp파일의 결과물을 고객의 응답까지 리턴한다
	} // get방식 : 쿼리스트링이 주소에 찍힌다  but get방식 안쓸거면 이 메소드 지워도 된다
	// request dispatcher는 주소값은 안바꾸는데 jsp파일로 이동한다 
	// 고객이 보낸 모든 정보는 request에 있다 / request는 연결고리이다
	
    //세션은 브라우저를 완전히 껐을 때 죽는다 , 어플리케이션은 범용이다 나머지는 개인이다
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response); //request는 요청이 들어오고 응답하고 나면 죽는다
	} // post방식 : 폼으로 보내지 않는 이상 다른 것들은 get방식으로 나간다, 주소 url에 쿼리스트링이 찍히지 않는다, 대신에 많은 양을 보낼 수 있다 ex) 보통 id 이런 것들, 화면 띄울 때 많이 씀
	
	// jsp는 뷰 담당
}
