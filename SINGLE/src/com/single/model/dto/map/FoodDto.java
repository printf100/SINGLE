package com.single.model.dto.map;

public class FoodDto {
	private int marker_code;
	private String food_name;
	private String food_content;
	private String food_image_name;
	private String food_image_realname;
	private String food_x;
	private String food_y;
	private int member_code;
	private String member_nickname;
	private String member_name;

	public FoodDto() {
		super();
	}

	public int getMarker_code() {
		return marker_code;
	}

	public void setMarker_code(int marker_code) {
		this.marker_code = marker_code;
	}

	public String getFood_name() {
		return food_name;
	}

	public void setFood_name(String food_name) {
		this.food_name = food_name;
	}

	public String getFood_content() {
		return food_content;
	}

	public void setFood_content(String food_content) {
		this.food_content = food_content;
	}

	public String getFood_image_name() {
		return food_image_name;
	}

	public void setFood_image_name(String food_image_name) {
		this.food_image_name = food_image_name;
	}

	public String getFood_image_realname() {
		return food_image_realname;
	}

	public void setFood_image_realname(String food_image_RealName) {
		this.food_image_realname = food_image_RealName;
	}

	public String getFood_x() {
		return food_x;
	}

	public void setFood_x(String food_x) {
		this.food_x = food_x;
	}

	public String getFood_y() {
		return food_y;
	}

	public void setFood_y(String food_y) {
		this.food_y = food_y;
	}

	public int getMember_code() {
		return member_code;
	}

	public void setMember_code(int member_code) {
		this.member_code = member_code;
	}

	public String getMember_nickname() {
		return member_nickname;
	}

	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

}