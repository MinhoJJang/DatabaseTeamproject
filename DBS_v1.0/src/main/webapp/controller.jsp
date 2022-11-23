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
	
	int mcnt=10; // 최초에는 10개의 게시글을 볼수있음
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
		if(fdao.insertF(fvo)){
			pageContext.forward(url);
		}
		else{
			System.out.println("insertF 액션에서 문제발생!");
		}
		break;
		
	case "selectFollowers":
		// 나를 팔로우 하는 사람들 리스트 
		FollowSet followers = fdao.selectFollowers(fvo);
		request.setAttribute("followers", followers);
		// 팔로워 보여주는 창을 만들어야 함
		//
		pageContext.forward(url);
		
		break;
		
	case "selectFollowings":
		// 내가 팔로우 하는 사람들 리스트 
		FollowSet followings = fdao.selectFollowings(fvo);
		request.setAttribute("followings", followings);
		// 팔로워 보여주는 창을 만들어야 함
		//
		pageContext.forward(url);
		break;
		
	case "deleteF":
		// 팔로우 취소하기
		if(fdao.deleteF(fvo)){
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
		if(mdao.selectOne(mvo)){
			session.setAttribute("member_id", mvo.getMember_id());
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
			out.println("<script>alert('회원가입성공! 로그인하여 이용해주세요!:D');window.close();</script>");
		}
		else{
			out.println("<script>alert('회원가입실패!');history.go(-1);</script>");
		}
		break;
		
	case "selectM":
		// 회원정보 가져오고 화면에 표시하기
		MemberVO memberInfo = mdao.selectM(mvo);		
		request.setAttribute("member_info", memberInfo);
		pageContext.forward(url);
		break;
		
	case "updateM":
		// 가져온 회원정보를 수정하기
		if(mdao.updateM(mvo)){
			pageContext.forward(url);
		}
		else{
			System.out.println("updateM 액션에서 문제발생!");
		}
		break;
		
	case "logout":
		session.removeAttribute("member_id"); // 세션에 저장된 값을 제거
		response.sendRedirect("controller.jsp?action=main");
	}	
	 %>
