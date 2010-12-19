package Test.TimeLine;

import twitter4j.Twitter;
import twitter4j.TwitterException;

public class UpdateStatus {

	private String status;
	private Twitter twitter;
	
	public UpdateStatus()
	{
		status = "";
		twitter = null;
	}
	
	public String getStatus()
	{
		return this.status;
	}
	
	public void setStatus(String status_value)
	{
		this.status = status_value;
		UpdateTwit();
	}
	
	public void setTwitterInstance(Twitter twit)
	{
		this.twitter = twit;
	}
	
	private void UpdateTwit()
	{
		try {
			twitter.updateStatus(status);
		} catch (TwitterException e) {
			e.printStackTrace();
		}
	}
}
