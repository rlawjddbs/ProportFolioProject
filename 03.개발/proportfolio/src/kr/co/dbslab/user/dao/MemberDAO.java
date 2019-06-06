package kr.co.dbslab.user.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.co.dbslab.user.member.domain.Member;
import kr.co.dbslab.user.member.vo.ChgPasswdVO;
import kr.co.dbslab.user.member.vo.FindMemberIdVO;
import kr.co.dbslab.user.member.vo.FindMemberPasswdVO;
import kr.co.dbslab.user.member.vo.LoginVO;
import kr.co.dbslab.user.member.vo.MemberVO;

public class MemberDAO {

	private static MemberDAO m_dao;
	
	private MemberDAO() {
	} // MemerDAO
	
	public static MemberDAO getInstance() {
		if( m_dao == null) {
			m_dao = new MemberDAO();
		} // end if
		return m_dao;
	} // getInstance
	
	public boolean selectMemberId(String user_id) {
		boolean flag = false;
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		String userId = ss.selectOne("selectMemberId", user_id);
		ss.close();
		if( userId == null ) {
			flag = true;
		} // end if
		
		return flag;
	} // selectMemberId
	
	public boolean selectMemberEmail(String email) {
		boolean flag = false;
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		String userEmail = ss.selectOne("selectMemberEmail", email);
		ss.close();
		if( userEmail == null ) {
			flag = true;
		} // end if
		
		return flag;
	} // selectMemberId
	
	
	public String loginMember(LoginVO l_vo) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		String user_id = ss.selectOne("selectMemberForLogin", l_vo);
		ss.close();
		return user_id;
	} // loginMember
	
	public Member selectMemberInform(String user_id) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		Member member = ss.selectOne("selectMemberInform", user_id);
		ss.close();
		return member;
	} // selectMemberInform
	
	public int insertMember(MemberVO m_vo) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		int insertCnt =  ss.insert("insertMember", m_vo);
		
		if( insertCnt == 1 ) {
			ss.commit();
		} // end if
		
		ss.close();
		return insertCnt;
	} // insertMember
	
	public String findMemberId(FindMemberIdVO fmi_vo) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		String user_id = ss.selectOne("findMemberId", fmi_vo);
		
		ss.close();
		return user_id;
	} // findMemberId
	
	public String findMemberPassword(FindMemberPasswdVO fmp_vo) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		String user_id = ss.selectOne("findMemberPasswd", fmp_vo);
		
		ss.close();
		return user_id;
	} // findMemberPassword
	
	public boolean updateMemberProfilePic(Map<String, String> map) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		boolean flag = false;
		int updateCnt = ss.update("updateProfilePic", map);
		if ( updateCnt == 1 ) {
			flag = true;
			ss.commit();
		} // end if
		ss.close();
		return flag;
	} // updateMemberProfilePic
	
	public boolean updateMemberPassword(ChgPasswdVO cp_vo) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		boolean flag = false;
		int updateCnt = ss.update("updateMemberPasswd", cp_vo);
		if( updateCnt == 1) {
			flag = true;
			ss.commit();
		} // end if
		ss.close();
		return flag;
	} // updateMemberPassword

	public boolean updateMemberTempPassword(Map<String, String> map) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		boolean flag = false;
		int updateCnt = ss.update("updateMemberTempPasswd", map);
		if( updateCnt == 1) {
			flag = true;
			ss.commit();
		} // end if
		return flag;
	} // updateMemberPassword
	
	public boolean updateMemberName(Map<String, Object> map) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		boolean flag = false;
		int updateCnt = ss.update("updateMemberName", map);
		if ( updateCnt == 1 ) {
			ss.commit();
			flag = true;
		} // end if
		ss.close();
		return flag;
	} // updateMemberName
	
	public boolean updateMemberEmail(Map<String, Object> map) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		boolean flag = false;
		int updateCnt = ss.update("updateMemberEmail", map);
		if ( updateCnt == 1 ) {
			ss.commit();
			flag = true;
		} // end if
		ss.close();
		return flag;
	} // updateMemberName
	
	public boolean updateMemberBirth(Map<String, Object> map) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		boolean flag = false;
		int updateCnt = ss.update("updateMemberBirth", map);
		if ( updateCnt == 1) {
			flag = true;
			ss.commit();
		} // end if
		ss.close();
		return flag;
	} // updateMemberName
	
	public boolean updateMemberPhone(Map<String, Object> map) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		boolean flag = false;
		int updateCnt = ss.update("updateMemberPhone", map);
		if ( updateCnt == 1) {
			ss.commit();
			flag = true;
		} // end if
		ss.close();
		return flag;
	} // updateMemberName
	
	public boolean updateMemberIsdropped(Map<String, Object> map) {
		SqlSession ss = MyBatisDAO.getInstance().getSessionFactory().openSession();
		boolean flag = false;
		int updateCnt = ss.update("updateMemberIsdropped", map);
		if ( updateCnt == 1) {
			flag = true;
			ss.commit();
		} // end if
		ss.close();
		return flag;
	} // updateMemberIsdropped
	
} // class
