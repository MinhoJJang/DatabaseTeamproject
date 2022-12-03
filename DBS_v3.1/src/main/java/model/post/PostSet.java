package model.post;

import java.util.ArrayList;

public class PostSet {

	private PostVO post;
	private ArrayList<CommentVO> cdatas = new ArrayList<CommentVO>();
  
	public PostVO getPost() {
		return post;
	}
	public void setPost(PostVO post) {
		this.post = post;
	}
	public ArrayList<CommentVO> getCdatas() {
		return cdatas;
	}
	public void setCdatas(ArrayList<CommentVO> cdatas) {
		this.cdatas = cdatas;
	}

  

}