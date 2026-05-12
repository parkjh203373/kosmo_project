package com.book.app.dealboard;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.book.app.file.FileManager;
import com.book.app.pager.Pager;

@Service
public class DealboardService {

	@Autowired
	private DealboardMapper dealboardMapper;
	
	@Autowired
	private FileManager fileManager;
	
	@Value("${app.dealboard}")
	private String name;
		
	public List<DealboardDTO> list(Pager pager) throws Exception {
	    // 1. DB에서 건너뛸 행(OFFSET) 계산
	    pager.makeStartNum(); 
	    
	    // 2. 전체 데이터 개수 조회 및 페이징 블록 계산
	    Long totalCount = dealboardMapper.getTotalCount(pager);
	    pager.makePageNum(totalCount);
	    
	    // 3. 데이터 조회
	    return dealboardMapper.list(pager);
	}
	
	public DealboardDTO detail(DealboardDTO dealboardDTO) throws Exception{
		return dealboardMapper.detail(dealboardDTO);
	}
	
	public int create(DealboardDTO dealboardDTO, OldbookDTO oldbookDTO, MultipartFile attach) throws Exception {

        int result = dealboardMapper.createOldbook(oldbookDTO);
        
        if(attach != null && !attach.isEmpty()) {
            String fileName = fileManager.fileSave(name, attach);
            
            OldbookFileDTO fileDTO = new OldbookFileDTO();
            fileDTO.setFileName(fileName);
            fileDTO.setOriName(attach.getOriginalFilename());
            fileDTO.setOldbookNum(oldbookDTO.getOldbookNum());
            
            result = dealboardMapper.createOldbookFile(fileDTO);
        }
        
        if(result > 0) {
            dealboardDTO.setOldbookNum(oldbookDTO.getOldbookNum());
            result = dealboardMapper.createBoard(dealboardDTO);
        }
        
        return result;
    }
}
