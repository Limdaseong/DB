package com.koreait.matzip.restaurant;

import java.util.List;

import com.google.gson.Gson;

public class RestaurantService {
	
	private RestaurantDAO dao;
	
	public RestaurantService() {
		dao = new RestaurantDAO();
	}
	
	public int restReg(RestaurantRegVO param) {
		return dao.reg(param);
	}
	
	public RestaurantDomain getRest(RestaurantRegVO param) {
		return dao.selRest(param);
	}
	
	public String getRestList() {
		List<RestaurantDomain> list = dao.selRestList();
		Gson gson = new Gson();
		return gson.toJson(list);
	}
}
