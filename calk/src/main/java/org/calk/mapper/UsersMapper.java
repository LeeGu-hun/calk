package org.calk.mapper;

import org.calk.domain.UserVO;

public interface UsersMapper {
	public UserVO checkLogin(String id);
}
