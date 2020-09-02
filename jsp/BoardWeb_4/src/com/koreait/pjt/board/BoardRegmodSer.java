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
		String strI_board = request.getParameter("i_board");
		
		BoardVO param = new BoardVO();
		if(strI_board != null) {
			int i_board = MyUtils.parseStrToInt(request.getParameter("i_board")); 
			//i_board값은 null값이 넘어온다
			param.setI_board(i_board);
			request.setAttribute("data", BoardDAO.selBoard(param));
		}
		

		

		ViewResolver.forward("board/regmod", request, response);
	}  // 화면띄우기라고!!! (등록창/수정창)

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strI_board = request.getParameter("i_board");
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		
		HttpSession hs = request.getSession();
		UserVO loginUser = (UserVO) hs.getAttribute(Const.LOGIN_USER);
		
		String filter1 = scriptFilter(ctnt);
		String filter2 = swearWordFilter(filter1);
		
		BoardVO param = new BoardVO();
		
		param.setTitle(title);
		param.setCtnt(scriptFilter(ctnt));
		param.setI_user(loginUser.getI_user());
		
		if("".equals(strI_board)) {
			
			//String strI_user = request.getParameter("i_user");
			// 한번씩  print문으로 null값인지 체크를 꼭 하자		
			
			BoardDAO.insBoard(param);
			
			response.sendRedirect("/list");
		} else {
			
			int i_board = MyUtils.parseStrToInt(strI_board);
			
			param.setI_board(i_board);
			
			BoardDAO.udtBoard(param);
			
			response.sendRedirect("/board/detail?i_board=" + i_board);
		}
		
		System.out.println(request.getParameter("i_board"));
		
		
	}  // 처리 용도(DB에 등록/수정) 실시라고!!!
	
	//욕 필터
		private String swearWordFilter(final String ctnt) {
			String[] filters = {"개새끼", "미친년", "ㄱ ㅐ ㅅ ㅐ ㄲ ㅣ"};
			String result = ctnt;
			for(int i=0; i<filters.length; i++) {
				result = result.replace(filters[i], "***");
			}
			return result;
		}

		//스크립트 필터
		private String scriptFilter(final String ctnt) {
			String[] filters = {"<", ">"};
			String[] filterReplaces = {"&lt;", "&gt;"};

			String result = ctnt;
			for(int i=0; i<filters.length; i++) {
				result = result.replace(filters[i], filterReplaces[i]);
			}
			return result;
		}
	
}
