package model.follow;

public class FollowVO {
    /*
     * follow_num int primary key auto_increment,
     * member_id varchar(20),
     * following_id varchar(20),
     */
    private int follow_num;
    private String member_id;
    private String following_id;
    
	public int getFollow_num() {
		return follow_num;
	}
	public void setFollow_num(int follow_num) {
		this.follow_num = follow_num;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getFollowing_id() {
		return following_id;
	}
	public void setFollowing_id(String following_id) {
		this.following_id = following_id;
	}
   
}