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
	
	private void removeExistingFile(DealboardDTO dealboardDTO) throws Exception {
       
		DealboardDTO fullData = dealboardMapper.detail(dealboardDTO);

	    if (fullData != null && fullData.getOldbookDTO() != null 
	        && fullData.getOldbookDTO().getOldbookFileDTO() != null) {
	        
	        OldbookFileDTO fileDTO = fullData.getOldbookDTO().getOldbookFileDTO();
	        
	        // [중요] 삭제 기준이 될 번호가 확실히 있는지 확인
	        // 만약 fileDTO에 oldbookNum이 없다면 직접 넣어줍니다.
	        if(fileDTO.getOldbookNum() == null) {
	            fileDTO.setOldbookNum(fullData.getOldbookNum());
	        }

	        // 2. 서버 실물 파일 삭제
	        if (fileDTO.getFileName() != null) {
	            fileManager.fileDelete(name, fileDTO);
	        }
	        
	        // 3. DB 파일 레코드 삭제 (이 메서드가 호출되어야 DB에서 사라집니다)
	        System.out.println("삭제 시도 번호 : " + fileDTO.getOldbookNum());
	        int result = dealboardMapper.delOldbookFile(fileDTO);
	        System.out.println("DB 파일 삭제 결과: " + result); // 로그를 찍어 1이 나오는지 확인해보세요.
	    }
    }
	public int deleteBoard(DealboardDTO dealboardDTO) throws Exception {
        // 1. 파일 삭제 프로세스 호출
        this.removeExistingFile(dealboardDTO);

        // 2. 삭제를 위해 필요한 번호들 조회
        DealboardDTO fullData = dealboardMapper.detail(dealboardDTO);
        if (fullData == null) return 0;

        // 3. 도서 정보 삭제
        OldbookDTO oldbookDTO = new OldbookDTO();
        oldbookDTO.setOldbookNum(fullData.getOldbookNum());
        dealboardMapper.delOldbookDTO(oldbookDTO);

        // 4. 최종 게시판 글 삭제
        return dealboardMapper.delBoard(dealboardDTO);
    }
	
	public int update(DealboardDTO dealboardDTO, MultipartFile attach) throws Exception {
        // 1. 게시글 및 도서 기본 정보 업데이트
        int result = dealboardMapper.updateBoard(dealboardDTO);
        dealboardMapper.updateOldbook(dealboardDTO.getOldbookDTO());

        // 2. 새로운 첨부파일이 들어온 경우
        if (attach != null && !attach.isEmpty()) {
            // 💡 [재사용] 기존 파일을 깔끔하게 삭제
            this.removeExistingFile(dealboardDTO);

            // 3. 새 파일 저장 및 DB 등록 (Insert)
            String fileName = fileManager.fileSave(name, attach);
            
            OldbookFileDTO newFile = new OldbookFileDTO();
            newFile.setFileName(fileName);
            newFile.setOriName(attach.getOriginalFilename());
            newFile.setOldbookNum(dealboardDTO.getOldbookDTO().getOldbookNum());
            
            result = dealboardMapper.createOldbookFile(newFile);
        }
        
        return result;
    }
}
