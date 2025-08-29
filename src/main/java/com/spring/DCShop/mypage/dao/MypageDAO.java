package com.spring.DCShop.mypage.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.board.dto.BoardDTO;
import com.spring.DCShop.user.dto.UserDTO;

public interface MypageDAO {
	
	public List<UserDTO> mypageAdminUserList1();
	
	public List<BoardDTO> adminBoardList(Map<String, Object> param);
	
	public int adminBoardCount(Map<String, Object> param);
}
