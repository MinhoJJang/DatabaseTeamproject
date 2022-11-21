package model.post;

import java.sql.Timestamp;

public class CommentVO {
	
	/*
	    create table comment(
		comment_id int primary key auto_increment, 
		post_id int,
		comment_date dateTime,
		member_id varchar(20),
		comment varchar(500),
		foreign key (post_id) references post (post_id),
		foreign key (member_id) references member(member_id)
		);
	 */	
	private int comment_id;
	private int post_id;
	private Timestamp comment_date;
	private String member_id;
	private String comment;
	
	public int getComment_id() {
		return comment_id;
	}

	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}

	public int getPost_id() {
		return post_id;
	}

	public void setPost_id(int post_id) {
		this.post_id = post_id;
	}

	public Timestamp getComment_date() {
		return comment_date;
	}


	public void setComment_date(Timestamp comment_date) {
		this.comment_date = comment_date;
	}


	public String getMember_id() {
		return member_id;
	}


	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}


	public String getComment() {
		return comment;
	}


	public void setComment(String comment) {
		this.comment = comment;
	}


	@Override
	public String toString() {
		return "CommentVO [comment_id=" + comment_id + ", post_id=" + post_id + ", comment_date=" + comment_date
				+ ", member_id=" + member_id + ", comment=" + comment + "]";
	}	
}
