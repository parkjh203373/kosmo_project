package com.book.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.book.app.file.FileDTO;
import com.book.app.file.FileManager;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class MemberService implements UserDetailsService{

	@Value("${app.member}")
	private String name;
		
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println(username);
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setUsername(username);
		memberDTO = memberMapper.detail(memberDTO);
		log.info("{}", memberDTO);
		return memberDTO;
	}
	
	public int idCheck(MemberDTO memberDTO) throws Exception{
		return memberMapper.idCheck(memberDTO);
	}
	
	public MemberDTO detail(MemberDTO memberDTO) throws Exception {
		
		return memberMapper.detail(memberDTO);
	}
	
	public int create(MemberDTO memberDTO, MultipartFile file) throws Exception {
		
		memberDTO.setPassword(passwordEncoder.encode(memberDTO.getPassword()));
		
		int result = memberMapper.create(memberDTO);
		
		MemberRoleDTO memberRoleDTO = new MemberRoleDTO();
		memberRoleDTO.setRoleNum(3L);
		memberRoleDTO.setUsername(memberDTO.getUsername());
		
		result = memberMapper.addMemberRole(memberRoleDTO);
		
		if(file != null && !file.isEmpty()) {
			String fileName = fileManager.fileSave(name, file);
		
		ProfileDTO profileDTO = new ProfileDTO();
		profileDTO.setFileName(fileName);
		profileDTO.setOriName(file.getOriginalFilename());
		profileDTO.setUsername(memberDTO.getUsername());
		
		result = memberMapper.addProfile(profileDTO);
		}
		
		return result;
	}
	
	public int deleteId(MemberDTO memberDTO) throws Exception {
	    System.out.println("Service 진입 - 삭제 요청 번호: " + memberDTO.getUsername());

	    if (memberDTO.getUsername() == null) {
	        System.out.println("탈퇴 실패: 회원 번호가 넘어오지 않았습니다.");
	        return 0;
	    }
	    
	    MemberDTO detail = memberMapper.detail(memberDTO); 

	   if (detail.getProfileDTO() != null && detail.getProfileDTO().getFileName() != null) {
		   String fileName = detail.getProfileDTO().getFileName();
	            
	       FileDTO fileDTO = new FileDTO();
	       fileDTO.setFileName(fileName);
	       
	       boolean isDeleted = fileManager.fileDelete(name, fileDTO);
	            
	    }
	    
	    ProfileDTO profileDTO = new ProfileDTO();
	    profileDTO.setUsername(memberDTO.getUsername());
	    
	    int profileRes = memberMapper.deleteProfile(profileDTO);
	    int memberRes = memberMapper.deleteId(memberDTO);
	    
	    int result = profileRes * memberRes;
	    return result;
	}
	
	public int updateId(MemberDTO memberDTO, MultipartFile attach) throws Exception {
	    if (memberDTO.getUsername() == null) {
	        return 0;
	    }
	    
	    // 1. 기존 회원 정보 조회 (DB에 저장된 암호화된 기존 비번을 가져오기 위함)
	    MemberDTO currentMember = memberMapper.detail(memberDTO);

	    // 2. 비밀번호 처리 로직
	    if (memberDTO.getPassword() != null && !memberDTO.getPassword().trim().isEmpty()) {
	        // 사용자가 새 비밀번호를 입력한 경우 -> 암호화해서 세팅
	        String encodedPwd = passwordEncoder.encode(memberDTO.getPassword());
	        memberDTO.setPassword(encodedPwd);
	    } else {
	        // 사용자가 비밀번호를 입력하지 않은 경우 -> DB에 있던 기존 암호화된 비번을 다시 세팅
	        memberDTO.setPassword(currentMember.getPassword());
	    }
	    
	    int result = memberMapper.updateId(memberDTO);

	    if (attach != null && !attach.isEmpty()) {
	        MemberDTO detail = memberMapper.detail(memberDTO);
	        if (detail.getProfileDTO() != null) {
	            FileDTO oldFile = new FileDTO();
	            oldFile.setFileName(detail.getProfileDTO().getFileName());
	            fileManager.fileDelete(name, oldFile); 
	        }

	        String newFileName = fileManager.fileSave(name, attach);

	        ProfileDTO profileDTO = new ProfileDTO();
	        profileDTO.setUsername(memberDTO.getUsername());
	        profileDTO.setFileName(newFileName);
	        profileDTO.setOriName(attach.getOriginalFilename());

	        result = memberMapper.updateProfile(profileDTO);
	    }
	    
	    return result;
	}
}
