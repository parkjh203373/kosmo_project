package com.book.app.file;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManager {
	
	@Value("${app.upload.base}")
	private String path;
	
	public boolean fileDelete(String name, FileDTO fileDTO) throws Exception {
	    File dir = new File(path, name);
	    File file = new File(dir, fileDTO.getFileName());
	    
	    if (!file.exists()) {
	        System.err.println("삭제 실패: 파일이 해당 경로에 존재하지 않습니다 -> " + file.getAbsolutePath());
	        return false;
	    }
	    
	    boolean result = file.delete();
	    
	    if (result) {
	        System.out.println("파일 삭제 성공: " + file.getName());
	    } else {
	        System.err.println("파일 삭제 실패: 권한 문제나 다른 프로세스 사용 중일 수 있음 -> " + file.getAbsolutePath());
	    }
	    
	    return result;
	}
	
	public String fileSave(String name, MultipartFile mf) throws Exception {
		File file = new File(path, name);
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String fileName = UUID.randomUUID().toString();
		fileName = fileName + "_" + mf.getOriginalFilename();
		file = new File(file, fileName);
		
		FileCopyUtils.copy(mf.getBytes(), file);
		
		return fileName;
	}
	
}
