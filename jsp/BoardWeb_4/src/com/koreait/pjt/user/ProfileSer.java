package com.koreait.pjt.user;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.vo.UserVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/profile")
public class ProfileSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// 프로필 화면(나의 프로필 이미지, 이미지 변경 가능한 화면)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		request.setAttribute("data", UserDAO.selUser(loginUser.getI_user()));
		
		ViewResolver.forward("user/profile", request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserVO loginUser = MyUtils.getLoginUser(request);
		
		String savePath = getServletContext().getRealPath("img") + "/user/" + loginUser.getI_user();
		System.out.println("svaepath : " + savePath);
		
		File directory = new File(savePath);
		
		// 만약 폴더(디렉토리)가 없다면 true
		if(!directory.exists()) { 
			directory.mkdirs(); // 파일을 여러개 만들게 해주는 것
		}
		
		int maxFileSize = 10_485_760; // 1024 * 1024 * 10 (10mb) / _는 단위수 보이게 하려고 한 것이다 / 최대 파일 사이즈 크기
		String fileNm = ""; // 원래 파일명 
		// String originFileNm = "";
		String saveFileNm = "";
		
		try {
			MultipartRequest mr = new MultipartRequest(request, savePath, 
					maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
			
			Enumeration files = mr.getFileNames();
			
			while(files.hasMoreElements()) {
				String key = (String)files.nextElement();
				fileNm = mr.getOriginalFileName(key);
				String ext = fileNm.substring(fileNm.lastIndexOf(".")); // lastIndexOf는 뒤에서부터 찾는 것이다
				saveFileNm = UUID.randomUUID()+ "." + ext;
				//originFileNm = mr.getOriginalFileName(key);
				System.out.println("key : " + key);
				System.out.println("fileNm : " + fileNm);
				// System.out.println("originFileNm : " + originFileNm);
				
				System.out.println(ext);
				// substring(*,@) 은 *번째 글자부터 @번째 글자까지 나오게 할 수 있다
				
				
				File oldFile = new File(savePath + "/" + fileNm);
				File newFile = new File(savePath + "/" + saveFileNm);
				oldFile.renameTo(newFile);
			}
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		if(saveFileNm != null) { //DB에 프로필 파일명 저장
			UserVO param = new UserVO();
			param.setProfile_img(saveFileNm);
			param.setI_user(loginUser.getI_user());
			
			UserDAO.updUser(param);
		}
	}

}
