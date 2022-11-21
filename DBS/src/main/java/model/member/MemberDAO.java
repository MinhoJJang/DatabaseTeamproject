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
	String sql_update="update member set member_name=?, member_email=?"; // 회원정보 수정 
	
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
		
			mv.setIsActivated(rs.getBoolean("isActivated"));
			mv.setIsAdmin(rs.getBoolean("isAdmin"));
			mv.setMember_email(rs.getString("member_email"));
			mv.setMember_id(rs.getString("member_id"));
			mv.setMember_name(rs.getString("member_name"));
			mv.setMember_pw(rs.getString("member_pw"));
			
		} catch (SQLException e) {
			System.out.println("MemberDAO selectM()에서 문제발생!");
			e.printStackTrace();
		
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return mv;
	}
	
	public boolean updateM(MemberVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_update);
			pstmt.setString(1, vo.getMember_name());
			pstmt.setString(2, vo.getMember_email());
			pstmt.executeUpdate();
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