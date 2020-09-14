package com.koreait.matzip.restaurant;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.koreait.matzip.CommonDAO;
import com.koreait.matzip.CommonUtils;
import com.koreait.matzip.Const;
import com.koreait.matzip.SecurityUtils;
import com.koreait.matzip.ViewRef;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class RestaurantController {
	private RestaurantService service;
	
	public RestaurantController() {
		service = new RestaurantService();
	}
	
	public String restMap(HttpServletRequest request) {
		request.setAttribute(Const.TITLE, "지도보기");
		request.setAttribute(Const.VIEW, "restaurant/restMap");
		return ViewRef.TEMP_MENU_TEMP;
	}
	
	public String restReg(HttpServletRequest request) {
		final int I_M = 1; //카테고리 코드
		request.setAttribute("categoryList", CommonDAO.selCodeList(1));
		
		request.setAttribute(Const.TITLE, "가게 등록");
		request.setAttribute(Const.VIEW, "restaurant/restReg");
		return ViewRef.TEMP_MENU_TEMP;
	}
	
	public String restRegProc(HttpServletRequest request) {
		
		String nm = request.getParameter("nm");
		String addr = request.getParameter("addr");
		String strLat = request.getParameter("lat");
		String strLng = request.getParameter("lng");
		double lat = Double.parseDouble(strLat);
		double lng = Double.parseDouble(strLng);
		String strCd_category = request.getParameter("cd_category");
		int cd_category = Integer.parseInt(strCd_category);
		int i_user = SecurityUtils.getLoginUser(request).getI_user(); 
		
		RestaurantRegVO param = new RestaurantRegVO();
		
		param.setNm(nm);
		param.setAddr(addr);
		param.setLat(lat);
		param.setLng(lng);
		param.setCd_category(cd_category);
		param.setI_user(i_user);
		
		service.restReg(param);
		
		
		return "redirect:/restaurant/restMap";
	}
	
	public String restDetail(HttpServletRequest request) {
		int i_rest = CommonUtils.parseStringToInt(request.getParameter("i_rest"));
		
		RestaurantRegVO param = new RestaurantRegVO();
		param.setI_rest(i_rest);
		
		request.setAttribute("data", service.getRest(param));
		request.setAttribute(Const.TITLE, "디테일");
		request.setAttribute(Const.VIEW, "restaurant/restDetail");
		
		return ViewRef.TEMP_MENU_TEMP;
	}
	
	public String ajaxGetList(HttpServletRequest request) {
		return "ajax:" + service.getRestList();
	}
	
	public String addRecMenusProc(HttpServletRequest request) {
		String uploads = request.getRealPath("/res/img");
		MultipartRequest multi = null;
		String strI_rest = null;
		String[] menu_nmArr = null;
		String[] menu_priceArr = null;
		
		try {
			multi=new MultipartRequest(request, uploads, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
			
			strI_rest = multi.getParameter("i_rest");
			menu_nmArr = multi.getParameterValues("menu_nm");
			menu_priceArr = multi.getParameterValues("menu_price");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(menu_nmArr != null && menu_priceArr != null) {
			for(int i=0; i<menu_nmArr.length; i++) {
				System.out.println(i + " : " + menu_nmArr[i] + ", " + menu_priceArr[i]);
			}
		}

		
		
		return "redirect:/restaurant/restDetail?i_rest=" + strI_rest;
	}
}
