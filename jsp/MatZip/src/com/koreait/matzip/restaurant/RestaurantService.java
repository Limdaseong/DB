package com.koreait.matzip.restaurant;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.google.gson.Gson;
import com.koreait.matzip.CommonUtils;
import com.koreait.matzip.FIleUtils;
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
	
	public int addRecMenus(HttpServletRequest request) {
		String savePath = request.getServletContext().getRealPath("/res/img/restaurant"); // 기준 주소 경로값
		String tempPath = savePath + "/temp"; // 임시 주소
		// 서버가 돌아가고 있는 위치의 절대 주소값이 넘어온다  
		// c드라이브에서 시작되는 주소가 절대 주소이다
		// 리눅스에서는 \쓰면 안됨 그리고 굳이 \쓸 필요 없음
		FIleUtils.makeFolder(tempPath); // 경로에 폴더가 없다면 폴더를 만들어 줌
		
		int maxFileSize = 10_485_760; // 1024 * 1024 * 10 (10mb) // 최대 파일 사이즈 크기
		MultipartRequest multi = null;
		int i_rest = 0;
		String[] menu_nmArr = null;
		String[] menu_priceArr = null;
		
		List<RestaurantRecommendMenuVO> list = null;
		try {
			
			multi = new MultipartRequest(request, tempPath, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
																//DefaultFileRename	중복된 파일명이 있더라도 저장하게 해줌
			i_rest = CommonUtils.getIntParameter("i_rest", multi);
			System.out.println("i_rest : " + i_rest);
			menu_nmArr = multi.getParameterValues("menu_nm");
			menu_priceArr = multi.getParameterValues("menu_price");
			
			if(menu_nmArr == null || menu_priceArr == null) { // 둘 중에 하나라도 null이라면 다른 것도 null이기 때문에
				return i_rest;  
			}
			
			
			list = new ArrayList();
			for(int i=0; i<menu_nmArr.length; i++) {
				RestaurantRecommendMenuVO vo = new RestaurantRecommendMenuVO();
				// for문 돌 때마다 객체화한다
				vo.setI_rest(i_rest);
				vo.setMenu_nm(menu_nmArr[i]);
				vo.setMenu_price(CommonUtils.parseStringToInt(menu_priceArr[i]));
				list.add(vo);
			}
			
			// 이미지
			String targetPath = savePath + "/" + i_rest;
			FIleUtils.makeFolder(targetPath);
			
			String originFileNm ="";
			String saveFileNm = "";
			Enumeration files = multi.getFileNames(); //Enumeration 리스트와 비슷한 인터페이스
			while(files.hasMoreElements()) { // hasMoreElement는 스택처럼 발동 FILO
				String key = (String)files.nextElement(); //nextElement는 다음 값의 키값을 준다
				originFileNm = multi.getFilesystemName(key);
				
				if(originFileNm != null) { // 파일 선택을 안했으면 null이 넘어옴
					String ext = FIleUtils.getExt(originFileNm);
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
		
		if(list != null) {
			for(RestaurantRecommendMenuVO vo : list) {
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
}
