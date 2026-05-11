package com.book.app.book;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.book.app.pager.Pager;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/book/*")
public class BookController {
	
	@Autowired
	private BookService bookService;
	
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
