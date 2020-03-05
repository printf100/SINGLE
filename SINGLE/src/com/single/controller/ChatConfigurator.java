package com.single.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

public class ChatConfigurator extends Configurator {

	public static final String Session = "Session";
	public static final String Context = "Context";

	@Override
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {

		// HttpRequest로부터 Session을 받는다
		HttpSession session = (HttpSession) request.getHttpSession();
		
		// HttpSession로부터 Context를 받는다
		ServletContext context = session.getServletContext();
		
		sec.getUserProperties().put(ChatConfigurator.Session, session);
		sec.getUserProperties().put(ChatConfigurator.Context, context);
	}
}
