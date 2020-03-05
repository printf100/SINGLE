package com.single.util.string;

public class Format {

	public static String isTwo(String str) {
		
		return (str.length() < 2) ? "0" + str : str;
	}
}
