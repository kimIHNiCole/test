package com.spring.ajax.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.ajax.dto.MemberDTO;
import com.spring.ajax.service.MemberService;

@Controller
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MemberService service;
	@RequestMapping(value={"/", "/index"})
	public String index() {
		return "index";
	}
	
	@RequestMapping(value="/joinForm")
	public String joinForm() {
		return "joinForm";
	}
	//ajax 통신의 규칙
	// 1. Response 형태로 반환해야 한다.(ajax 는 요청하는 곳과 데이터 받는 곳이 같아야 한다.) -> 페이지 이동 안 됨
	// 2. json 과 가장 비슷한 형태로 반환해야 한다. ({key:value},{key=value})
	// 3. json 형태로 바꿔줄 라이브러리가 필요하다.
	@RequestMapping(value="/overlay")
	@ResponseBody // ajax 에서 반환하는 값을 response 에 그려주는 역할을 한다.
	public HashMap<String, Object> overlay(@RequestParam String id) {
		boolean use=service.overlay(id);
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("use", use);
		// response 는 출력(페이지 그리기)이 되는 객체이므로 기존 페이지 위에 값을 출력해 버린다.
		return map;
	}
	
	@RequestMapping(value="/join", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> join(@RequestParam HashMap<String, String> params){
		logger.info("params : "+params);
		HashMap<String, Object> result = new HashMap<String, Object>();
		int row=service.join(params);
		result.put("success", row);
		return result;
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> login(@RequestParam HashMap<String, String> params,
			HttpSession session){
		logger.info("params : "+params);
		HashMap<String, Object> result = service.login(params);
		logger.info("result : "+result);
		if(result==null) {
			result=new HashMap<String, Object>();
			result.put("msg", "아이디 또는 비밀번호를 확인하세요.");
		}else {
			result.put("msg", "로그인에 성공하였습니다.");
			session.setAttribute("loginId", result.get("id"));
			session.setAttribute("name", result.get("name"));
			session.setAttribute("perm", result.get("perm"));
		}
		return result;
	}
	
	@RequestMapping(value="/memberList")
	public String memberList(HttpSession session) {
		return "memberList";
	}
	/*
	@RequestMapping(value="/boardList")
	public String boardList(HttpSession session) {
		return "boardList";
	}
	*/
	/*
	@RequestMapping(value="/list")
	@ResponseBody
	public ArrayList<HashMap<String, Object>> list(HttpSession session) {
		ArrayList<HashMap<String, Object>> result = service.list();
		logger.info("result : "+result);
		return result;
	}
	*/
	@RequestMapping(value="/mList")
	@ResponseBody
	public HashMap<String, Object> mList(HttpSession session) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		if(session.getAttribute("loginId") != null && session.getAttribute("perm") !=null) {
			result.put("success", 1);
			ArrayList<HashMap<String, Object>> mList = service.mList();
			result.put("mList", mList);
			result.put("size", mList.size());
		}else {
			result.put("success", -1);
		}
		logger.info("result : "+result);
		return result;
	}
	
	/*
	@RequestMapping(value = "/bList")
	@ResponseBody
	public HashMap<String, Object> bList(HttpSession session) {
		HashMap<String, Object> result = new HashMap<String, Object>();

		ArrayList<HashMap<String, Object>> bList = service.bList();

		result.put("bList", bList);
		result.put("size", bList.size());
		logger.info("result : " + result);
		return result;
	}
	*/
	
	
	
	
	
	
	
	
}
