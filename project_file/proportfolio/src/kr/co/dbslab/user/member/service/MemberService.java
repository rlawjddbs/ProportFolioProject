package kr.co.dbslab.user.member.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import kr.co.dbslab.user.dao.MemberDAO;
import kr.co.dbslab.user.member.domain.Member;
import kr.co.dbslab.user.member.vo.ChgPasswdVO;
import kr.co.dbslab.user.member.vo.FindMemberIdVO;
import kr.co.dbslab.user.member.vo.FindMemberPasswdVO;
import kr.co.dbslab.user.member.vo.LoginVO;
import kr.co.dbslab.user.member.vo.MemberVO;

public class MemberService {

	private MemberDAO m_dao;

	public MemberService() {
		m_dao = MemberDAO.getInstance();
	} // MemberService

	public Map<String, Boolean> selectMemberId(String user_id) {
		boolean idDupResult = m_dao.selectMemberId(user_id);
		Map<String, Boolean> resultMap = new HashMap<String, Boolean>();
		resultMap.put("idDupResult", idDupResult);

		return resultMap;
	} // selectMemberId
	
	public Map<String, Boolean> selectMemberEmail(String email) {
		boolean emailDupResult = m_dao.selectMemberEmail(email);
		Map<String, Boolean> resultMap = new HashMap<String, Boolean>();
		resultMap.put("emailDupResult", emailDupResult);
		
		return resultMap;
	} // selectMemberId

	public Map<Object, Object> loginMember(LoginVO l_vo) {
		String user_id = m_dao.loginMember(l_vo);
		Map<Object, Object> map = new HashMap<Object, Object>();
		if (user_id != null && !"".equals(user_id)) {
			map.put("id", user_id);
			map.put("loginResult", true);
			map.put("url", "index");
		} else {
			map.put("id", "");
			map.put("loginResult", false);
			map.put("url", "/login/login");
		} // end if

		return map;
	} // loginMember

	public Member selectMemberInform(String user_id) {
		Member member = m_dao.selectMemberInform(user_id);
		return member;
	} // selectMemberInform

	public long calcDday(String inputdate) throws ParseException {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date inputDateFormat = sdf.parse(inputdate);
		Date todate = sdf.parse(sdf.format(today));

		long diff = todate.getTime() - inputDateFormat.getTime();
		long diffDays = diff / (24 * 60 * 60 * 1000);

		return diffDays;
	} // calcDday

	public int insertMember(MemberVO m_vo) {
		int insertCnt = m_dao.insertMember(m_vo);

		return insertCnt;
	} // insertMember

	public Map<String, Object> findMemberId(FindMemberIdVO fmi_vo) {
		String user_id = m_dao.findMemberId(fmi_vo);
		Map<String, Object> resultMap = new HashMap<String, Object>();

		if (user_id != null) {
			resultMap.put("searchResult", true);
			resultMap.put("user_id", user_id);
		} else {
			resultMap.put("searchResult", false);
		} // end else

		return resultMap;
	} // findMemberId

	public Map<String, Object> findMemberPassword(FindMemberPasswdVO fmp_vo) {
		String user_id = m_dao.findMemberPassword(fmp_vo);
		Map<String, String> paramMap = new HashMap<String, String>();
		Map<String, Object> resultMap = new HashMap<String, Object>();

		if (user_id != null) {
			char[] tempPass = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q',
					'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '!',
					'@' };
			StringBuffer tempPassSb = new StringBuffer();
			for(int i = 0; i < 6; i++) {
				int ranNum = new Random().nextInt(tempPass.length);
				tempPassSb.append(tempPass[ranNum]);
			} // end for

			paramMap.put("user_id", user_id);
			paramMap.put("password", tempPassSb.toString());
			
			boolean updateFlag = m_dao.updateMemberTempPassword(paramMap);
			
			if( updateFlag ) {
				resultMap.put("searchResult", true);
				resultMap.put("user_id", user_id);
				resultMap.put("password", tempPassSb.toString());
			} // end if

		} else {
			resultMap.put("searchResult", false);
		} // end else

		return resultMap;
	} // findMemberPassword

	public Map<String, Boolean> updateMemberProfilePic(Map<String, String> map) {
		Map<String, Boolean> resultMap = new HashMap<String, Boolean>();
		boolean updateResult = m_dao.updateMemberProfilePic(map);

		if (updateResult) {
			resultMap.put("updateResult", true);
		} else {
			resultMap.put("updateResult", false);
		} // end else
		return resultMap;
	}

	public Map<String, Boolean> updateMemberPassword(ChgPasswdVO cp_vo) {
		Map<String, Boolean> resultMap = new HashMap<String, Boolean>();
		boolean updateResult = m_dao.updateMemberPassword(cp_vo);

		if (updateResult) {
			resultMap.put("updateResult", true);
		} else {
			resultMap.put("updateResult", false);
		} // end else
		return resultMap;
	} // updateMemberPassword

	public Map<String, Object> updateMemberName(Map<String, Object> map) {
		boolean updatedFlag = m_dao.updateMemberName(map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (updatedFlag) {
			resultMap.put("updateResult", true);
		} else {
			resultMap.put("updateResult", false);
		} // end else
		return resultMap;
	} // updateMemberName
	
	public Map<String, Object> updateMemberEmail(Map<String, Object> map) {
		boolean updatedFlag = m_dao.updateMemberEmail(map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (updatedFlag) {
			resultMap.put("updateResult", true);
		} else {
			resultMap.put("updateResult", false);
		} // end else
		return resultMap;
	} // updateMemberName

	public Map<String, Object> updateMemberBirth(Map<String, Object> map) {
		boolean updatedFlag = m_dao.updateMemberBirth(map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (updatedFlag) {
			resultMap.put("updateResult", true);
		} else {
			resultMap.put("updateResult", false);
		} // end else
		return resultMap;
	} // updateMemberName

	public Map<String, Object> updateMemberPhone(Map<String, Object> map) {
		boolean updatedFlag = m_dao.updateMemberPhone(map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (updatedFlag) {
			resultMap.put("updateResult", true);
		} else {
			resultMap.put("updateResult", false);
		} // end else
		return resultMap;
	} // updateMemberName

	public Map<String, Object> updateMemberIsdropped(Map<String, Object> map) {
		boolean updatedFlag = m_dao.updateMemberIsdropped(map);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (updatedFlag) {
			resultMap.put("updateResult", true);
		} else {
			resultMap.put("updateResult", false);
		} // end else

		return resultMap;
	} // updateMemberIsdropped

} // class
