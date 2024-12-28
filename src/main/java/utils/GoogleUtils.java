package utils;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import org.apache.hc.client5.http.ClientProtocolException;
import org.apache.hc.client5.http.classic.methods.HttpGet;
import org.apache.hc.client5.http.classic.methods.HttpPost;
import org.apache.hc.client5.http.entity.UrlEncodedFormEntity;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.core5.http.message.BasicNameValuePair;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import dto.response.GooglePojo;

public class GoogleUtils {
    public static String getToken(final String code) throws ClientProtocolException, IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            HttpPost post = new HttpPost(Constants.GOOGLE_LINK_GET_TOKEN);
            
            // Thêm các tham số POST
            List<BasicNameValuePair> params = new ArrayList<>();
            params.add(new BasicNameValuePair("client_id", Constants.GOOGLE_CLIENT_ID));
            params.add(new BasicNameValuePair("client_secret", Constants.GOOGLE_CLIENT_SECRET));
            params.add(new BasicNameValuePair("redirect_uri", Constants.GOOGLE_REDIRECT_URI));
            params.add(new BasicNameValuePair("code", code));
            params.add(new BasicNameValuePair("grant_type", Constants.GOOGLE_GRANT_TYPE));
            
            post.setEntity(new UrlEncodedFormEntity(params));

            // Gửi yêu cầu và nhận phản hồi
            try (CloseableHttpResponse response = client.execute(post)) {
                String responseBody = new String(response.getEntity().getContent().readAllBytes());
                JsonObject jobj = new Gson().fromJson(responseBody, JsonObject.class);
                String accessToken = jobj.get("access_token").getAsString();
                return accessToken;
            }
        }
    }

    public static GooglePojo getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        try (CloseableHttpClient client = HttpClients.createDefault()) {
            String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
            HttpGet get = new HttpGet(link);
            
            try (CloseableHttpResponse response = client.execute(get)) {
                String responseBody = new String(response.getEntity().getContent().readAllBytes(), StandardCharsets.UTF_8);
                GooglePojo googlePojo = new Gson().fromJson(responseBody, GooglePojo.class);
                return googlePojo;
            }
        }
    }
}
