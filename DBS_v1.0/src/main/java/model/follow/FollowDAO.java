package model.follow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.common.JDBCUtil;
import model.post.PostSet;

// FOLLOW: 팔로잉: Insert 보여주기: select 팔로우취소: delete

public class FollowDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	String sql_insert="insert into(member_id, following_id) follow values(?,?)";
	String sql_selectFollowings = "select * from follow where member_id=?";
	String sql_selectFollowers = "select * from follow where following_id=?";
	String sql_delete = "delete * from follow where follow_num=?";
	
	public boolean insertF(FollowVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_insert);
			pstmt.setString(1, vo.getMember_id());
			pstmt.setString(2, vo.getFollowing_id());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("FollowDAO insert()에서 문제발생!");
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	
	public boolean deleteF(FollowVO vo) {
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_delete);
			pstmt.setInt(1, vo.getFollow_num());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}

	public FollowSet selectFollowings(FollowVO vo) {
		FollowSet fs = new FollowSet();
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_selectFollowings);
			pstmt.setString(1, vo.getMember_id());
			rs = pstmt.executeQuery();
			ArrayList<String> fdatas = new ArrayList<String>();
			
			while(rs.next()){
				// 내가 팔로우하는 사람들 목록을 가져와야 한다. 
				// 그 목록은 arrayList 형태일 것이다. 
				fdatas.add(rs.getString("following_id"));					
			}
			
			fs.setMember_id(rs.getString("member_id"));
			fs.setFdatas(fdatas);
			
		} catch (SQLException e) {
			System.out.println("FollowDAO selectFollowing()에서 문제발생!");
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return fs;
	}

	public FollowSet selectFollowers(FollowVO vo) {
		FollowSet fs = new FollowSet();
		conn = JDBCUtil.connect();
		try {
			pstmt = conn.prepareStatement(sql_selectFollowers);
			pstmt.setString(1, vo.getFollowing_id());
			rs = pstmt.executeQuery();
			ArrayList<String> fdatas = new ArrayList<String>();
			while(rs.next()){
				// 나를 팔로우하는 사람들 목록을 가져와야 한다. 
				// 그 목록은 arrayList 형태일 것이다. 
				fdatas.add(rs.getString("member_id"));					
			}
			fs.setMember_id(rs.getString("following_id"));
			fs.setFdatas(fdatas);
			
		} catch (SQLException e) {
			System.out.println("FollowDAO selectFollowers()에서 문제발생!");
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return fs;
	}
}