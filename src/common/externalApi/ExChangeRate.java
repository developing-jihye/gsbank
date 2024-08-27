package common.externalApi;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * 
* @packageName    : common.externalApi
* @fileName       : ExChangeRate.java
* @author         : 이의찬/매니저
* @date           : 2024.07.22
* @description    : 환율정보 API
* ===========================================================
* DATE          AUTHOR           NOTE
* -----------------------------------------------------------
* 2024.07.22    이의찬/매니저       최초 생성
 */
@Service
public class ExChangeRate {

    private final Logger log = LoggerFactory.getLogger(getClass());

    private JSONParser parser = new JSONParser();
    

    public void fetchExchangeRates() {

    	
    	String authKey = "529vWKcCEONgLITkHdADPErmmDp31wq8";
        String searchDate = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String dataType = "AP01";
        
        String URL = "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=" + authKey
                + "&searchdate=" + searchDate + "&data=" + dataType;
		
    	
    	// String URL = "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=529vWKcCEONgLITkHdADPErmmDp31wq8&searchdate=20240716&data=AP01";
    	
        try {
            disableSSLVerification(); // SSL 검증 비활성화
            String jsonResponse = getResponse(URL);
            if (jsonResponse != null) {
                JSONArray jsonArray = (JSONArray) parser.parse(jsonResponse);
                for (Object obj : jsonArray) {
                    JSONObject jsonObject = (JSONObject) obj;
                    log.warn("result>>" + jsonObject.get("result"));
                    log.warn("cur_unit>>" + (String) jsonObject.get("cur_unit"));
                    log.warn("cur_nm>>" + (String) jsonObject.get("cur_nm"));
                    log.warn("ttb>>" + (String) jsonObject.get("ttb"));
                    log.warn("tts>>" + (String) jsonObject.get("tts"));
                    log.warn("deal_bas_r>>" + (String) jsonObject.get("deal_bas_r"));
                    log.warn("bkpr>>" + (String) jsonObject.get("bkpr"));
                    log.warn("yy_efee_r>>" + (String) jsonObject.get("yy_efee_r"));
                    log.warn("ten_dd_efee_r>>" + (String) jsonObject.get("ten_dd_efee_r"));
                    log.warn("kftc_deal_bas_r>>" + (String) jsonObject.get("kftc_deal_bas_r"));
                    log.warn("kftc_bkpr>>" + (String) jsonObject.get("kftc_bkpr"));
                    log.warn("----------------------------------------");
                }
            }
        } catch (IOException e) {
            log.error("I/O error: " + URL, e);
        } catch (ParseException e) {
            log.error("Parsing error: " + URL, e);
        }
    }

    private String getResponse(String apiURL) throws IOException {
        URL url = new URL(apiURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setInstanceFollowRedirects(false);

        int status = conn.getResponseCode();
        if (status != HttpURLConnection.HTTP_OK) {
            if (status == HttpURLConnection.HTTP_MOVED_TEMP || status == HttpURLConnection.HTTP_MOVED_PERM ||
                status == HttpURLConnection.HTTP_SEE_OTHER) {
                String newUrl = conn.getHeaderField("Location");
                return getResponse(newUrl.startsWith("http") ? newUrl : url.getProtocol() + "://" + url.getHost() + newUrl);
            } else {
                throw new IOException("Server returned status: " + status);
            }
        }

        try (BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            return content.toString();
        }
    }

    private void disableSSLVerification() {
        try {
            TrustManager[] trustAllCerts = new TrustManager[]{
                new X509TrustManager() {
                    public X509Certificate[] getAcceptedIssuers() {
                        return null;
                    }
                    public void checkClientTrusted(X509Certificate[] certs, String authType) {
                    }
                    public void checkServerTrusted(X509Certificate[] certs, String authType) {
                    }
                }
            };

            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

            HostnameVerifier allHostsValid = new HostnameVerifier() {
                public boolean verify(String hostname, SSLSession session) {
                    return true;
                }
            };

            HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
        } catch (Exception e) {
            log.error("Failed to disable SSL verification", e);
        }
    }

}
