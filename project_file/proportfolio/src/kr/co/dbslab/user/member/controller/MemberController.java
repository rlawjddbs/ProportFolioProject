package kr.co.dbslab.user.member.controller;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.dbslab.user.member.domain.Member;
import kr.co.dbslab.user.member.service.MemberService;
import kr.co.dbslab.user.member.vo.ChgPasswdVO;
import kr.co.dbslab.user.member.vo.FindMemberIdVO;
import kr.co.dbslab.user.member.vo.FindMemberPasswdVO;
import kr.co.dbslab.user.member.vo.LoginVO;
import kr.co.dbslab.user.member.vo.MemberVO;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class MemberController {
	
	private MemberService ms;
	
	private void sessionCheck(HttpSession session) {
		if( session.getAttribute("memberInform") != null) {
			ms = new MemberService();
			Member member = (Member)session.getAttribute("memberInform");
			member = ms.selectMemberInform(member.getUser_id());
			session.setAttribute("memberInform", member);
			session.setMaxInactiveInterval(60*5);
		} else {
			session.invalidate();
		}
	} // sessionCheck
	
	@RequestMapping(value="/index.do", method=GET)
	public String indexPage(HttpSession session) {
		sessionCheck(session);
		return "index";
	} // indexPage
	
	@RequestMapping(value="/login.do", method=GET)
	public String loginPage() {
		return "/login/login";
	} // loginPage
	
	@RequestMapping(value="/login_success.do", method=POST)
	public String loginProcess(LoginVO l_vo, HttpSession session, Model model) {
		
		ms = new MemberService();
		Map<Object, Object> map = ms.loginMember(l_vo);
		
		if((Boolean)map.get("loginResult")) {
			Member member = ms.selectMemberInform((String)map.get("id"));
			session.setAttribute("memberInform", member);
			session.setMaxInactiveInterval(60*5);
		} else {
			model.addAttribute("loginResult", "입력한 아이디와 비밀번호가 일치하지 않습니다.");
		} // end else
		
		return (String)map.get("url");
	} // loginProcess
	
	@RequestMapping(value="/logout.do", method=GET)
	public String logoutProcess(HttpSession session) {
		session.invalidate();
		
		return "index";
	} // logoutProcess
	
	@RequestMapping(value="/find_member_id.do", method=GET)
	public String findMemberIdPage() {
		return "/member/find_member_id";
	} // findMemberIdPage
	
	@ResponseBody
	@RequestMapping(value="/find_member_id_process.do", method=POST)
	public String findMemberIdProcess(FindMemberIdVO fmi_vo) {
		ms = new MemberService();
		Map<String, Object> resultMap = ms.findMemberId(fmi_vo);
		JSONObject json = new JSONObject(resultMap);
		
		return json.toJSONString();
	} // findMemberIdProcess
	
	@RequestMapping(value="/find_member_passwd.do", method=GET)
	public String findMemberPasswdPage() {
		return "/member/find_member_passwd";
	} // findMemberPasswdPage
	
	@ResponseBody
	@RequestMapping(value="/find_member_passwd_process.do", method=POST)
	public String findMemberPasswdProcess(FindMemberPasswdVO fmp_vo) {
		ms = new MemberService();
		Map<String, Object> resultMap = ms.findMemberPassword(fmp_vo);
		if ( (Boolean)resultMap.get("searchResult") ) {
			final String user = ""; // 업로드를 위한 삭제
			final String password = ""; // 업로드를 위한 삭제
			
			Properties prop = new Properties();
			prop.put("mail.smtp.host", ""); // 업로드를 위한 삭제
			prop.put("mail.smtp.port", null); // 업로드를 위한 삭제
			prop.put("mail.smtp.auth", "true");
			prop.put("mail.smtp.ssl.enable", "true");
			prop.put("mail.smtp.ssl.trust", ""); // 업로드를 위한 삭제
			
			Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(user, password);
				}
			}); // session anonymous method
			
			try {
				MimeMessage message = new MimeMessage(session);
				message.setFrom(new InternetAddress(user));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(fmp_vo.getEmail()));
				message.setSubject("임시 비밀번호 발급 안내 입니다.");
				message.setContent("<h1>임시비밀번호는"+(String)resultMap.get("password")+"입니다.</h1>", "text/html; charset=utf-8");
				Transport.send(message);
			} catch (AddressException e) {
				e.printStackTrace();
			} catch (MessagingException e) {
				e.printStackTrace();
			} // end catch
		} // end if
		
		JSONObject json = new JSONObject(resultMap);
		
		return json.toJSONString();
	} // findMemberPasswdProcess
	
	@ResponseBody
	@RequestMapping(value="/chk_passwd_process.do", method=POST)
	public String ajaxLoginProcess(LoginVO l_vo) {
		
		ms = new MemberService();
		Map<Object, Object> map = ms.loginMember(l_vo);
		
		JSONObject json = new JSONObject(map);
		
		return json.toJSONString();
	} // ajaxLoginProcess
	
	@RequestMapping(value="/mypage.do", method=GET)
	public String mypage(HttpSession session, Model model) {
		
		if( session.getAttribute("memberInform") == null ) {
			return "/login/login";
		} // end if
		
		return "/member/mypage";
	} // mypage
	
	
	@RequestMapping(value="/chk_passwd_page.do", method=GET)
	public String checkPasswordPage() {
		return "/member/check_pass";
	} // checkPasswordPage
	
	@RequestMapping(value="/my_info.do", method=POST)
	public String myInfoPage(HttpSession session, Model model) {
		sessionCheck(session);
		
		long diffDays;
		try {
			diffDays = ms.calcDday(((Member)session.getAttribute("memberInform")).getInputdate());
			model.addAttribute("dDay", diffDays);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return "/member/my_info";
	} // myInfoPage
	
	@RequestMapping(value="/join_member.do", method=GET)
	public String joinMemberPage() {
		return "/member/join_member";
	} // joinMemberPage
	
	@ResponseBody
	@RequestMapping(value="/id_dup_check.do", method=POST)
	public String idDupCheckProcess(HttpServletRequest request) {
		String user_id = request.getParameter("user_id");
		
		ms = new MemberService();
		Map<String, Boolean> map = ms.selectMemberId(user_id);
		
		JSONObject json = new JSONObject(map);
		
		return json.toJSONString();
	} // idDupCheckProcess
	
	@ResponseBody
	@RequestMapping(value="/email_dup_check.do", method=POST)
	public String emailDupCheckProcess(HttpServletRequest request) {
		String email = request.getParameter("email");
		
		ms = new MemberService();
		Map<String, Boolean> map = ms.selectMemberEmail(email);
		
		JSONObject json = new JSONObject(map);
		
		return json.toJSONString();
	} // idDupCheckProcess
	
	@RequestMapping(value="/join_success.do", method=POST)
	public String joinSuccessPage(MemberVO m_vo, Model model) {
		ms = new MemberService();
		int insertCnt = ms.insertMember(m_vo);
		
		if( insertCnt == 1 ) {
			model.addAttribute("joinSuccess", true);
			model.addAttribute("name", m_vo.getName());
		} // end if
		
		return "index";
	} // joinSuccessPage
	
	@RequestMapping(value="/change_password.do", method=GET)
	public String changePasswordPage() {
		return "/member/chg_passwd";
	} // changePasswordPage
	
	@ResponseBody
	@RequestMapping(value="/chg_passwd_process.do", method=POST)
	public String changePasswordProcess(ChgPasswdVO cp_vo) {
		ms = new MemberService();
		
		Map<String, Boolean> map = ms.updateMemberPassword(cp_vo);
		JSONObject json = new JSONObject(map);
		
		return json.toJSONString();
	} // changePasswordProcess
	
	@ResponseBody
	@RequestMapping(value="/chg_name_process.do", method=POST)
	public String changeNameProcess(HttpServletRequest request, HttpSession session) {
		String name = request.getParameter("name");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user_id", ((Member)session.getAttribute("memberInform")).getUser_id());
		paramMap.put("name", name);
		
		ms = new MemberService();
		Map<String, Object> resultMap = ms.updateMemberName(paramMap);
		JSONObject json = new JSONObject(resultMap);
		
		return json.toJSONString();
	} // changeNameProcess
	
	@ResponseBody
	@RequestMapping(value="/chg_email_process.do", method=POST)
	public String changeEmailProcess(HttpServletRequest request, HttpSession session) {
		String email = request.getParameter("email");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user_id", ((Member)session.getAttribute("memberInform")).getUser_id());
		paramMap.put("email", email);
		
		ms = new MemberService();
		Map<String, Object> resultMap = ms.updateMemberEmail(paramMap);
		JSONObject json = new JSONObject(resultMap);
		
		return json.toJSONString();
	} // changeNameProcess
	
	@ResponseBody
	@RequestMapping(value="/chg_birth_process.do", method=POST)
	public String changeBirthProcess(HttpServletRequest request, HttpSession session) {
		String birth = request.getParameter("birth");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user_id", ((Member)session.getAttribute("memberInform")).getUser_id());
		paramMap.put("birth", birth);
	
		ms = new MemberService();
		Map<String, Object> resultMap = ms.updateMemberBirth(paramMap);
		
		JSONObject json = new JSONObject(resultMap);
		
		return json.toJSONString();
	} // changeNameProcess
	
	@ResponseBody
	@RequestMapping(value="/chg_phone_process.do", method=POST)
	public String changePhoneProcess(HttpServletRequest request, HttpSession session) {
		String phone = request.getParameter("phone");
		System.out.println(phone);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user_id", ((Member)session.getAttribute("memberInform")).getUser_id());
		paramMap.put("phone", phone);
		
		ms = new MemberService();
		Map<String, Object> resultMap = ms.updateMemberPhone(paramMap);
		JSONObject json = new JSONObject(resultMap);
		
		return json.toJSONString();
	} // changeNameProcess
	
	@RequestMapping(value="/leave_member.do", method=GET)
	public String memberLeavePage() {
		return "/member/leave_member";
	} // memberLeavePage
	
	@ResponseBody
	@RequestMapping(value="/leave_member_process.do", method=POST)
	public String memberLeaveProcess(HttpServletRequest request) {
		String userId = request.getParameter("user_id");
		String password = request.getParameter("password");
		System.out.println(userId + " / " + password);
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user_id", userId);
		paramMap.put("password", password);
		
		ms = new MemberService();
		Map<String, Object> resultMap = ms.updateMemberIsdropped(paramMap);
		JSONObject json = new JSONObject(resultMap);
		
		return json.toJSONString();
	} // memberLeaveProcess
	
	@RequestMapping(value="/goodbye.do", method=GET)
	public String goodbyePage(HttpSession session) {
		session.invalidate();
		return "/member/goodbye";
	} // goodbyePage
	
	@ResponseBody
	@RequestMapping(value = "/mr_upload_process.do", method = POST)
	public String mrUploadProcess(HttpServletRequest request, HttpSession session) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		ms = new MemberService();
		Boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		String userId = ((Member)session.getAttribute("memberInform")).getUser_id();
		
		if( isMultipart ) {
			int maxSize = 1024 * 1024 * 10;
			
			File repository = new File("/Users/zeongyun/dev/workspace/proportfolio/WebContent/common/profile_img/"+userId+"/");
			
			if(!repository.exists()) {
				repository.mkdirs();
			} // end if
			
			try {
				MultipartRequest mr = new MultipartRequest(request, repository.getAbsolutePath(), maxSize, "UTF-8", new DefaultFileRenamePolicy());
				
				String fileName = mr.getFilesystemName("upfile");
	 			String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
	 			int i = fileName.lastIndexOf('.');
	 			String realFileName = now+fileName.substring(i, fileName.length());
	 			
	 			File oldFile = new File(repository.getAbsolutePath()+"/"+fileName);
	 			File newFile = new File(repository.getAbsolutePath()+"/"+realFileName);
	 			
	 			oldFile.renameTo(newFile);
	 			
	 			String existingImg = ((Member)session.getAttribute("memberInform")).getProfile_pic();
	 			File existingImgFile = new File("/Users/zeongyun/dev/workspace/proportfolio/WebContent/common/profile_img/"+existingImg);
	 			if( existingImgFile.isFile() ) {
	 				existingImgFile.delete();
	 			} // end if
	 			
				Map<String, String> paramMap = new HashMap<String, String>();
				if( session.getAttribute("memberInform") != null ) {
					paramMap.put("user_id", ((Member)session.getAttribute("memberInform")).getUser_id());
					paramMap.put("profile_pic", userId+"/"+realFileName);
				} // end if
				Map<String, Boolean> resultMap = ms.updateMemberProfilePic(paramMap);
				JSONObject json = new JSONObject(resultMap);
				
				return json.toJSONString();
			} catch (IOException e) {
				e.printStackTrace();
			} // end catch
		} else {
			
		} // end else
		return "asdf";
	} // mrUploadProcess
	
} // class
