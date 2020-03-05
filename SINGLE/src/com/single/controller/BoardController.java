package com.single.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.single.model.biz.board.NoticeBiz;
import com.single.model.biz.board.NoticeBizImpl;
import com.single.model.biz.board.Paging;
import com.single.model.biz.board.ReplyBiz;
import com.single.model.biz.board.ReplyBizImpl;
import com.single.model.biz.board.ResaleBiz;
import com.single.model.biz.board.ResaleBizImpl;
import com.single.model.dto.board.BoardDTO;
import com.single.model.dto.board.LikeDTO;
import com.single.model.dto.board.ReplyDTO;
import com.single.model.dto.board.ResaleDTO;
import com.single.model.dto.member.MemberDTO;

/*
 * Board Controller
 * 게시판 관련 기능을 호출하기 위함
 */
@WebServlet(//
		name = "board", //
		urlPatterns = { //
				"noticepage.do", // 공지 목록(noticeList.jsp)로 이동
				"noticeDetail.do", // 공지 글 디테일 이동
				"noticeWrite.do", // 공지 글 쓰기 -> 폼 이동
				"noticeWriteRes.do", // 공지 글 쓰기 폼
				"noticeUpdate.do", // 공지 수정 전 게시판 글 하나 보기
				"noticeUpdateRes.do", // 공지 수정 폼
				"noticeDelete.do", // 공지 삭제
				"noticeFileDetail.do", //
				"resalepage.do", // 중고게시판(resaleList.jsp)로 이동
				"resaleSearchList.do", // 중고게시판 검색시 나오는 리스트로 이동
				"resaleWrite.do", // 중고게시판 글 쓰기 -> 폼 이동
				"resaleWriteRes.do", // 중고게시판 글 쓰기 폼
				"resaleDetail.do", // 중고게시판 디테일 이동
				"resaleUpdate.do", // 중고게시판 수정 전 게시판 글 하나 보기
				"resaleUpdateRes.do", // 중고게시판 수정 파일 재첨부 후 폼
				"resaleDelete.do", // 중고게시판 삭제
				"interest.do", // 중고게시판 관심 등록
				"resaleInterestList.do", // 관심 리스트 출력
				"interestDelete.do", // 관심 리스트 게시물 삭제
				"resaleMainList.do", // 중고게시판 메인
				"resaleUpdateNo.do", // 중고게시판 원본파일 그대로 수정 폼
				"replySelectList.do", // 중고게시판 댓글 출력
				"replyWrite.do", // 중고게시판 댓글 입력
				"replyDelete.do", // 중고게시판 댓글 삭제

		})

