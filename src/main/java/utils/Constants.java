package utils;

public class Constants {
	 public static String GOOGLE_CLIENT_ID = "77255407167-1qjlv3iidhh0f7npo7i80hi6fst58t06.apps.googleusercontent.com";
	  public static String GOOGLE_CLIENT_SECRET = "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";
	  public static String GOOGLE_REDIRECT_URI = "http://localhost:8080/Ecommerce_Web/login-google";
	  public static String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
	  public static String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
	  public static String GOOGLE_GRANT_TYPE = "authorization_code";
	  public String URL_GOOGLE = "https://accounts.google.com/o/oauth2/auth?scope=profile&redirect_uri=http://localhost:8080/Ecommerce_Web/login-google&response_type=code\r\n"
	  		+ "&client_id=77255407167-1qjlv3iidhh0f7npo7i80hi6fst58t06.apps.googleusercontent.com&approval_prompt=force";
}
	