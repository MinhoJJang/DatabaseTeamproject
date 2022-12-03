<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.post.*,  model.follow.*, model.member.*,java.util.*"%>
   
<jsp:useBean id="pdao" class="model.post.PostDAO"/>
<jsp:useBean id="mdao" class="model.member.MemberDAO"/>
<jsp:useBean id="fdao" class="model.follow.FollowDAO"/>

<jsp:useBean id="pvo" class="model.post.PostVO"/>
<jsp:setProperty property="*" name="pvo"/>

<jsp:useBean id="cvo" class="model.post.CommentVO"/>
<jsp:setProperty property="*" name="cvo"/>

<jsp:useBean id="mvo" class="model.member.MemberVO"/>
<jsp:setProperty property="*" name="mvo"/>

<jsp:useBean id="fvo" class="model.follow.FollowVO"/>
<jsp:setProperty property="*" name="fvo"/>

<!-- 
		구현해야 하는 기능 
		
		전체 게시글 가져오기 main
		게시글 쓰기 insertP
		게시글 삭제하기 deleteP
		게시글에 좋아요 누르기 updateP
		
		댓글 쓰기 insertC
		댓글 삭제하기 deleteC
		
		팔로우하기 insertF
		나를 팔로우한 목록 가져오기 selectFollowers
		내가 팔로우한 목록 가져오기 selectFollowings
		팔로우 취소 deleteF
		
		로그인하기 selectOne
		로그아웃하기 -> dao 필요 없음. 그냥 세션에 저장된 회원정보 삭제하면 됨
		회원가입하기 insertM
		회원정보가져오기 selectM
		회원정보 변경 updateM 
		
		
		// 추가 작업
		
		-> url 때에 따라 적절히 변경하기
		
 -->
 <%
    String action=request.getParameter("action");
	String cnt=request.getParameter("cnt");
	
	int mcnt= 3; // 최초에는 3개의 게시글을 볼수있음
	if(cnt!=null){
		mcnt=Integer.parseInt(cnt);
	}
	
	String url="controller.jsp?action=main";
	
	//TODO 각 action마다 코드 수정
	
	switch(action){
		// ===== 게시글 =====	
	case "main" :	
		// 메인페이지 이동하기 
		// clear
		ArrayList<PostSet> datas = pdao.selectAll(mcnt);
		request.setAttribute("datas", datas);
		request.setAttribute("cnt", mcnt);			
		
		pageContext.forward("main.jsp");
		break;
		
	case "insertP":
		// 게시글 쓰기 
		// clear
		if(pdao.insertP(pvo)){
			pageContext.forward(url);
		}
		else{
			System.out.println("insertP 액션에서 문제발생!");
		}
		break;		
		
	case "deleteP":
		// clear
		if(pdao.deleteP(pvo)){
			pageContext.forward(url);
		}
		else{
			System.out.println("deleteP 액션에서 문제발생!");
		}
		break;	
		
	case "updateP":
		// 좋아요 + 1
		// clear
		if(pdao.updateP(pvo)){
			pageContext.forward(url);
		}
		else{
			System.out.println("updateP 액션에서 문제발생!");
		}
		break;
		
		// ===== 댓글 ===== 
		
	case "insertC":
		// clear
		cvo.setPost_id(Integer.parseInt(request.getParameter("post_id")));
		cvo.setComment(request.getParameter("comment"));
		cvo.setMember_id(request.getParameter("member_id"));
		if(pdao.insertC(cvo)){
			pageContext.forward(url);
		}
		else{
			System.out.println("insertC 액션에서 문제발생!");
		}
		break;
		
	case "deleteC":
		// clear
		// 댓글 삭제하기 
		if(pdao.deleteC(cvo)){
			pageContext.forward(url);
		}
		else{
			System.out.println("deleteC 액션에서 문제발생!");
		}
		break;
		
		// ===== 팔로우 ===== 
		
	case "insertF":
		// 팔로우하기 
		fvo.setMember_id(request.getParameter("member_id"));
		fvo.setFollowing_id(request.getParameter("following_id"));
		
		if(fdao.insertF(fvo)){
			// followingList: 내가 팔로우 하는 사람들 목록 
			ArrayList<String> followingList2 = fdao.selectFollowings(fvo.getMember_id());		
			// followersList: 나를 팔로우 하는 사람들 목록
			ArrayList<String> followerList2 = fdao.selectFollowers(fvo.getMember_id());
					
			session.setAttribute("followingList2", followingList2);
			session.setAttribute("followerList2", followerList2);
			
			pageContext.forward(url);
		}
		else{
			System.out.println("insertF 액션에서 문제발생!");
		}
		break;
		
	case "selectF":
		// 나를 팔로우하는 사람 + 내가 팔로우 하는 사람 리스트 모두 들고와야됨.
		String id = request.getParameter("member_id");
		
		// followingList: 내가 팔로우 하는 사람들 목록 
		ArrayList<String> followingList = fdao.selectFollowings(id);
		
		// followersList: 나를 팔로우 하는 사람들 목록
		ArrayList<String> followerList = fdao.selectFollowers(id);
		
		request.setAttribute("followingList", followingList);
		request.setAttribute("followerList", followerList);

		pageContext.forward("follower.jsp");

		break;
		
	case "deleteF":
		// 팔로우 취소하기
		
		fvo.setMember_id(request.getParameter("member_id"));
		fvo.setFollowing_id(request.getParameter("following_id"));
			
		if(fdao.deleteF(fvo)){
			
			// followingList: 내가 팔로우 하는 사람들 목록 
			ArrayList<String> followingList2 = fdao.selectFollowings(fvo.getMember_id());		
			// followersList: 나를 팔로우 하는 사람들 목록
			ArrayList<String> followerList2 = fdao.selectFollowers(fvo.getMember_id());
					
			session.setAttribute("followingList2", followingList2);
			session.setAttribute("followerList2", followerList2);
			
			pageContext.forward(url);
		}
		else{
			System.out.println("deleteF 액션에서 문제발생!");
		}
		break;
		
		// ===== 로그인 =====
	case "login":	
		// 로그인하기 
		// clear
			
		String member_name = mdao.selectName(mvo);
		if(mdao.selectOne(mvo)){
			session.setAttribute("member_id", mvo.getMember_id());
			session.setAttribute("member_name", member_name);

			// followingList: 내가 팔로우 하는 사람들 목록 
			ArrayList<String> followingList2 = fdao.selectFollowings( mvo.getMember_id());		
			// followersList: 나를 팔로우 하는 사람들 목록
			ArrayList<String> followerList2 = fdao.selectFollowers( mvo.getMember_id());
					
			session.setAttribute("followingList2", followingList2);
			session.setAttribute("followerList2", followerList2);
			
			response.sendRedirect("controller.jsp?action=main");
		}
		else{
			out.println("<script>alert('로그인 실패!');history.go(-1);</script>");
		}
		break;
		
	case "insertM":
		// 회원가입하기 
		// clear
		if(mdao.insertM(mvo)){
			out.println("<script>alert('회원가입성공! 로그인하여 이용해주세요!:D');</script>");
			pageContext.forward("login.jsp");
		}
		else{
			out.println("<script>alert('회원가입실패! 아이디 중복입니다!');</script>");
			response.sendRedirect("signup.jsp");
		}
		break;
		
	case "selectM":
		// 회원정보 가져오고 화면에 표시하기
		// clear
		MemberVO memberInfo = mdao.selectM(mvo);		
		request.setAttribute("memberInfo", memberInfo);
		pageContext.forward("show.jsp");
		break;
		
	case "updateM":
		// 가져온 회원정보를 수정하기
		// clear
		String origin_member_name = request.getParameter("origin_member_name");
		if(mdao.updateM(mvo, origin_member_name)){
			// 재 로그인 요청
			out.println("<script>alert('회원정보 변경 성공! 다시 로그인 해주세요!');</script>");
			session.removeAttribute("member_id");
			session.removeAttribute("member_name");
			response.sendRedirect("controller.jsp?action=main");
		}
		else{
			System.out.println("updateM 액션에서 문제발생!");
		}
		break;
		
	case "logout":
		// clear
		session.removeAttribute("member_id"); // 세션에 저장된 값을 제거
		response.sendRedirect("controller.jsp?action=main");
	}	
	 %>
