package com.koreait.pjt.board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.Const;
import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/regmod")
public class BoardRegmodSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(MyUtils.isLogout(request)) {
			response.sendRedirect("/login");
			return;
		}
		int i_board = MyUtils.parseStrToInt(request.getParameter("i_board"));
		request.setAttribute("data", BoardDAO.selBoard(i_board));
		

		

		ViewResolver.forward("board/regmod", request, response);
	}  // 화면띄우기라고!!! (등록창/수정창)

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("i_board").equals("0")) {
			String title = request.getParameter("title");
			String ctnt = request.getParameter("ctnt");
			//String strI_user = request.getParameter("i_user");
			// 한번씩  syso로 null값인지 체크를 꼭 하자		
			
			HttpSession hs = request.getSession();
			UserVO loginUser = (UserVO) hs.getAttribute(Const.LOGIN_USER);
			
			BoardVO param = new BoardVO();
			param.setTitle(title);
			param.setCtnt(ctnt);
			param.setI_user(loginUser.getI_user());
			
			BoardDAO.insBoard(param);
			
			response.sendRedirect("/list");
		} else {
			String title = request.getParameter("title");
			String ctnt = request.getParameter("ctnt");
			int i_board = MyUtils.parseStrToInt(request.getParameter("i_board"));
			
			BoardVO param = new BoardVO();
			param.setTitle(title);
			param.setCtnt(ctnt);
			param.setI_board(i_board);
			
			BoardDAO.udtBoard(param);
			
			response.sendRedirect("/board/detail?i_board=" + i_board);
		}
		
		System.out.println(request.getParameter("i_board"));
		
		
	}  // 처리 용도(db에 등록/수정) 실시라고!!!

}
