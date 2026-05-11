package com.book.app.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
}
