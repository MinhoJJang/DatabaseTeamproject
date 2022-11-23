package model.member;

public class MemberVO {
	
	/*
	 *  member_id varchar(20) not null,
		member_email varchar(30) not null,
		member_name varchar(20) not null,
		member_pw varchar(20) not null,
		isAdmin boolean default false,
		isActivated boolean default true,
	 */
	
	private String member_id;
	private String member_pw;
	private String member_name;
	private String member_email;
	private Boolean isAdmin;
	private Boolean isActivated;
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public Boolean getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(Boolean isAdmin) {
		this.isAdmin = isAdmin;
	}
	public Boolean getIsActivated() {
		return isActivated;
	}
	public void setIsActivated(Boolean isActivated) {
		this.isActivated = isActivated;
	}
	
}