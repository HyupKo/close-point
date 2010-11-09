package Twitter;
import twitter4j.Twitter;


public class javaBeanTest {
	private String UserId=null;				//twitter에서 사용하는 ScreenName=닉네임?
	private String Password=null;					//password는 숫자와 영문자의 조합
	Twitter twitter;
	
	public String getScreenName() {
		return UserId;
	}
	public void setScreenName(String screenName) {
		UserId = UserId;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	
	

	
}
