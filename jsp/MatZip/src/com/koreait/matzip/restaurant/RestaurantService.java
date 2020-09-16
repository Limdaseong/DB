package com.koreait.matzip.restaurant;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import com.google.gson.Gson;
import com.koreait.matzip.CommonUtils;
import com.koreait.matzip.FileUtils;
import com.koreait.matzip.vo.RestaurantRecommendMenuVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class RestaurantService {

	private RestaurantDAO dao;

	public RestaurantService() {
		dao = new RestaurantDAO();
	}

	public int restReg(RestaurantVO param) {
		return dao.reg(param);
	}

	public RestaurantDomain getRest(RestaurantVO param) {
		return dao.selRest(param);
	}

	public String getRestList() {
		List<RestaurantDomain> list = dao.selRestList();
		Gson gson = new Gson();
		return gson.toJson(list);
	}
	
	
	/* addMenus() 다성버전
	public int addMenus(HttpServletRequest request) { // 메뉴
		int i_rest = CommonUtils.getIntParameter("i_rest", request);
		String savePath = request.getServletContext().getRealPath("/res/img/restaurant");
		String tempPath = savePath + "/temp";// 임시
		FileUtils.makeFolder(tempPath);
		
		try {
			for (Part part : request.getParts()) {
				String fileName = FileUtils.getFileName(part);//파일이름 얻어옴
				System.out.println("fileName : " + fileName);
				if (fileName != null) {
					part.write(tempPath + "/" + fileName); //temp에 파일만듬
					String saveFileNm = "";
					String ext = FileUtils.getExt(fileName);
					saveFileNm = UUID.randomUUID() + ext;
					
					String targetPath = savePath + "/" + i_rest + "/menu";
					FileUtils.makeFolder(targetPath);
					
					File oldFile = new File(tempPath + "/" + fileName); // save + temp
					File newFiile = new File(targetPath + "/" + saveFileNm); // save + i_rest
					oldFile.renameTo(newFiile); // oldFile에 경로에 fileName으로 된 실제 파일이 있다면 newFiile경로에 saveFileNm이름으로 옮긴다
					
					RestaurantRecommendMenuVO param = new RestaurantRecommendMenuVO();
					
					param.setI_rest(i_rest);
					param.setMenu_pic(saveFileNm);
					dao.insMenu(param);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return i_rest;
	}
	*/
	
	// 위에 addMenus (쌤버전)
	public int addMenus(HttpServletRequest request) {
		int i_rest = CommonUtils.getIntParameter("i_rest", request);
		System.out.println("i_rest : " + i_rest);
		
		String targetPath = request.getServletContext().getRealPath("/res/img/restaurant/" + i_rest + "/menu");
		FileUtils.makeFolder(targetPath);
		
		RestaurantRecommendMenuVO param = new RestaurantRecommendMenuVO();
		param.setI_rest(i_rest);
		
        try {
        	for (Part part : request.getParts()) {
                String fileNm = part.getSubmittedFileName(); // 파일이름 받아오는 것
                System.out.println("fileNm : " + fileNm);
                
                if(fileNm != null) {
                	String ext = FileUtils.getExt(fileNm); // 확장자 이름 받아오기
                	String saveFileNm = UUID.randomUUID() + ext; // 이름 겹치지않게 하는 랜덤 문자
                	
                	System.out.println(targetPath);
                	
                	part.write(targetPath + "/" + saveFileNm); // 파일 저장
                	
                	param.setMenu_pic(saveFileNm);
                	dao.insMenus(param);
                }
            }      
        } catch(Exception e) {
        	e.printStackTrace();
        }
        
		return i_rest;
	
	}

	public int addRecMenus(HttpServletRequest request) {
		String savePath = request.getServletContext().getRealPath("/res/img/restaurant"); // 기준 주소 경로값
		String tempPath = savePath + "/temp"; // 임시 주소
		// 서버가 돌아가고 있는 위치의 절대 주소값이 넘어온다
		// c드라이브에서 시작되는 주소가 절대 주소이다
		// 리눅스에서는 \쓰면 안됨 그리고 굳이 \쓸 필요 없음
		FileUtils.makeFolder(tempPath); // 경로에 폴더가 없다면 폴더를 만들어 줌

		int maxFileSize = 10_485_760; // 1024 * 1024 * 10 (10mb) // 최대 파일 사이즈 크기
		MultipartRequest multi = null;
		int i_rest = 0;
		String[] menu_nmArr = null;
		String[] menu_priceArr = null;

		List<RestaurantRecommendMenuVO> list = null;
		try {
			
			multi = new MultipartRequest(request, tempPath, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
			//		서버에 부담 줄이는 파일로 만드는 객체 													DefaultFileRename 중복된 파일명이 있더라도 저장하게 해줌
			i_rest = CommonUtils.getIntParameter("i_rest", multi);
			System.out.println("i_rest : " + i_rest);
			menu_nmArr = multi.getParameterValues("menu_nm");
			menu_priceArr = multi.getParameterValues("menu_price");

			if (menu_nmArr == null || menu_priceArr == null) { // 둘 중에 하나라도 null이라면 다른 것도 null이기 때문에
				return i_rest;
			}

			list = new ArrayList();
			for (int i = 0; i < menu_nmArr.length; i++) {
				RestaurantRecommendMenuVO vo = new RestaurantRecommendMenuVO();
				System.out.println(menu_nmArr[0]);
				System.out.println(menu_nmArr[1]);
				// for문 돌 때마다 객체화한다
				vo.setI_rest(i_rest);
				vo.setMenu_nm(menu_nmArr[i]);
				vo.setMenu_price(CommonUtils.parseStringToInt(menu_priceArr[i]));
				list.add(vo);
			}

			// 이미지
			String targetPath = savePath + "/" + i_rest;
			FileUtils.makeFolder(targetPath);

			String originFileNm = ""; // 바꿀 이름 name, name
			String saveFileNm = ""; // name1 name2
			Enumeration files = multi.getFileNames(); // Enumeration 리스트와 비슷한 인터페이스
			while (files.hasMoreElements()) { // hasMoreElement는 스택처럼 발동 FILO
				String key = (String) files.nextElement(); // nextElement는 다음 값의 키값을 준다 rs.next() 랑 비슷함
				originFileNm = multi.getFilesystemName(key); // 이름 바꿔주는 메소드

				if (originFileNm != null) { // 파일 선택을 안했으면 null이 넘어옴
					String ext = FileUtils.getExt(originFileNm); //확장자 얻어오기
					// original 파일 name
					saveFileNm = UUID.randomUUID() + ext;
					// 실제로 데이터베이스에 저장할 파일의 name

					System.out.println("saveFileNm : " + saveFileNm);
					File oldFile = new File(tempPath + "/" + originFileNm); // save + temp
					File newFiile = new File(targetPath + "/" + saveFileNm); // save + i_rest
					oldFile.renameTo(newFiile);

					int idx = CommonUtils.parseStringToInt(key.substring(key.lastIndexOf("_") + 1));
					RestaurantRecommendMenuVO vo = list.get(idx);
					vo.setMenu_pic(saveFileNm); // _까지 잘라서 뒤에를 넘겨줌
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		if (list != null) {
			for (RestaurantRecommendMenuVO vo : list) {
				dao.insRecommendMenu(vo);
			}
		}

		return i_rest;

	}

	public List<RestaurantRecommendMenuVO> getRecommendMenuList(int i_rest) {
		return dao.selRecommendMenuList(i_rest);
	}

	public int delRecMenu(RestaurantRecommendMenuVO param) {
		return dao.delRecommendMenu(param);
	}
	
	public List<RestaurantRecommendMenuVO> getMenuList(int i_rest) {
		return dao.selMenuList(i_rest);
	}
}
