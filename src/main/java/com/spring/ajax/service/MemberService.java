package com.spring.ajax.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.ajax.dao.MemberDAO;

@Service
public class MemberService {

	Logger logger=LoggerFactory.getLogger(getClass());
	@Autowired MemberDAO dao;
	public boolean overlay(String id) {
		boolean use=false;
		int cnt=dao.overlay(id);
		if(cnt ==0) {
			use=true;
		}
		return use;
	}
	public int join(HashMap<String, String> params) {
		int row=0;
		
		row=dao.join(params);
		if(row>0 && params.get("auth")!=null) {
			row= dao.setPermission(params.get("id"),"admin");
		}
		return row;
	}

	public HashMap<String, Object> login(HashMap<String, String> params) {
		return dao.login(params);
	}
	public ArrayList<HashMap<String, Object>> mList() {
		return dao.mList();
	}
	/*
	public ArrayList<HashMap<String, Object>> bList() {
		return dao.bList();
	}
	*/

}
