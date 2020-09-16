package com.koreait.matzip.restaurant;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.koreait.matzip.CommonDAO;
import com.koreait.matzip.CommonUtils;
import com.koreait.matzip.Const;
import com.koreait.matzip.FileUtils;
import com.koreait.matzip.SecurityUtils;
import com.koreait.matzip.ViewRef;
import com.koreait.matzip.vo.RestaurantRecommendMenuVO;
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
		
		RestaurantVO param = new RestaurantVO();
		
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
		
		RestaurantVO param = new RestaurantVO();
		param.setI_rest(i_rest);
		
		request.setAttribute("css", new String[]{"restaurant.css"});
		request.setAttribute("recommendMenuList", service.getRecommendMenuList(i_rest));
		request.setAttribute("menuList", service.getMenuList(i_rest));
		request.setAttribute("data", service.getRest(param));
		request.setAttribute(Const.TITLE, "디테일");
		request.setAttribute(Const.VIEW, "restaurant/restDetail");
		
		return ViewRef.TEMP_MENU_TEMP;
	}
	
	public String ajaxGetList(HttpServletRequest request) {
		return "ajax:" + service.getRestList();
	}
	
	public String addRecMenusProc(HttpServletRequest request) {
		int i_rest = service.addRecMenus(request);
		return "redirect:/restaurant/restDetail?i_rest=" + i_rest;
	}
	
	public String addMenusProc(HttpServletRequest request) {
		int i_rest = service.addMenus(request);
		return "redirect:/restaurant/restDetail?i_rest=" + i_rest;
	}
	
	public String ajaxDelRecMenu(HttpServletRequest request) {
		int i_rest = CommonUtils.getIntParameter("i_rest", request);
		int seq = CommonUtils.getIntParameter("seq", request);
		int i_user = SecurityUtils.getLoginUserPk(request);
		
		RestaurantRecommendMenuVO param = new RestaurantRecommendMenuVO();
		param.setI_rest(i_rest);
		param.setSeq(seq);
		param.setI_user(i_user);
		
		int result = service.delRecMenu(param);
		
		return "ajax:" + result;
	}
}
