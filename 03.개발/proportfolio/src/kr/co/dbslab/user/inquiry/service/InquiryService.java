package kr.co.dbslab.user.inquiry.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.dbslab.user.dao.InquiryDAO;
import kr.co.dbslab.user.inquiry.domain.Inquiry;
import kr.co.dbslab.user.inquiry.domain.InquiryDetail;
import kr.co.dbslab.user.inquiry.vo.InquiryDeleteVO;
import kr.co.dbslab.user.inquiry.vo.InquiryUpdateVO;
import kr.co.dbslab.user.inquiry.vo.InquiryVO;
import kr.co.dbslab.user.inquiry.vo.InquiryWriteVO;

public class InquiryService {
	
	private InquiryDAO i_dao;
	
	public InquiryService() {
		i_dao = InquiryDAO.getInstance();
	} // InquiryService
	
	
	public int totalCount(InquiryVO i_vo) {
		int totalCount = 0;
		totalCount = i_dao.selectTotalCount(i_vo);
		return totalCount;
	} // totalCount
	
	public int pageScale() {
		int pageScale=10;
		return pageScale;
	} // pageScale

	public int totalPage(int totalCount) {
		int totalPage = totalCount / pageScale();
		if (totalCount % pageScale() != 0) {
			totalPage+=1;
		} // end if
		return totalPage;
	} // totalPage
	
	public int startNum(int currentPage) {
		int startNum = 1;
		startNum = currentPage * pageScale() - pageScale() + 1;
		return startNum;
	} // startNum
	
	public int endNum(int startNum) {
		int endNum = startNum + pageScale() - 1;
		return endNum;
	} // endNum
	
	public List<Inquiry> searchInquiryList(InquiryVO i_vo){
		List<Inquiry> list = null;
		
		list = InquiryDAO.getInstance().selectInquiryList(i_vo);
		
		Inquiry inquiry = null;
		String status="";
		for(int i = 0; i < list.size(); i++) {
			status="답변 대기중";
			inquiry = list.get(i);
			if( "Y".equals(inquiry.getStatus()) ) {
				status = "답변 완료";
			} // end if
			inquiry.setStatus(status);
		} // end for
		
		return list;
	} // selectInquiryList
	
	public String indexList(int currentPage, int totalPage, String list_url, String condition, String keyword) {
		int pageNumber; 
		int startPage; 
		int endPage; 
		int curPage; 
		
		String strList=""; 
		
		pageNumber = 10;
		
		startPage = ((currentPage - 1) / pageNumber) * pageNumber + 1;
		endPage = (((startPage - 1) + pageNumber) / pageNumber) * pageNumber; 
		
		if( totalPage <= endPage ) {
			endPage = totalPage;
		} // end if
		
		if( currentPage > pageNumber ) {
			curPage = startPage - 1;
			strList = strList + "<a href="+list_url+"?currentPage="+curPage+(condition != null?"&condition="+condition:"")+(keyword!=null?"&keyword="+keyword:"")+"><div class=\"indexList\">&lt 이전글</div></a>";
		} else {
			strList = strList + "<div class=\"indexList\">< 이전글</div>";
		} // end else
		
		curPage = startPage;
		
		while (curPage <= endPage) {
			if( curPage == currentPage) {
				strList = strList + "<div class=\"indexList\">"+currentPage+"</div>";
			} else {
				strList = strList +"<a href="+list_url+"?currentPage="+curPage+(condition != null?"&condition="+condition:"")+(keyword!=null?"&keyword="+keyword:"")+"><div class=\"indexList\">"+curPage+"</div></a>";
			} // end else
			
			curPage++;
		} // end while
//		strList = strList +" ... ";
		
		if( totalPage > endPage ) {
			curPage = endPage + 1;
			strList = strList + "<a href="+list_url+"?currentPage="+curPage+(condition != null?"&condition="+condition:"")+(keyword!=null?"&keyword="+keyword:"")+"><div class=\"indexList\">다음글 &gt;</div></a>";
		} else {
			strList = strList + "<div class=\"indexList\"> 다음글 ></div>";
		} // end else
		
		return strList;
	} // indexList
	
	public String insertInquiry(InquiryWriteVO iw_vo) {
		String insertNum = i_dao.insertInquiry(iw_vo);
		return insertNum;
	} // inserInquiry
	
	public InquiryDetail searchDetailInquiry(String num) {
		String viewsPoint = i_dao.selectViews(Integer.parseInt(num));
		int views = Integer.parseInt(viewsPoint);
		views += 1;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("views", String.valueOf(views));
		map.put("num", Integer.parseInt(num));
		i_dao.updateViews(map);
		InquiryDetail id = i_dao.selectInquiryDetail(num);
		return id;
	} // searchDetailInquiry
	
	public int updateInquiry(InquiryUpdateVO iu_vo) {
		
		int updateCnt = i_dao.updateInquiry(iu_vo);
		
		return updateCnt;
	} // updateInquiry
	
	public int deleteInquiry(InquiryDeleteVO id_vo) {
		
		int deleteCnt = i_dao.deleteInquiry(id_vo);
		
		return deleteCnt;
	} // deleteInquiry
	
} // class
