package com.book.app.member;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO implements UserDetails {
	

	private String username;
	private String password;
	private String memberName;
	private LocalDate memberBirth;
	private String memberEmail;
	
	private ProfileDTO profileDTO;
	
	private List<RoleDTO> roles;
	
	private boolean accountNonExpired;
	
	private boolean accountNonLocked;
	
	private boolean credentialsNonExpired;
	
	private boolean enabled;
	
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		List<GrantedAuthority> ar = new ArrayList<>();
		for(RoleDTO roleDTO : roles) {
		    String roleName = roleDTO.getRoleName();
		    if (!roleName.startsWith("ROLE_")) {
		        roleName = "ROLE_" + roleName;
		    }
		    GrantedAuthority g = new SimpleGrantedAuthority(roleName); // "ROLE_MEMBER"로 변환됨
		    ar.add(g);
		}
		
		return ar;
	}
}
