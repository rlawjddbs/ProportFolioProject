package kr.co.dbslab.user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.co.dbslab.user.inquiry.domain.Inquiry;
import kr.co.dbslab.user.inquiry.domain.InquiryDetail;
import kr.co.dbslab.user.inquiry.vo.InquiryDeleteVO;
import kr.co.dbslab.user.inquiry.vo.InquiryUpdateVO;
import kr.co.dbslab.user.inquiry.vo.InquiryVO;
import kr.co.dbslab.user.inquiry.vo.InquiryWriteVO;

public class InquiryDAO {

	private static InquiryDAO i_dao;
	
	private InquiryDAO() {
		
	} // InquiryDAO
	
	public static InquiryDAO getInstance() {
		if ( i_dao == null ) {
			i_dao = new InquiryDAO();
		} // end if
		return i_dao;
	} // getInstance
	
	public List<Inquiry> selectInquiryList(InquiryVO i_vo){
		List<Inquiry> list = null;
		
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		list = ss.selectList("inquiryList", i_vo);
		ss.close();
		
		return list;
	} // selectInquiryList
	
	public int selectTotalCount(InquiryVO i_vo) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		int cnt = ss.selectOne("inquiryTotalCnt", i_vo);
		ss.close();
		return cnt;
	} // selectTotalCount
	
	public String insertInquiry(InquiryWriteVO iw_vo) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		int insertCnt = ss.insert("inquiryInsert", iw_vo);
		String insertNum = iw_vo.getNum();
		if(insertCnt == 1) {
			ss.commit();
		} // end if
		ss.close();
		return insertNum;
	} // insertInquiry
	
	public InquiryDetail selectInquiryDetail(String num) {
		InquiryDetail id = null;
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		id = ss.selectOne("inquiryDetail", num);
		ss.close();
		return id;
	} // selectInquiryDetail
	
	public int updateInquiry(InquiryUpdateVO iu_vo) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		int updateCnt = ss.update("inquiryEdit", iu_vo);
		if(updateCnt == 1) {
			ss.commit();
		} // end if
		ss.close();
		return updateCnt;
	} // updateInquiry
	
	public int deleteInquiry(InquiryDeleteVO id_vo) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		int deleteCnt = ss.delete("inquiryDelete", id_vo);
		
		if(deleteCnt == 1) {
			ss.commit();
		} // end if
		
		ss.close();
		return deleteCnt;
	} // deleteInquiry
	
	public String selectViews(int num) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		String views = ss.selectOne("getViews", num);
		ss.commit();
		return views;
	} // selectViews
	
	public void updateViews(Map<String, Object> map) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		int updateCnt = ss.update("increseViews", map);
		if ( updateCnt == 1 ) {
			ss.commit();
		} // end if
		ss.close();
	} // increaseViews
} // class
