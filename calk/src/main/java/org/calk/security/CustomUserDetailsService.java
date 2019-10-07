package org.calk.security;

import org.calk.domain.UserVO;
import org.calk.mapper.UsersMapper;
import org.calk.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Setter(onMethod_ = { @Autowired })
	private UsersMapper usersMapper;

	@Override
	public UserDetails loadUserByUsername(String username) {
		log.info("Load User By username : " + username);
		//return null;
		// userName means id
		UserVO vo;
		try {
			vo = usersMapper.checkLogin(username);
			log.warn("queried by member mapper: " + vo);
			return vo == null ? null : new CustomUser(vo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
