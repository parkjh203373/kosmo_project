package com.book.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.book.app.file.FileDTO;
import com.book.app.file.FileManager;


@Service
public class MemberService {

	@Value("${app.member}")
	private String name;
		
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private FileManager fileManager;
		
	public MemberDTO detail(MemberDTO memberDTO) throws Exception {
		
		return memberMapper.detail(memberDTO);
	}
	
	public int create(MemberDTO memberDTO, MultipartFile file) throws Exception {
		
		int result = memberMapper.create(memberDTO);
		
		if(file != null && !file.isEmpty()) {
			String fileName = fileManager.fileSave(name, file);
		
		ProfileDTO profileDTO = new ProfileDTO();
		profileDTO.setFileName(fileName);
		profileDTO.setOriName(file.getOriginalFilename());
		profileDTO.setMemberNum(memberDTO.getMemberNum());
		
		result = memberMapper.addProfile(profileDTO);
		}
		
		return result;
	}
	
	public int deleteId(MemberDTO memberDTO) throws Exception {
	    System.out.println("Service 진입 - 삭제 요청 번호: " + memberDTO.getMemberNum());

	    if (memberDTO.getMemberNum() == null || memberDTO.getMemberNum() == 0) {
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
	    profileDTO.setMemberNum(memberDTO.getMemberNum());
	    
	    int result = memberMapper.deleteProfile(profileDTO);
	    
	    if(result > 0) {
	        result = memberMapper.deleteId(memberDTO);
	    }

	    return result;
	}
	
	public int updateId(MemberDTO memberDTO, MultipartFile attach) throws Exception {
	    if (memberDTO.getMemberNum() == null || memberDTO.getMemberNum() == 0) {
	        return 0;
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
	        profileDTO.setMemberNum(memberDTO.getMemberNum());
	        profileDTO.setFileName(newFileName);
	        profileDTO.setOriName(attach.getOriginalFilename());

	        result = memberMapper.updateProfile(profileDTO);
	    }
	    
	    return result;
	}
}
