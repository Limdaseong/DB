package com.koreait.pjt.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardDomain;

@WebServlet("/list")
public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		if(MyUtils.isLogout(request)) {
			response.sendRedirect("/login");
			return;
		}
		
		String searchText = request.getParameter("searchText");
		searchText = (searchText == null ? "" : searchText);
		
		int page = MyUtils.getIntParameter(request, "page");
		page = (page == 0 ? 1 : page);
		
		int recordCnt = MyUtils.getIntParameter(request, "record_cnt");
		recordCnt = (recordCnt == 0 ? 10 : recordCnt);
		
		BoardDomain param = new BoardDomain();
		param.setRecord_cnt(recordCnt);
		param.setSearchText("%" + searchText + "%");
		int pagingCnt = BoardDAO.selPagingCnt(param);
				
		if(page > pagingCnt) {
			page = pagingCnt;
		}
		
		int eIdx = page * recordCnt;
		int sIdx = eIdx - recordCnt;

		param.seteIdx(eIdx);
		param.setsIdx(sIdx);

		request.setAttribute("page", page);
		
		request.setAttribute("pagingCnt", BoardDAO.selPagingCnt(param));
		request.setAttribute("data", BoardDAO.selBoardList(param));
		
		ViewResolver.forward("board/list", request, response);
	}
}
