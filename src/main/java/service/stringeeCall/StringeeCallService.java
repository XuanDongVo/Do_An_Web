package service.stringeeCall;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Random;

import org.apache.hc.client5.http.classic.methods.HttpPost;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.core5.http.ParseException;
import org.apache.hc.core5.http.io.entity.EntityUtils;
import org.apache.hc.core5.http.io.entity.StringEntity;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/sendOtp")
public class StringeeCallService extends HttpServlet {
    private static final String API_KEY_SID = "SK.0.paBFPG4wGIUyXwjnoXEX3X276JL55Da";
    private static final String API_KEY_SECRET = "aGZuQnNPOVF6NlNEenpJWjBYQ01yMHV0NHVMZVNFeA==";
    private static final String API_URL = "https://api.stringee.com/v1/call2/callout";
    private static final String PHONE_NUMBER = "842871066445"; // Số điện thoại đã đăng ký

    // Hàm tạo JWT token
    private static String getAccessToken() {
        long nowMillis = System.currentTimeMillis();
        long expMillis = nowMillis + 3600 * 1000; // Token hết hạn sau 1 giờ
        Algorithm algorithm = Algorithm.HMAC256(API_KEY_SECRET);
        return JWT.create().withIssuer(API_KEY_SID).withIssuedAt(new Date(nowMillis)).withExpiresAt(new Date(expMillis))
                .withClaim("rest_api", true).withClaim("only_view", false).sign(algorithm);
    }

    // Hàm gọi điện
    public static void makeCall(String toNumber, String otp) throws ParseException {
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost httpPost = new HttpPost(API_URL);
            httpPost.setHeader("X-STRINGEE-AUTH", getAccessToken());
            httpPost.setHeader("Content-Type", "application/json");
            httpPost.setHeader("Accept", "application/json");

            // Thiết lập body JSON với OTP
            String jsonBody = String.format(
                    "{\"from\":{\"type\":\"external\",\"number\":\"%s\",\"alias\":\"%s\"},"
                            + "\"to\":[{\"type\":\"external\",\"number\":\"%s\",\"alias\":\"%s\"}],"
                            + "\"actions\":[{\"action\":\"talk\","
                            + "\"text\":\" Mã OTP của bạn là %s .\","
                            + "\"voice\":\"hn_male_xuantin_vdts_48k-hsmm\",\"bargeIn\":true,\"loop\":5}]}",
                    PHONE_NUMBER, PHONE_NUMBER, toNumber, toNumber, otp);

            StringEntity entity = new StringEntity(jsonBody, StandardCharsets.UTF_8);
            httpPost.setEntity(entity);

            // Gửi request
            try (CloseableHttpResponse response = httpClient.execute(httpPost)) {
                System.out.println("STATUS: " + response.getCode());
                String responseBody = EntityUtils.toString(response.getEntity(), StandardCharsets.UTF_8);
                System.out.println("BODY: " + responseBody);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

	    // Hàm tạo mã OTP ngẫu nhiên
	    public static String generateRandomOtp() {
	        Random random = new Random();
	        StringBuilder otp = new StringBuilder();
	        for (int i = 0; i < 4; i++) {
	            otp.append(random.nextInt(10)); // Tạo số từ 0 đến 9
	        }
	        return convertOtpToWords(otp.toString());
	    }
	
	    // Hàm chuyển đổi OTP thành dạng đọc từng số
	    private static String convertOtpToWords(String otp) {
	        StringBuilder sb = new StringBuilder();
	        for (char c : otp.toCharArray()) {
	            switch (c) {
	                case '0':
	                    sb.append("không ");
	                    break;
	                case '1':
	                    sb.append("một ");
	                    break;
	                case '2':
	                    sb.append("hai ");
	                    break;
	                case '3':
	                    sb.append("ba ");
	                    break;
	                case '4':
	                    sb.append("bốn ");
	                    break;
	                case '5':
	                    sb.append("năm ");
	                    break;
	                case '6':
	                    sb.append("sáu ");
	                    break;
	                case '7':
	                    sb.append("bảy ");
	                    break;
	                case '8':
	                    sb.append("tám ");
	                    break;
	                case '9':
	                    sb.append("chín ");
	                    break;
	            }
	        }
	        return sb.toString().trim();
	    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    // Xử lý POST request từ form gửi OTP
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String phoneNumber = request.getParameter("phoneNumber");

        try {
            // Tạo OTP
            String otp = generateRandomOtp();
            
            // Gửi OTP qua Stringee
            makeCall(phoneNumber, otp);
            System.out.println(otp);
            response.getWriter().write("OTP sent successfully: " + otp);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error sending OTP: " + e.getMessage());
        }
    }
}
