package com.single.model.biz.board;

import com.single.model.dao.board.NoticeDAO;
import com.single.model.dao.board.NoticeDAOImpl;

public class Paging {

	private final static int pageCount = 10; // 한 페이지에 보여질 게시물 수
	private final static int blockCount = 5; // 한 페이지에 보여질 페이징 수
	private int blockStartNum = 0;
	private int blockLastNum = 0;
	private int lastPageNum = 0;

	public int getBlockStartNum() {
		return blockStartNum;
	}

	public void setBlockStartNum(int blockStartNum) {
		this.blockStartNum = blockStartNum;
	}

	public int getBlockLastNum() {
		return blockLastNum;
	}

	public void setBlockLastNum(int blockLastNum) {
		this.blockLastNum = blockLastNum;
	}

	public int getLastPageNum() {
		return lastPageNum;
	}

	public void setLastPageNum(int lastPageNum) {
		this.lastPageNum = lastPageNum;
	}

	// block을 생성
	// 현재 페이지가 속한 block의 시작 번호, 끝 번호를 계산

	public void makeBlock(int curPage) {
		int blockNum = 0;
		blockNum = (int) Math.floor((curPage - 1) / blockCount);
		blockStartNum = (blockCount * blockNum) + 1;
		blockLastNum = blockStartNum + (blockCount - 1);
		if (blockLastNum > lastPageNum)
			blockLastNum = lastPageNum;
	}

	// 공지 게시판 총 페이지의 마지막 번호

	public void makeLastPageNum() {
		NoticeDAO dao = new NoticeDAOImpl();
		int total = dao.getNoticeDataCount();
		System.out.println("total : " + total);
		if (total % pageCount == 0) {
			lastPageNum = (int) Math.floor(total / pageCount);
		} else {
			lastPageNum = (int) Math.floor(total / pageCount) + 1;
		}
		System.out.println("lastPageNum : " + lastPageNum);
	}

	// 공지 게시판 검색을 했을 때 총 페이지의 마지막 번호

	public void makeLastPageNum(int how, String kwd) {
		NoticeDAO dao = new NoticeDAOImpl();
		int total = dao.getNoticeDataCount(how, kwd);
		System.out.println("search total : " + total);
		if (total % pageCount == 0) {
			lastPageNum = (int) Math.floor(total / pageCount);
		} else {
			lastPageNum = (int) Math.floor(total / pageCount) + 1;
		}
	}

	// 중고장터 총 페이지의 마지막 번호
	public void reslaeMakeLastPageNum() {
		NoticeDAO dao = new NoticeDAOImpl();
		int total = dao.getNoticeDataCount();
		System.out.println("total : " + total);
		if (total % pageCount == 0) {
			lastPageNum = (int) Math.floor(total / pageCount);
		} else {
			lastPageNum = (int) Math.floor(total / pageCount) + 1;
		}
		System.out.println("lastPageNum : " + lastPageNum);
	}

	// 중고장터 검색을 했을 때 총 페이지의 마지막 번호
	public void resaleMakeLastPageNum(int how, String kwd) {
		NoticeDAO dao = new NoticeDAOImpl();
		int total = dao.getNoticeDataCount(how, kwd);
		System.out.println("search total : " + total);
		if (total % pageCount == 0) {
			lastPageNum = (int) Math.floor(total / pageCount);
		} else {
			lastPageNum = (int) Math.floor(total / pageCount) + 1;
		}
	}

}
