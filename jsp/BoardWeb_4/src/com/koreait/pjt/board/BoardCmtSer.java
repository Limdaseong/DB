package com.koreait.pjt.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.db.BoardCmtDAO;
import com.koreait.pjt.vo.BoardCmtVO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/board/cmt")
public class BoardCmtSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// 댓글(삭제)
     protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	UserVO loginUser = MyUtils.getLoginUser(request);
 		if(loginUser == null) {
 			response.sendRedirect("/login");
 			return;
 		}
 		
 		
 		int i_board = MyUtils.parseStrToInt(request.getParameter("i_board"));
 		
 		
 		int i_cmt = Integer.parseInt(request.getParameter("i_cmt"));
 		 		
 		BoardCmtVO param = new BoardCmtVO();
 		param.setI_cmt(i_cmt);
 		param.setI_board(i_board);
 		
 		BoardCmtDAO.delCmt(param);
 		
 		response.sendRedirect("/board/detail?i_board="+ i_board);
 		
 		//foreign key는 references 되있는 테이블의 컬럼에 있는 값만 들어가게 할 수 있다 (+실수를 방지하고자)
 		//잘못된 값을 넣으면 오류가 터짐
 		
	}

     // 댓글 (등록/수정)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strI_cmt = request.getParameter("i_cmt");
		String strI_board = request.getParameter("i_board");
		String cmt = request.getParameter("cmt");
		
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		int i_board = MyUtils.parseStrToInt(strI_board);
		
		BoardCmtVO param = new BoardCmtVO();
		
		param.setI_user(loginUser.getI_user());
		param.setCmt(cmt);
		
		switch(strI_cmt) {
		case "0": //등록
			param.setI_board(i_board); // 등록때는 필요없다
			BoardCmtDAO.insCmt(param);
			break;
		default: //수정
			
			break;
		}
		
		response.sendRedirect("/board/detail?i_board=" + strI_board);
	}

}
