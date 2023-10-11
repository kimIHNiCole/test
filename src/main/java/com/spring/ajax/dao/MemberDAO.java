package com.spring.ajax.dao;

import java.util.ArrayList;
import java.util.HashMap;

public interface MemberDAO {

	int overlay(String id);

	int join(HashMap<String, String> params);

	int setPermission(String id, String perm);

	HashMap<String, Object> login(HashMap<String, String> params);

	ArrayList<HashMap<String, Object>> mList();

	ArrayList<HashMap<String, Object>> bList();

}
