package com.spring.ajax.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.spring.ajax.dto.BoardDTO;

public interface BoardDAO {

	ArrayList<BoardDTO> bList();

	ArrayList<String> getPhoto(String idx);

	int delete(String idx);
;
}
