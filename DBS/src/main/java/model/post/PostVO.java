package model.post;

import java.sql.Timestamp;

public class PostVO {

	/*
	 	create table post(
		post_id int primary key auto_increment,
		member_id varchar(20),
		post_date dateTime,
		post varchar(1000),
		likes int default 0,
		foreign key (member_id) references member (member_id)
		);
	 */
	
	private int post_id;
	private String member_id;
	private Timestamp post_date; 
	private String post;
	private int likes;
	private int comment_count;
	
	public int getComment_count() {
		return comment_count;
	}
	public void setComment_count(int comment_count) {
		this.comment_count = comment_count;
	}
	public int getPost_id() {
		return post_id;
	}
	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public Timestamp getPost_date() {
		return post_date;
	}
	public void setPost_date(Timestamp post_date) {
		this.post_date = post_date;
	}
	public String getPost() {
		return post;
	}
	public void setPost(String post) {
		this.post = post;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	@Override
	public String toString() {
		return "PostVO [post_id=" + post_id + ", member_id=" + member_id + ", post_date=" + post_date + ", post=" + post
				+ ", likes=" + likes + ", comment_count=" + comment_count + "]";
	}
	
	
	
	
}
