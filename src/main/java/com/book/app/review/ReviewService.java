package com.book.app.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {
	
	@Autowired
	private ReviewMapper reviewMapper;
	
	public int create(ReviewDTO reviewDTO) throws Exception {
		return reviewMapper.create(reviewDTO);
	}
	
	public List<ReviewDTO> list(ReviewDTO reviewDTO) throws Exception {
        return reviewMapper.list(reviewDTO);
    }
	
	public int delete(ReviewDTO reviewDTO) throws Exception {
		return reviewMapper.delete(reviewDTO);
	}
	
	public int update(ReviewDTO reviewDTO) throws Exception {
	    return reviewMapper.update(reviewDTO);
	}

}
