package com.book.app.book;

import java.net.URI;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.book.app.pager.Pager;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/book/*")
public class BookController {
	
	@Autowired
	private BookService bookService;
	
	@Value("${naver.client.id}")
    private String clientId;

    @Value("${naver.client.secret}")
    private String clientSecret;

    @GetMapping("api/bookSearch")
    @ResponseBody
    public String bookSearch(@RequestParam(name = "query") String query) {
        RestTemplate restTemplate = new RestTemplate();

        // 1. URL 생성 (한글 검색어 인코딩 포함)
        URI uri = UriComponentsBuilder
                .fromUriString("https://openapi.naver.com")
                .path("/v1/search/book.json")
                .queryParam("query", query)
                .queryParam("display", 10)
                .encode()
                .build()
                .toUri();

        // 2. 헤더 설정
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Naver-Client-Id", clientId);
        headers.set("X-Naver-Client-Secret", clientSecret);
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        // 3. API 호출 및 결과 반환
        try {
            ResponseEntity<String> response = restTemplate.exchange(uri, HttpMethod.GET, entity, String.class);
            return response.getBody();
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"error\":\"API 호출 실패\"}";
        }
    }

	
	@GetMapping("list")
	public String list(Model model, Pager pager) throws Exception {
		List<BookDTO> ar = bookService.list(pager);
		
		model.addAttribute("list", ar);
		model.addAttribute("pager", pager);
		
		return "book/list";
	}
	
	@GetMapping("detail")
	public String detail(BookDTO bookDTO, Model model, HttpSession session) throws Exception {
		Object member = session.getAttribute("member");
		
		if(member == null) {
			return "redirect:/member/login?redirectUrl=/book/list";
		}
		
		bookDTO = bookService.detail(bookDTO);
		model.addAttribute("d", bookDTO);
//		model.addAttribute("pager", pager);
		
		return "book/detail";
	}
	
	@GetMapping("create")
	public void create() throws Exception {}
	
	@PostMapping("create")
	public String create(BookDTO bookDTO) throws Exception {
		int result = bookService.create(bookDTO);
		
		return "redirect:./list";
	}
	
	@GetMapping("update")
	public String update(BookDTO bookDTO, Model model) throws Exception {
		bookDTO = bookService.detail(bookDTO);
		model.addAttribute("d", bookDTO);
		
		return "book/update";
	}
	
	@PostMapping("update")
	public String update(BookDTO bookDTO) throws Exception {
		int result = bookService.update(bookDTO);
		
		return "redirect:./detail?bookNum=" + bookDTO.getBookNum();
	}
	
	@PostMapping("delete")
	public String delete(BookDTO bookDTO) throws Exception {
		int result = bookService.delete(bookDTO);
		
		return "redirect:./list";
	}

}
