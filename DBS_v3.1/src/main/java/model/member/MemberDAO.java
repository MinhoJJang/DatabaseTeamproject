package model.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.common.JDBCUtil;

public class MemberDAO {
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	String sql_insert="insert into member(member_id, member_pw, member_name, member_email) values(?,?,?,?)"; // 회원가입 
	String sql_selectOne="select * from member where member_id=?"; // 로그인 및 마이페이지 불러오기
	String sql_selectName="select member_name from member where member_id = ?"; // 로그인 이후 자신 닉네임 불러오기
	String sql_update="update member set member_pw=?, member_name=?, member_email=? where member_id=?"; // 회원정보 수정 
	String sql_updatePost = "update post set member_name=? where member_name=?"; // update 시 post와 comment의 작성자 이름도 일괄 변경
	String sql_updateComment = "update comment set member_name=? where member_name=?"; 
	
	public boolean insertM(MemberVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_insert);
			pstmt.setString(1, vo.getMember_id());
			pstmt.setString(2, vo.getMember_pw());
			pstmt.setString(3, vo.getMember_name());
			pstmt.setString(4, vo.getMember_email());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("MemberDAO insert()에서 문제발생!");
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	
	public String selectName(MemberVO vo) {
		conn=JDBCUtil.connect();
		String name = null;
		try {
			pstmt=conn.prepareStatement(sql_selectName);
			pstmt.setString(1, vo.getMember_id());
			rs=pstmt.executeQuery();
			if(rs.next()){
				name = rs.getString("member_name");
			}
		} catch (SQLException e) {
			System.out.println("MemberDAO selectName()에서 문제발생!");
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return name;
	}
	
	public boolean selectOne(MemberVO vo) {
		// 로그인 성공여부를 반환하는 메서드
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_selectOne);
			pstmt.setString(1, vo.getMember_id());
			rs=pstmt.executeQuery();
			if(rs.next()){
				System.out.println("해당하는 id 존재");
				if(rs.getString("member_pw").equals(vo.getMember_pw())) {
					System.out.println("pw 일치");
					return true;
				}
			}
		} catch (SQLException e) {
			System.out.println("MemberDAO selectOne()에서 문제발생!");
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return false;
	}
	
	// 마이페이지 불러오기 
	public MemberVO selectM(MemberVO vo) {
		conn=JDBCUtil.connect();
		MemberVO mv = new MemberVO();
		try {
			pstmt=conn.prepareStatement(sql_selectOne);
			pstmt.setString(1, vo.getMember_id());
			rs=pstmt.executeQuery();
		
			if(rs.next()) {
				//mv.setIsActivated(rs.getBoolean("isActivated"));
				//	mv.setIsAdmin(rs.getBoolean("isAdmin"));
					mv.setMember_email(rs.getString("member_email"));
					mv.setMember_id(rs.getString("member_id"));
					mv.setMember_name(rs.getString("member_name"));
					mv.setMember_pw(rs.getString("member_pw"));
			}		
		} catch (SQLException e) {
			System.out.println("MemberDAO selectM()에서 문제발생!");
			e.printStackTrace();
		
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return mv;
	}
	
	public boolean updateM(MemberVO vo, String origin_member_name) {
		conn=JDBCUtil.connect();
		System.out.println("MemberDAO까지 도착 성공");

		try {		
			pstmt=conn.prepareStatement(sql_update);
			pstmt.setString(1, vo.getMember_pw());
			pstmt.setString(2, vo.getMember_name());
			pstmt.setString(3, vo.getMember_email());
			//pstmt.setBoolean(4, vo.getIsActivated());
			pstmt.setString(4, vo.getMember_id());
			pstmt.executeUpdate();
			
			pstmt=conn.prepareStatement(sql_updatePost);
			pstmt.setString(1, vo.getMember_name());
			pstmt.setString(2, origin_member_name);
			pstmt.executeUpdate();
			
			pstmt=conn.prepareStatement(sql_updateComment);
			pstmt.setString(1, vo.getMember_name());
			pstmt.setString(2, origin_member_name);
			pstmt.executeUpdate();
			
			System.out.println("MemberDAO까지 완료");
		} catch (SQLException e) {
			System.out.println("MemberDAO update()에서 문제발생!");
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
}