package com.spring.DCShop.mypage.dao;

import java.util.List;
import java.util.Map;

import com.spring.DCShop.board.dto.BoardDTO;
import com.spring.DCShop.user.dto.UserDTO;
import com.spring.DCShop.mypage.dto.OrderDTO;

public interface MypageDAO {
	
	public List<OrderDTO> getOrderList(Map<String, Object> productListInfo);
	
	public List<UserDTO> mypageAdminUserList1();
	
	public List<BoardDTO> adminBoardList(Map<String, Object> param);
	
	public int adminBoardCount(Map<String, Object> param);
	
}
