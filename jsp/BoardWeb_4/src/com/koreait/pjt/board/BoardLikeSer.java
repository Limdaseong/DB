package com.koreait.pjt.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.koreait.pjt.MyUtils;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardDomain;

@WebServlet("/board/likeList")
public class BoardLikeSer extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int i_board = MyUtils.getIntParameter(request, "i_board");
		System.out.println("i_board : " + i_board);
		
		List<BoardDomain> likeList = BoardDAO.selBoardLikeList(i_board);
		
		Gson gson = new Gson();
		
		String json = gson.toJson(likeList);
		
		System.out.println("json : " + json);
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		// 보내고 있는 자료가 무엇(형식?)인지 setContentType으로 알려줌
		
		PrintWriter out = response.getWriter();
		out.print(json);  //여기서 넘어오는 것은 html 문서 형태이다 // 그래서 json 형식의 글을 보내도 인식 x
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
