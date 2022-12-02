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
	
	String sql_insert="insert into follow(member_id, following_id) values(?,?)";
	String sql_selectFollowings = "select distinct following_id from follow where member_id=?";
	String sql_selectFollowers = "select distinct member_id from follow where following_id=?";
	String sql_delete = "delete from follow where member_id=? and following_id=?";
	
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
			pstmt.setString(1, vo.getMember_id());
			pstmt.setString(2, vo.getFollowing_id());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}

	public ArrayList<String> selectFollowings(String id) {;
		conn = JDBCUtil.connect();
		ArrayList<String> followingList = new ArrayList<String>();
		try {
			pstmt = conn.prepareStatement(sql_selectFollowings);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();		
			while(rs.next()){
				// 내가 팔로우하는 사람들 목록을 가져와야 한다. 
				// 그 목록은 arrayList 형태일 것이다. 
				followingList.add(rs.getString("following_id"));					
			}							
		} catch (SQLException e) {
			System.out.println("FollowDAO selectFollowing()에서 문제발생!");
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return followingList;
	}

	public ArrayList<String> selectFollowers(String id) {	
		conn = JDBCUtil.connect();
		ArrayList<String> followerList = new ArrayList<String>();
		try {
			pstmt = conn.prepareStatement(sql_selectFollowers);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				// 나를 팔로우하는 사람들 목록을 가져와야 한다. 
				// 그 목록은 arrayList 형태일 것이다. 
				followerList.add(rs.getString("member_id"));					
			}		
		} catch (SQLException e) {
			System.out.println("FollowDAO selectFollowers()에서 문제발생!");
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return followerList;
	}
}