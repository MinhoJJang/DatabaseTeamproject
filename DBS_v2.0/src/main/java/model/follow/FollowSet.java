package model.follow;

import java.util.ArrayList;

// 나를 팔로우 하는 사람들
public class FollowSet {
	
	private String member_id;
	private ArrayList<String> fdatas = new ArrayList<String>();
	
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public ArrayList<String> getFdatas() {
		return fdatas;
	}
	public void setFdatas(ArrayList<String> fdatas) {
		this.fdatas = fdatas;
	}
}
