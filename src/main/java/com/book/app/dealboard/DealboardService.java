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
	
	public int deleteBoard(DealboardDTO dealboardDTO, OldbookDTO oldbookDTO,
            OldbookFileDTO oldbookFileDTO) throws Exception {
    
    // 1. 부족한 정보 보충 (DB에서 실제 데이터 조회)
    // 파라미터로 넘어온 dealboardDTO에는 번호(PK)만 있을 확률이 높으므로 전체 데이터를 가져옵니다.
    DealboardDTO fullData = dealboardMapper.detail(dealboardDTO); 
    
    if (fullData == null) {
        System.out.println("삭제할 데이터가 DB에 존재하지 않습니다.");
        return 0;
    }

    // 2. 조회된 정보를 바탕으로 DTO들 세팅
    oldbookDTO.setOldbookNum(fullData.getOldbookNum());
    oldbookFileDTO.setOldbookNum(fullData.getOldbookNum());
    
    //안전한 파일명 추출 방식
    if (fullData.getOldbookDTO() != null && 
        fullData.getOldbookDTO().getOldbookFileDTO() != null) {
        
        String fileName = fullData.getOldbookDTO().getOldbookFileDTO().getFileName();
        oldbookFileDTO.setFileName(fileName);
    }

    // 3. 물리 파일 삭제
    if (oldbookFileDTO.getFileName() != null && !oldbookFileDTO.getFileName().isEmpty()) {
        fileManager.fileDelete("dealboard", oldbookFileDTO); 
    }

    // 4. DB 삭제 (자식 -> 부모 순서)
    // 파일 정보 삭제
    int fileRes = dealboardMapper.delOldbookFile(oldbookFileDTO);
    
    // 중고책 정보 삭제
    int bookRes = dealboardMapper.delOldbookDTO(oldbookDTO);
    
    // 최종 게시판 글 삭제
    int boardRes = dealboardMapper.delBoard(dealboardDTO);
        
    return boardRes;
	}
}
