package kr.co.dbslab.user.inquiry.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.dbslab.user.inquiry.domain.Inquiry;
import kr.co.dbslab.user.inquiry.domain.InquiryDetail;
import kr.co.dbslab.user.inquiry.service.InquiryService;
import kr.co.dbslab.user.inquiry.vo.InquiryDeleteVO;
import kr.co.dbslab.user.inquiry.vo.InquiryUpdateVO;
import kr.co.dbslab.user.inquiry.vo.InquiryVO;
import kr.co.dbslab.user.inquiry.vo.InquiryWriteVO;
import kr.co.dbslab.user.member.domain.Member;
import kr.co.dbslab.user.member.service.MemberService;

@Controller
public class InquiryController {
	
	private MemberService ms;
	
	private void sessionCheck(HttpSession session) {
		if( session.getAttribute("memberInform") != null) {
			ms = new MemberService();
			Member member = (Member)session.getAttribute("memberInform");
			member = ms.selectMemberInform(member.getUser_id());
			session.setAttribute("memberInform", member);
			session.setMaxInactiveInterval(60*5);
		} // end if
	} // sessionCheck
	
	@RequestMapping("/inquiry_board.do")
	public String inquiryPage(InquiryVO i_vo, Model model, HttpSession session) {
		sessionCheck(session);
		
		InquiryService is = new InquiryService(); 

		if( i_vo.getCurrentPage() == 0 ) {
			i_vo.setCurrentPage(1);
		} // end if
		
		int totalCount = is.totalCount(i_vo); 
		int pageScale = is.pageScale(); 
		int totalPage = is.totalPage(totalCount); 
		
		int startNum = is.startNum(i_vo.getCurrentPage()); 
		int endNum = is.endNum(startNum); 
		i_vo.setStartNum(startNum);
		i_vo.setEndNum(endNum);
		
		List<Inquiry> inquiryList = is.searchInquiryList(i_vo);
		String indexList = is.indexList(i_vo.getCurrentPage(), totalPage, "inquiry_board.do", i_vo.getCondition(), i_vo.getKeyword());

		model.addAttribute("inquiryList", inquiryList);
		model.addAttribute("indexList", indexList);
		model.addAttribute("pageScale", pageScale);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("currentPage", i_vo.getCurrentPage());
		
		return "inquiry/inquiry_board";
	} // inquiryPage
	
	@RequestMapping("/inquiry_detail.do")
	public String inquiryDetail(String num, Model model) {
		
		InquiryService is = new InquiryService();
		InquiryDetail id = is.searchDetailInquiry(num);
		
		model.addAttribute("inquiryDetail", id);
		
		return "inquiry/inquiry_detail";
	} // inquiryDetail 
	
	@RequestMapping("/inquiry_write.do")
	public String inquiryWrite() {
		return "inquiry/inquiry_write";
	} // inquiryPage
	
	@RequestMapping("/insert_inquiry.do")
	public String inquiryInsert(InquiryWriteVO iw_vo, HttpSession session, Model model) {
		InquiryService is = new InquiryService();
		String insertNum = is.insertInquiry(iw_vo);
		InquiryDetail id = is.searchDetailInquiry(insertNum);
		
		model.addAttribute("inquiryDetail", id);			
		
		return "inquiry/inquiry_detail";
	} // inquiryInsert
	
	@RequestMapping(value="/inquiry_edit.do")
	public String inquiryEdit(InquiryUpdateVO iu_vo, Model model) {
		
		InquiryService is = new InquiryService();
		int updateCnt = is.updateInquiry(iu_vo);
		
		InquiryDetail id = is.searchDetailInquiry(iu_vo.getNum());
		
		model.addAttribute("inquiryDetail", id);
		
		return "inquiry/inquiry_detail";
	} // inquiryEdit
	
	@RequestMapping("/inquiry_delete.do")
	public String inquiryDelete(InquiryDeleteVO id_vo) {
		
		InquiryService is = new InquiryService();
		int deleteCnt = is.deleteInquiry(id_vo);
		
		return "redirect:/inquiry_board.do";
	} // inquiryDelete
	
	
} // class
