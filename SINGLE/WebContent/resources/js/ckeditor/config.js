/**
 * @license Copyright (c) 2003-2019, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	//config.resize_minWidth = 600;
	//config.resize_minHeight = 800;
	config.filebrowserImageUrl = 'SINGLE/board/noticeWriteRes.do';
	config.filebrowserUploadUrl = '/SINGLE/board/noticeWriteRes.do';
	//config.filebrowserUploadUrl = '업로드 된 파일을 처리할 프로그램 경로(ex:/ckeditor/fileUpload.aspx)';
	config.font_names = CKEDITOR.config.font_names = '맑은 고딕/Malgun Gothic;굴림/Gulim;돋움/Dotum;바탕/Batang;궁서/Gungsuh;' + CKEDITOR.config.font_names;
	config.enterMode = CKEDITOR.ENTER_BR;

};



