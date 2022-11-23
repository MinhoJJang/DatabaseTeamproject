package model.post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.common.JDBCUtil;

public class PostDAO {
   Connection conn;
   PreparedStatement pstmt;
   ResultSet rs;
   
   String sql_insert="insert into post(member_id, post_date, post, likes) values (?,NOW(),?,?)"; // 로그인에 성공한 경우에만 C 진행
   String sql_update="update post set likes=likes+1 where post_id=?"; // 좋아요+1
   String sql_delete="delete from post where post_id=?"; // 해당 게시글의 작성자만이 삭제가능
  String sql_selectAll="select * from post where post_id<=? order by post_id desc"; // "더보기": pagination(페이지네이션)
   //String sql_selectAll="select * from post order by desc";
   String sql_insertC="insert into comment(post_id, member_id, comment, comment_date) values(?,?,?,now())  ";
   String sql_deleteC="delete from comment where comment_id=?";
   
   public boolean insertP(PostVO vo) {
	   // String sql_insert="insert into post(member_id, post_date, post, likes) values (?,NOW(),?,?)";
	   conn=JDBCUtil.connect();
	   try {
		pstmt=conn.prepareStatement(sql_insert);
		pstmt.setString(1, vo.getMember_id());
		pstmt.setString(2, vo.getPost());
		pstmt.setInt(3, vo.getLikes());
		pstmt.executeUpdate();
	} catch (SQLException e) {
		System.out.println("PostDAO insertP()에서 문제발생!");
		e.printStackTrace();
		return false;
	} finally {
		JDBCUtil.disconnect(pstmt, conn);
	}
	   return true;
   }
   
   public boolean deleteP(PostVO vo) {
   // String sql_delete="delete from post where bid=?";
	   conn=JDBCUtil.connect();
	   try {
		pstmt=conn.prepareStatement(sql_delete);
		pstmt.setInt(1, vo.getPost_id());
		pstmt.executeUpdate();
	} catch (SQLException e) {
		System.out.println("PostDAO deleteP()에서 문제발생!");
		e.printStackTrace();
		return false;
	} finally {
		JDBCUtil.disconnect(pstmt, conn);
	}
	   return true;
   }
   
   public boolean insertC(CommentVO vo) {
	   // String sql_insertC="insert into comment(post_id, comment_date, member_id, comment) values(?,NOW(),?,?)  "
	      conn=JDBCUtil.connect();
	      try {
	         pstmt=conn.prepareStatement(sql_insertC);
	         pstmt.setInt(1, vo.getPost_id());	       
	         pstmt.setString(2, vo.getMember_id());
	         pstmt.setString(3, vo.getComment());	   
	         pstmt.executeUpdate();
	      } catch (SQLException e) {
	         System.out.println("PostDAO insertC()에서 문제발생!");
	         e.printStackTrace();
	         return false;
	      } finally {
	         JDBCUtil.disconnect(pstmt, conn);
	      }
	      return true;
	   }
   
	public boolean deleteC(CommentVO vo) {
		//    String sql_deleteC="delete from comment where comment_id=?";
      conn=JDBCUtil.connect();
      try {
         pstmt=conn.prepareStatement(sql_deleteC);
         pstmt.setInt(1, vo.getComment_id());
         pstmt.executeUpdate();
      } catch (SQLException e) {
         System.out.println("PostDAO deleteR()에서 문제발생!");
	         e.printStackTrace();
	         return false;
	      } finally {
	         JDBCUtil.disconnect(pstmt, conn);
	      }
	      return true;
	}
   
   public ArrayList<PostSet> selectAll(int mcnt){ // 몇개의 글을 볼수있는지에 대한 정보를 받아옴
      ArrayList<PostSet> datas=new ArrayList<PostSet>();
      conn=JDBCUtil.connect();
      try {
         pstmt=conn.prepareStatement(sql_selectAll);
         pstmt.setInt(1, mcnt);
         rs=pstmt.executeQuery();
         
         while(rs.next()) {
            PostSet ps=new PostSet();
            PostVO p = new PostVO();
            ArrayList<CommentVO> cdatas=new ArrayList<CommentVO>();
                  
            p.setPost_id(rs.getInt("post_id"));
            p.setMember_id(rs.getString("member_id"));           
            p.setPost_date(rs.getTimestamp("post_date"));
            p.setPost(rs.getString("post"));
            p.setLikes(rs.getInt("likes"));
            
            String sql="select * from comment where post_id=?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setInt(1, p.getPost_id()); 
            ResultSet rs2=pstmt.executeQuery();
            while(rs2.next()) {
               CommentVO c =new CommentVO();
               c.setPost_id(rs2.getInt("post_id"));
               c.setComment_id(rs2.getInt("comment_id"));
               c.setMember_id(rs2.getString("member_id"));
               c.setComment(rs2.getString("comment"));
               cdatas.add(c);
            }
            p.setComment_count(cdatas.size());
            // 게시글에 대한 댓글의 개수
            
            ps.setPost(p);
            ps.setCdatas(cdatas);
            datas.add(ps);
         }
      } catch (SQLException e) {
         System.out.println("PostDAO selectAll()에서 문제발생!");
         e.printStackTrace();
      } finally {
         JDBCUtil.disconnect(pstmt, conn);
      }      
      return datas;
   }
   
   public boolean updateP(PostVO vo) {
	  // String sql_update="update post set likes=likes+1 where bid=?";
      conn=JDBCUtil.connect();
      try {
         pstmt=conn.prepareStatement(sql_update);
         pstmt.setInt(1, vo.getPost_id());
         pstmt.executeUpdate();
      } catch (SQLException e) {
         System.out.println("PostDAO update에서 문제발생!");
         e.printStackTrace();
         return false;
      } finally {
         JDBCUtil.disconnect(pstmt, conn);
      }
      return true;
   }
}