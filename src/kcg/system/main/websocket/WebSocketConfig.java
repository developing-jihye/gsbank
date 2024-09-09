package kcg.system.main.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration // 설정 파일임을 알림
@EnableWebSocketMessageBroker // 웹소켓 메시지 브로커 활성화를 알림
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

	@Override
	public void configureMessageBroker(MessageBrokerRegistry config) {
		config.enableSimpleBroker("/topic"); // 서버 -> 클라이언트로 전달되는 메시지 경로
		config.setApplicationDestinationPrefixes("/app"); // 클라이언트 -> 서버로 오는 메시지 경로
	}

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		registry.addEndpoint("/live-chat"); // 클라이언트가 이 주소로 연결 요청을 보냄. (클라이언트와 서버를 연결)
	}

}
