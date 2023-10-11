package com.spring.ajax.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.ajax.dao.BoardDAO;
import com.spring.ajax.dto.BoardDTO;

@Service
public class BoardService {
Logger logger= LoggerFactory.getLogger(getClass());
	@Autowired BoardDAO dao;
	public ArrayList<BoardDTO> bList() {	
		return dao.bList();
	}

	public int delete(ArrayList<String> delList) {
		int cnt = 0;
		logger.info("delList"+delList);
		for(String idx : delList) {
			// 글에 해당되는 사진이 있는지 확인
			ArrayList<String> photos = dao.getPhoto(idx);
			cnt+=dao.delete(idx); // 글 지우기
			// 사진이 있으면 삭제
			delPhoto(photos);
		}
		
		return cnt;
	}

	private void delPhoto(ArrayList<String> photos) {
		logger.info("photos"+photos);
		if(photos != null && photos.size() > 0) {
			for (String photo : photos) {
				File file = new File("C:/upload/"+photo);
				logger.info("photo"+file.exists());
				if(file.exists()) {
					
					file.delete();
				}
			}
		}
		
	}

	

}
