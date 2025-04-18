package common.externalApi;

import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;


/**
 * 
* @packageName    : common.externalApi
* @fileName       : HnpWeather.java
* @author         : 이의찬/매니저
* @date           : 2024.07.22
* @description    :
* ===========================================================
* DATE                        AUTHOR             NOTE
* -----------------------------------------------------------
* 2024.07.22    			이의찬/매니저       최초 생성
* 
 */
@Service
public class HnpWeather {


	/**
	 * 
	* @methodName    : get
	* @author        : (성명)/(직위)
	* @date          : 2024.07.22
	* @param x			화면으로부터 받는
	* @param y
	* @param v
	* @return
	* Description 	 : 날씨 정보 API 입니다. hnpTest.js ->  AjaxTest.java -> HnpWeather.java
	 */
	public String[] get(int x, int y, String[] v) {

		System.out.println(":::: 기상청 API 연결하기 ::::");

		HttpURLConnection con = null;
		String s = null; // 에러 메시지

		try {
			LocalDateTime t = LocalDateTime.now().minusMinutes(30); // 현재 시각 30분전

			URL url = new URL("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst"
					+ "?ServiceKey=nYrvOHdHDUUOV%2Fb8t4ddcrtVY02lgsfE%2BNmWpM%2F88LynhtxTOqBYkJZWbBCccrjZGcvSysLZVipV0g069cKT2A%3D%3D" // 서비스키
					// + "&pageNo=1" // 페이지번호 Default: 1
					+ "&numOfRows=60" // 한 페이지 결과 수 (10개 카테고리값 * 6시간)
					// + "&dataType=XML" // 요청자료형식(XML/JSON) Default: XML
					+ "&base_date=" + t.format(DateTimeFormatter.ofPattern("yyyyMMdd")) // 발표 날짜
					+ "&base_time=" + t.format(DateTimeFormatter.ofPattern("HHmm")) // 발표 시각
					+ "&nx=" + x // 예보지점의 X 좌표값
					+ "&ny=" + y // 예보지점의 Y 좌표값
			);

			con = (HttpURLConnection) url.openConnection();
			Document doc = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(con.getInputStream());

			boolean ok = false; // <resultCode>00</resultCode> 획득 여부

			Element e;
			NodeList ns = doc.getElementsByTagName("header");
			if (ns.getLength() > 0) {
				e = (Element) ns.item(0);
				if ("00".equals(e.getElementsByTagName("resultCode").item(0).getTextContent()))
					ok = true; // 성공 여부
				else // 에러 메시지
					s = e.getElementsByTagName("resultMsg").item(0).getTextContent();
			}

			if (ok) {
				String fd = null, ft = null; // 가장 빠른 예보 시각
				String pty = null; // 강수형태
				String sky = null; // 하늘상태
				String cat; // category
				String val; // fcstValue

				ns = doc.getElementsByTagName("item");
				for (int i = 0; i < ns.getLength(); i++) {
					e = (Element) ns.item(i);

					if (ft == null) { // 가져올 예보 시간 결정
						fd = e.getElementsByTagName("fcstDate").item(0).getTextContent(); // 예보 날짜
						ft = e.getElementsByTagName("fcstTime").item(0).getTextContent(); // 예보 시각
					} else if (!fd.equals(e.getElementsByTagName("fcstDate").item(0).getTextContent())
							|| !ft.equals(e.getElementsByTagName("fcstTime").item(0).getTextContent()))
						continue; // 결정된 예보 시각과 같은 시각의 것만 취한다.

					cat = e.getElementsByTagName("category").item(0).getTextContent(); // 자료구분코드
					/*
					 * T1H : 기온(℃) RN1 : 1시간 강수량(범주(1 mm)) SKY : 하늘상태(코드값) UUU : 동서바람성분(m/s) VVV :
					 * 남북바람성분(m/s) REH : 습도(%) PTY : 강수형태(코드값) LGT : 낙뢰(코드값) VEC : 풍향(deg) WSD :
					 * 풍속(m/s) //
					 */
					val = e.getElementsByTagName("fcstValue").item(0).getTextContent(); // 예보 값

					if ("PTY".equals(cat))
						pty = val; // 강수형태
					else if ("SKY".equals(cat))
						sky = val; // 하늘상태
					else if ("T1H".equals(cat))
						v[3] = val; // 기온
					else if ("REH".equals(cat))
						v[4] = val; // 습도
				}

				v[0] = fd;
				v[1] = ft;

				if ("0".equals(pty)) { // 강수형태 없으면, 하늘상태로 판단
					if ("1".equals(sky))
						v[2] = "맑음";
					else if ("3".equals(sky))
						v[2] = "구름많음";
					else if ("4".equals(sky))
						v[2] = "흐림";
				} else if ("1".equals(pty))
					v[2] = "비";
				else if ("2".equals(pty))
					v[2] = "비/눈";
				else if ("3".equals(pty))
					v[2] = "눈";
				else if ("5".equals(pty))
					v[2] = "빗방울";
				else if ("6".equals(pty))
					v[2] = "빗방울눈날림";
				else if ("7".equals(pty))
					v[2] = "눈날림";
			}


		} catch (Exception e) {
			s = e.getMessage();
		}

		if (con != null) {

			con.disconnect();

		}
		System.out.println(":::: 기상청 API 종료 ::::");
		return v;
	}

}
