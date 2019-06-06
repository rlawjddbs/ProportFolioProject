package kr.co.dbslab.user.member.vo;

public class ChgPasswdVO {
	private String user_id, currentPasswd, chgPasswd;

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getCurrentPasswd() {
		return currentPasswd;
	}

	public void setCurrentPasswd(String currentPasswd) {
		this.currentPasswd = currentPasswd;
	}

	public String getChgPasswd() {
		return chgPasswd;
	}

	public void setChgPasswd(String chgPasswd) {
		this.chgPasswd = chgPasswd;
	}
	
} // class