public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	NoticeBiz biz = new NoticeBizImpl();
	ResaleBiz rebiz = new ResaleBizImpl();
	ReplyBiz replybiz = new ReplyBizImpl();
	static BoardDTO dto = new BoardDTO();
	static ResaleDTO redto = new ResaleDTO();
	static ReplyDTO replyDto = new ReplyDTO();

	HttpSession session;

	public BoardController() {
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String command = request.getRequestURI();
		System.out.println("[ " + command + " ]");

		// 공지 게시판 관련

		if (command.endsWith("/noticepage.do")) {
			noticepage(request, response);
		} else if (command.endsWith("/noticeDetail.do")) {
			noticeDetail(request, response);
		} else if (command.endsWith("/noticeWrite.do")) {
			noticeWrite(request, response);
		} else if (command.endsWith("/noticeWriteRes.do")) {
			noticeWriteRes(request, response);
		} else if (command.endsWith("/noticeUpdate.do")) {
			noticeUpdate(request, response);
		} else if (command.endsWith("/noticeUpdateRes.do")) {
			noticeUpdateRes(request, response);
		} else if (command.endsWith("/noticeDelete.do")) {
			noticeDeleteRes(request, response);

			// 중고 게시판 관련

		} else if (command.endsWith("/resalepage.do")) {
			resalepage(request, response);
		} else if (command.endsWith("/resaleWrite.do")) {
			resaleWrite(request, response);
		} else if (command.endsWith("/resaleWriteRes.do")) {
			resaleWriteRes(request, response);
		} else if (command.endsWith("/resaleDetail.do")) {
			resaleDetail(request, response);
		} else if (command.endsWith("/resaleUpdate.do")) {
			resaleUpdate(request, response);
		} else if (command.endsWith("/resaleUpdateRes.do")) {
			resaleUpdateRes(request, response);
		} else if (command.endsWith("/resaleDelete.do")) {
			resaleDelete(request, response);

			// 중고 게시판 관심 리스트 관련

		} else if (command.endsWith("/interest.do")) {
			interest(request, response);
		} else if (command.endsWith("/resaleInterestList.do")) {
			resaleInterestList(request, response);
		} else if (command.endsWith("/interestDelete.do")) {
			interestDelete(request, response);
		} else if (command.endsWith("/resaleMainList.do")) {
			resaleMainList(request, response);

			// 중고 게시판 댓글 관련

		} else if (command.endsWith("/replyWrite.do")) {
			replyWrite(request, response);
		} else if (command.endsWith("/replyDelete.do")) {
			replyDelete(request, response);
		}

	}

	private void replyDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int REPLY_CODE = Integer.parseInt(request.getParameter("REPLY_CODE"));
		System.out.println("reply_code : " + REPLY_CODE);

		int res = replybiz.ReplyDelete(REPLY_CODE);

		JSONObject obj = new JSONObject();

		if (res > 0) {
			obj.put("result", 1);
		} else {
			obj.put("result", 0);
		}

		String msg = obj.toJSONString();
		System.out.println("삭제 결과 : " + msg);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 중고 게시판 댓글 작성
	private void replyWrite(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("---댓글 작성 들어왔다---");

		int RESALE_CODE = Integer.parseInt(request.getParameter("RESALE_CODE"));
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		String REPLY_CONTENT = request.getParameter("REPLY_CONTENT");

		System.out.println("RESALE_CODE는 " + RESALE_CODE);
		System.out.println("MEMBER_CODE는" + MEMBER_CODE);
		System.out.println("REPLY_CONTENT는" + REPLY_CONTENT);

		ReplyDTO replyDto = new ReplyDTO(RESALE_CODE, MEMBER_CODE, REPLY_CONTENT);

		// 댓글 작성 & reply_code 가져오기
		int reply_code = replybiz.ReplyWrite(replyDto);
		String MEMBER_NICKNAME = replybiz.getReplyNickName(MEMBER_CODE);

		System.out.println("reply_code :" + reply_code);
		System.out.println("resale_code : " + RESALE_CODE);
		System.out.println("member_code : " + MEMBER_CODE);
		System.out.println("member_nickname : " + MEMBER_NICKNAME);

		ReplyDTO repDto = new ReplyDTO();

		if (reply_code > 0) {

			// 글 하나 출력
			repDto = replybiz.ReplySelectOne(reply_code, RESALE_CODE);

			System.out.println("repDto : " + repDto);

			JSONObject obj = new JSONObject();

			obj.put("REPLY_CODE", Integer.toString(repDto.getREPLY_CODE()));
			obj.put("MEMBER_CODE", Integer.toString(repDto.getMEMBER_CODE()));
			obj.put("RESALE_CODE", Integer.toString(repDto.getRESALE_CODE()));
			obj.put("REPLY_CONTENT", repDto.getREPLY_CONTENT());
			obj.put("REPLY_LIKE", Integer.toString(repDto.getREPLY_LIKE()));
			obj.put("REPLY_REGDATE", repDto.getREPLY_REGDATE() + "");
			obj.put("MEMBER_NICKNAME", MEMBER_NICKNAME);

			String result = obj.toJSONString();

			System.out.println("json string : " + result);
			PrintWriter out = response.getWriter();
			out.println(result);

		} else {
			jsResponse("글 하나 가져오기 실패했습니다.", "/SINGLE/board/resaleDetail.do?RESALE_CODE =" + RESALE_CODE, response);
		}

	}

	/*
	 * // 중고 게시판 댓글 출력 private void replySelectList(HttpServletRequest request,
	 * HttpServletResponse response) throws ServletException, IOException { int
	 * RESALE_CODE = Integer.parseInt(request.getParameter("RESALE_CODE"));
	 * 
	 * List<ReplyDTO> replyList = replybiz.ReplySelectList(RESALE_CODE);
	 * request.setAttribute("replyList", replyList);
	 * 
	 * dispatch("/views/board/resaleDetail.jsp", request, response);
	 * 
	 * 
	 * }
	 */

	// 중고 게시판 메인 화면
	private void resaleMainList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<ResaleDTO> list = rebiz.ResaleMainList();
		request.setAttribute("list", list);

		dispatch("/views/board/resaleMainList.jsp", request, response);

	}

	// 관심 리스트 선택 글 삭제
	private void interestDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String[] RESALE_CODE = request.getParameterValues("chk");
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		System.out.println(Arrays.toString(RESALE_CODE));

		if (RESALE_CODE == null || RESALE_CODE.length == 0) {
			PrintWriter out = response.getWriter();
			out.println("<script type='text/javascript'>");
			out.println("alert('삭제할 글을 1개 이상 선택해주세요.')");
			out.println("</script>");
		} else {
			int res = rebiz.multiDelete(RESALE_CODE, MEMBER_CODE);
			if (res > 0) {
				jsResponse("삭제 성공했습니다.", "/SINGLE/board/resaleInterestList.do?MEMBER_CODE=" + MEMBER_CODE, response);
			} else {
				jsResponse("삭제 실패했습니다", "/SINGLE/board/resaleInterestList.do?MEMBER_CODE=" + MEMBER_CODE, response);
			}
		}

	}

	// 관심 리스트
	private void resaleInterestList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		System.out.println("-----------------------" + MEMBER_CODE);

		List<LikeDTO> list = rebiz.interestList(MEMBER_CODE);
		request.setAttribute("list", list);

		dispatch("/views/board/resaleInterestList.jsp", request, response);

	}

	// 중고게시판 관심 등록
	private void interest(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int RESALE_CODE = Integer.parseInt(request.getParameter("RESALE_CODE"));
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		LikeDTO dto = new LikeDTO(MEMBER_CODE, RESALE_CODE);
		int count = rebiz.stopInterest(dto);

		if (count == 1) {
			jsResponse("이미 등록된 게시글입니다.", "/SINGLE/board/resaleDetail.do?RESALE_CODE=" + RESALE_CODE, response);
		} else {
			int res = rebiz.updateInterest(RESALE_CODE);
			int result = rebiz.insertInterest(dto);

			if (res > 0 && result > 0) {
				jsResponse("관심 등록되었습니다.", "/SINGLE/board/resaleDetail.do?RESALE_CODE=" + RESALE_CODE, response);

			}
		}
	}

	// 중고게시판 삭제
	private void resaleDelete(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("중고게시판 삭제 들어왔다!");

		int RESALE_CODE = Integer.parseInt(request.getParameter("RESALE_CODE"));
		String RESALE_IMG_SERVER = request.getParameter("RESALE_IMG_SERVER");

		System.out.println("resale_code : " + RESALE_CODE);
		System.out.println("resale_img_server : " + RESALE_IMG_SERVER);

		// 지울 파일이 존재하는 디렉토리
		String filePath = "/resources/resaleImages/";

		String resale_file_path = getServletContext().getRealPath(filePath);

		resale_file_path += RESALE_IMG_SERVER;

		File file = new File(resale_file_path);
		if (file.exists()) {
			file.delete();
		}

		int res = rebiz.ResaleDelete(RESALE_CODE);

		if (res > 0) {
			jsResponse("삭제 성공했습니다.", "/SINGLE/board/resalepage.do", response);
		} else {
			jsResponse("삭제 실패했습니다.", "/SINGLE/board/resaleDelete.do?RESALE_CODE=" + RESALE_CODE + "&RESALE_IMG_SERVER="
					+ RESALE_IMG_SERVER, response);
		}

	}

	// 중고게시판 파일 재첨부 후 수정
	private void resaleUpdateRes(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("글쓰기 수정 들어왔다!");

		String BOARD_FILE_PATH = "/resources/resaleImages/";

		// 업로드 될 실제 경로
		String BOARD_IMG_PATH = getServletContext().getRealPath(BOARD_FILE_PATH);
		System.out.println(BOARD_IMG_PATH);

		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";

		// 디렉토리가 존재하지 않으면 생성
		File isDir = new File(BOARD_IMG_PATH);

		if (!isDir.isDirectory()) {
			System.out.println("디렉토리가 없습니다. 디렉토리를 새로 생성합니다.");
			isDir.mkdir();

		}

		System.out.println(BOARD_IMG_PATH);

		// 파일을 받기 위한 객체 생성
		MultipartRequest mul = null;

		try {
			mul = new MultipartRequest(request, BOARD_IMG_PATH, maxSize, encoding, new DefaultFileRenamePolicy());
		} catch (Exception e) {
			System.out.println("multipartrequest 객체 생성 오류");
			e.printStackTrace();
		}

		// 글쓰기 기본 정보
		int MEMBER_CODE = Integer.parseInt(mul.getParameter("MEMBER_CODE"));
		int RESALE_CODE = Integer.parseInt(mul.getParameter("RESALE_CODE"));
		String RESALE_TITLE = mul.getParameter("RESALE_TITLE");
		String RESALE_CONTENT = mul.getParameter("RESALE_CONTENT");
		String RESALE_ADDRESS = mul.getParameter("RESALE_ADDRESS");
		String RESALE_PRICE = mul.getParameter("RESALE_PRICE");

		// 첨부 파일 관련

		// 파일 원래 저장 이름
		String RESALE_IMG_ORIGINAL = null;

		// 파일 서버에 저장된 이름
		String RESALE_IMG_SERVER = null;

		RESALE_IMG_SERVER = mul.getFilesystemName("RESALE_IMG_ORIGINAL");
		System.out.println(RESALE_IMG_SERVER);

		if (RESALE_IMG_ORIGINAL == null) {
			redto = new ResaleDTO(RESALE_TITLE, RESALE_CONTENT, RESALE_ADDRESS, RESALE_PRICE, RESALE_CODE, MEMBER_CODE);

			int res = rebiz.ResaleUpdateNo(redto);
			if (res > 0) {
				jsResponse("글 수정 성공", "/SINGLE/board/resaleDetail.do?&RESALE_CODE=" + RESALE_CODE, response);
			} else {
				jsResponse("글 수정 실패", "/SINGLE/board/resaleUpdate.do?&RESALE_CODE=" + RESALE_CODE, response);
			}
		}

		// 실제 파일 이름
		RESALE_IMG_ORIGINAL = mul.getOriginalFileName("RESALE_IMG_ORIGINAL");
		System.out.println(RESALE_IMG_ORIGINAL);

		redto = new ResaleDTO(RESALE_TITLE, RESALE_CONTENT, RESALE_ADDRESS, RESALE_PRICE, RESALE_IMG_ORIGINAL,
				RESALE_IMG_SERVER, RESALE_CODE, MEMBER_CODE);

		int res = rebiz.ResaleUpdate(redto);

		if (res > 0) {
			jsResponse("글 수정 성공", "/SINGLE/board/resaleDetail.do?&RESALE_CODE=" + RESALE_CODE, response);
		} else {
			jsResponse("글 수정 실패", "/SINGLE/board/resaleUpdate.do?&RESALE_CODE=" + RESALE_CODE, response);
		}

	}

	// 중고게시판 수정 전 글 보기
	private void resaleUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("중고게시판 수정 전 글 하나 보기 들어왔다!");

		int RESALE_CODE = Integer.parseInt(request.getParameter("RESALE_CODE"));
		rebiz.updateResaleCountView(RESALE_CODE);

		ResaleDTO dto = rebiz.ResaleSelectOne(RESALE_CODE);
		request.setAttribute("dto", dto);

		MemberDTO memdto = rebiz.getResaleNickname(RESALE_CODE);
		request.setAttribute("memdto", memdto);

		dispatch("/views/board/resaleUpdateForm.jsp", request, response);
	}

	// 중고게시판 글 보기
	private void resaleDetail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("중고게시판 디테일 들어왔다!");

		int RESALE_CODE = Integer.parseInt(request.getParameter("RESALE_CODE"));
		rebiz.updateResaleCountView(RESALE_CODE);
		session = request.getSession();
		session.setAttribute("RESALE_COUNTVIEW", rebiz.ResaleSelectOne(RESALE_CODE).getRESALE_COUNTVIEW());

		ResaleDTO dto = rebiz.ResaleSelectOne(RESALE_CODE);
		request.setAttribute("dto", dto);

		List<ReplyDTO> replyList = replybiz.ReplySelectList(RESALE_CODE);
		request.setAttribute("replyList", replyList);

		MemberDTO memdto = rebiz.getResaleNickname(RESALE_CODE);
		request.setAttribute("memdto", memdto);
		dispatch("/views/board/resaleDetail.jsp", request, response);

	}

	// 중고게시판 글쓰기
	private void resaleWriteRes(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 업로드 될 경로
		String BOARD_FILE_PATH = "/resources/resaleImages/";

		// 업로드 될 실제 경로
		String BOARD_IMG_PATH = getServletContext().getRealPath(BOARD_FILE_PATH);
		System.out.println(BOARD_IMG_PATH);

		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";

		// 디렉토리가 존재하지 않으면 생성
		File isDir = new File(BOARD_IMG_PATH);

		if (!isDir.isDirectory()) {
			System.out.println("디렉토리가 없습니다. 디렉토리를 새로 생성합니다.");
			isDir.mkdir();

		}

		System.out.println(BOARD_IMG_PATH);

		// 파일을 받기 위한 객체 생성
		MultipartRequest mul = null;

		try {
			mul = new MultipartRequest(request, BOARD_IMG_PATH, maxSize, encoding, new DefaultFileRenamePolicy());
		} catch (Exception e) {
			System.out.println("multipartrequest 객체 생성 오류");
			e.printStackTrace();
		}

		// 글쓰기 기본 정보
		int MEMBER_CODE = Integer.parseInt(mul.getParameter("MEMBER_CODE"));
		String RESALE_TITLE = mul.getParameter("RESALE_TITLE");
		String RESALE_CONTENT = mul.getParameter("RESALE_CONTENT");
		String RESALE_ADDRESS = mul.getParameter("RESALE_ADDRESS");
		String RESALE_PRICE = mul.getParameter("RESALE_PRICE");

		// 첨부 파일 관련

		// 파일 원래 이름
		String RESALE_IMG_ORIGINAL = null;
		// 파일 서버에 저장된 이름
		String RESALE_IMG_SERVER = null;

		RESALE_IMG_SERVER = mul.getFilesystemName("RESALE_IMG_ORIGINAL");
		System.out.println(RESALE_IMG_SERVER);

		// 실제 파일 이름
		RESALE_IMG_ORIGINAL = mul.getOriginalFileName("RESALE_IMG_ORIGINAL");

		System.out.println(RESALE_IMG_ORIGINAL);

		ResaleDTO resaleDto = new ResaleDTO(MEMBER_CODE, RESALE_TITLE, RESALE_CONTENT, RESALE_ADDRESS, RESALE_PRICE,
				RESALE_IMG_ORIGINAL, RESALE_IMG_SERVER);

		int res = rebiz.ResaleWrite(resaleDto);

		if (res > 0) {
			jsResponse("글쓰기 성공", "/SINGLE/board/resaleMainList.do", response);
		} else {
			jsResponse("글쓰기 실패", "/SINGLE/board/resaleWrite.do", response);

		}

	}

	// 중고게시판 글쓰기 form 이동
	private void resaleWrite(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("왔다");
		response.sendRedirect("/SINGLE/views/board/resaleWriteForm.jsp");

	}

	// 중고게시판 목록
	private void resalepage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String option = null;
		String condition = null;

		if (request.getParameter("condition") != null && request.getParameter("condition") != "") {
			System.out.println(request.getParameter("condition"));
			System.out.println(request.getParameter("option"));
			System.out.println("검색 변수 존재");

			option = request.getParameter("option");
			condition = request.getParameter("condition");

			System.out.println(option);
			System.out.println(condition);

			Paging paging = new Paging();
			paging.makeLastPageNum(Integer.parseInt(option), condition);

			int curPage = 1; // 현재 페이지

			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
				paging.makeBlock(curPage);
				request.setAttribute("curPageNum", curPage);
			} else {
				paging.makeBlock(curPage);
				request.setAttribute("curPageNum", curPage);
			}

			// 받은 검색 / 받은 옵션 / 계산한 페이징 setAttribute ->

			Integer blockStartNum = paging.getBlockStartNum();
			Integer blockLastNum = paging.getBlockLastNum();
			Integer lastPageNum = paging.getLastPageNum();

			request.setAttribute("blockStartNum", blockStartNum);
			request.setAttribute("blockLastNum", blockLastNum);
			request.setAttribute("lastPageNum", lastPageNum);

			request.setAttribute("condition", condition);
			request.setAttribute("option", option);

			// 비즈에서 만난 searchListDate 를 list란 var로 보내주기
			request.setAttribute("ResaleBoardList",
					rebiz.ResaleSelectSearchListData(curPage, Integer.parseInt(option), condition));

		} else {
			request.removeAttribute("option");
			request.removeAttribute("condition");
			System.out.println("검색어가 없습니다");

			Paging paging = new Paging();
			paging.makeLastPageNum();

			int curPage = 1; // 현재 페이지

			// 페이징 번호를 눌렀을 때
			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
				paging.makeBlock(curPage);
				request.setAttribute("curPage", curPage);

			} else {
				// 페이지를 누르지 않았을 때
				paging.makeBlock(curPage);
				request.setAttribute("curPage", curPage);
			}

			Integer blockStartNum = paging.getBlockStartNum();
			Integer blockLastNum = paging.getBlockLastNum();
			Integer lastPageNum = paging.getLastPageNum();

			request.setAttribute("blockStartNum", blockStartNum);
			request.setAttribute("blockLastNum", blockLastNum);
			request.setAttribute("lastPageNum", lastPageNum);

			// biz!!! biz.NoticeSelectListData( boardService.selectBoardsListData(curPage) )
			request.setAttribute("ResaleBoardList", rebiz.ResaleSelectBoardsListData(curPage));
		}

		dispatch("/views/board/resaleList.jsp", request, response);

	}

	// 공지 글 삭제
	private void noticeDeleteRes(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("공지 삭제 들어왔다!!");

		int BOARD_CODE = Integer.parseInt(request.getParameter("BOARD_CODE"));
		String FILE_SERVER = request.getParameter("FILE_SERVER");

		File file = new File(FILE_SERVER);

		if (file.exists()) {
			file.delete();
		}

		int res = biz.NoticeDelete(BOARD_CODE);

		if (res > 0) {
			jsResponse("글 삭제 성공", "/SINGLE/board/noticepage.do", response);
		} else {
			jsResponse("글 삭제 실패", "/SINGLE/board/noticeDetail.do", response);
		}

	}

	// 공지 글 수정 결과
	private void noticeUpdateRes(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("공지 수정 들어왔다!!");

		// 파일 첨부 했을 때 글 수정
		String BOARD_FILE_PATH = "/uploadImages/";

		// 업로드 될 실제 경로
		String BOARD_IMG_PATH = getServletContext().getRealPath(BOARD_FILE_PATH);
		System.out.println(BOARD_IMG_PATH);

		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";

		// 디렉토리가 존재하지 않으면 생성
		File isDir = new File(BOARD_IMG_PATH);

		if (!isDir.isDirectory()) {
			System.out.println("디렉토리가 없습니다. 디렉토리를 새로 생성합니다.");
			isDir.mkdir();

		}

		System.out.println(BOARD_IMG_PATH);

		// 파일을 받기 위한 객체 생성
		MultipartRequest mul = null;

		try {
			mul = new MultipartRequest(request, BOARD_IMG_PATH, maxSize, encoding, new DefaultFileRenamePolicy());
		} catch (Exception e) {
			System.out.println("multipartrequest 객체 생성 오류");
			e.printStackTrace();
		}

		String BOARD_TITLE = mul.getParameter("BOARD_TITLE");
		int BOARD_CODE = Integer.parseInt(mul.getParameter("BOARD_CODE"));
		String BOARD_CONTENT = mul.getParameter("BOARD_CONTENT");

		String FILE_ORIGINAL = null;
		String FILE_SERVER = null;
		FILE_SERVER = mul.getFilesystemName("FILE_ORIGINAL");

		if (mul.getParameter("FILE_SERVER") != null) {
			FILE_ORIGINAL = mul.getOriginalFileName("FILE_ORIGINAL");
			dto = new BoardDTO(BOARD_TITLE, BOARD_CONTENT, BOARD_CODE, FILE_SERVER, FILE_ORIGINAL);
		} else {
			dto = new BoardDTO(BOARD_TITLE, BOARD_CONTENT, BOARD_CODE, "", "");
		}

		System.out.println(dto);

		int res = biz.NoticeUpdateWithFile(dto);

		if (res > 0) {
			jsResponse("글 수정 성공", "/SINGLE/board/noticeDetail.do?&BOARD_CODE=" + BOARD_CODE, response);
		} else {
			jsResponse("글 수정 실패", "/SINGLE/board/noticeUpdate.do?&BOARD_CODE=" + BOARD_CODE, response);

		}

	}

	// 공지 글 수정 전 글 하나 출력
	private void noticeUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int BOARD_CODE = Integer.parseInt(request.getParameter("BOARD_CODE"));
		System.out.println("수정전 글 하나 보기 들어왔다!");
		dto = biz.NoticeSelectOne(BOARD_CODE);
		System.out.println("board_code : " + BOARD_CODE);
		request.setAttribute("dto", dto);
		dispatch("/views/board/noticeUpdateForm.jsp", request, response);

	}

	// 공지 글 쓰기
	private void noticeWriteRes(HttpServletRequest request, HttpServletResponse response) throws IOException {

		// 업로드 될 경로
		String BOARD_FILE_PATH = "/uploadImages/";

		// 업로드 될 실제 경로
		String BOARD_IMG_PATH = getServletContext().getRealPath(BOARD_FILE_PATH);
		System.out.println(BOARD_IMG_PATH);

		int maxSize = 1024 * 1024 * 10;
		String encoding = "UTF-8";

		// 디렉토리가 존재하지 않으면 생성
		File isDir = new File(BOARD_IMG_PATH);

		if (!isDir.isDirectory()) {
			System.out.println("디렉토리가 없습니다. 디렉토리를 새로 생성합니다.");
			isDir.mkdir();

		}

		System.out.println(BOARD_IMG_PATH);

		// 파일을 받기 위한 객체 생성
		MultipartRequest mul = null;

		try {
			mul = new MultipartRequest(request, BOARD_IMG_PATH, maxSize, encoding, new DefaultFileRenamePolicy());
		} catch (Exception e) {
			System.out.println("multipartrequest 객체 생성 오류");
			e.printStackTrace();
		}

		// 글쓰기 기본 정보
		int MEMBER_CODE = Integer.parseInt(mul.getParameter("MEMBER_CODE"));
		String BOARD_TITLE = mul.getParameter("BOARD_TITLE");
		String BOARD_CONTENT = mul.getParameter("BOARD_CONTENT");

		// 첨부 파일 관련

		// 파일 원래 이름
		String FILE_ORIGINAL = null;
		// 파일 서버에 저장된 이름
		String FILE_SERVER = null;

		FILE_SERVER = mul.getFilesystemName("NOTICE_FILE_ORIGINAL");
		System.out.println(FILE_SERVER);

		// 파일 첨부하지 않았을 때 글쓰기

		if (FILE_SERVER != null) {
			FILE_ORIGINAL = mul.getOriginalFileName("NOTICE_FILE_ORIGINAL");

			dto = new BoardDTO(MEMBER_CODE, BOARD_TITLE, BOARD_CONTENT, FILE_ORIGINAL, FILE_SERVER);

		} else {
			dto = new BoardDTO(MEMBER_CODE, BOARD_TITLE, BOARD_CONTENT, "", "");
		}

		System.out.println(dto);

		int res = biz.NoticeWrite(dto);

		if (res > 0) {

			jsResponse("글이 작성되었습니다.", "/SINGLE/board/noticepage.do", response);
		}
		jsResponse("글 작성 실패했습니다.", "/SINGLE/board/noticepage.do", response);

	}

	// 공지 글 쓰기 form 이동
	private void noticeWrite(HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("왔다");
		response.sendRedirect("/SINGLE/views/board/noticeWriteForm.jsp");

	}

	// 글 하나 보기
	private void noticeDetail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("파일 서버 이름 들어왔나");

		String FILE_SERVER = request.getParameter("FILE_SERVER");

		System.out.println(FILE_SERVER + "있는지 확인");

		int BOARD_CODE = Integer.parseInt(request.getParameter("BOARD_CODE"));
		biz.updateNoticeCountView(BOARD_CODE);
		session = request.getSession();
		session.setAttribute("COUNT_VIEW", biz.NoticeSelectOne(BOARD_CODE).getCOUNT_VIEW());

		System.out.println(biz.NoticeSelectOne(BOARD_CODE).getCOUNT_VIEW());

		BoardDTO dto = biz.NoticeSelectOne(BOARD_CODE);
		request.setAttribute("dto", dto);
		dispatch("/views/board/noticeDetail.jsp", request, response);

	}

	// 공지 게시판 출력
	private void noticepage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String option = null;
		String condition = null;

		if (request.getParameter("condition") != null && request.getParameter("condition") != "") {
			System.out.println(request.getParameter("condition"));
			System.out.println(request.getParameter("option"));
			System.out.println("검색 변수 존재");

			option = request.getParameter("option");
			condition = request.getParameter("condition");

			System.out.println(option);
			System.out.println(condition);

			Paging paging = new Paging();
			paging.makeLastPageNum(Integer.parseInt(option), condition);

			int curPage = 1; // 현재 페이지

			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
				paging.makeBlock(curPage);
				request.setAttribute("curPageNum", curPage);
			} else {
				paging.makeBlock(curPage);
				request.setAttribute("curPageNum", curPage);
			}

			// 받은 검색 / 받은 옵션 / 계산한 페이징 setAttribute ->

			Integer blockStartNum = paging.getBlockStartNum();
			Integer blockLastNum = paging.getBlockLastNum();
			Integer lastPageNum = paging.getLastPageNum();

			request.setAttribute("blockStartNum", blockStartNum);
			request.setAttribute("blockLastNum", blockLastNum);
			request.setAttribute("lastPageNum", lastPageNum);

			request.setAttribute("condition", condition);
			request.setAttribute("option", option);

			// 비즈에서 만난 searchListDate 를 list란 var로 보내주기
			request.setAttribute("NoticeBoardList",
					biz.NoticeSelectSearchListData(curPage, Integer.parseInt(option), condition));

		} else {
			request.removeAttribute("option");
			request.removeAttribute("condition");
			System.out.println("검색어가 없습니다");

			Paging paging = new Paging();
			paging.makeLastPageNum();

			int curPage = 1; // 현재 페이지

			// 페이징 번호를 눌렀을 때
			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
				paging.makeBlock(curPage);
				request.setAttribute("curPage", curPage);

			} else {
				// 페이지를 누르지 않았을 때
				paging.makeBlock(curPage);
				request.setAttribute("curPage", curPage);
			}

			Integer blockStartNum = paging.getBlockStartNum();
			Integer blockLastNum = paging.getBlockLastNum();
			Integer lastPageNum = paging.getLastPageNum();

			request.setAttribute("blockStartNum", blockStartNum);
			request.setAttribute("blockLastNum", blockLastNum);
			request.setAttribute("lastPageNum", lastPageNum);

			// biz!!! biz.NoticeSelectListData( boardService.selectBoardsListData(curPage) )
			request.setAttribute("NoticeBoardList", biz.NoticeSelectBoardsListData(curPage));
		}

		dispatch("/views/board/noticeList.jsp", request, response);
	}

	/*
	 * Servlet Basic Template : PLEASE DO NOT MODIFY !!!!!
	 */
	private void dispatch(String url, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	private void jsResponse(String msg, String url, HttpServletResponse response) throws IOException {

		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('" + msg + "')");
		out.println("location.href='" + url + "'");
		out.println("</script>");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		processRequest(request, response);
	}

}
