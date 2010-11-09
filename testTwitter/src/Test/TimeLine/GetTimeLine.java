package Test.TimeLine;

import java.util.List;

import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;

public class GetTimeLine {
	private String userId;
	private String password;
	private Twitter tw;
	List<Status> lt;
	
	public GetTimeLine(String screenName, String password) 
	{
		this.userId = screenName;
		this.password = password;
		
		twitter();
	}
	
	private void twitter()
	{
		try{
			tw = new TwitterFactory().getInstance(userId, password);
		}catch(Exception e)
		{
			System.out.println("----------------------------------------getInstance에러남");
		}
	}
	
	public boolean equalUser(String userId)
	{
		if( userId.equals(this.userId) )
		{
			return true;
		}else
			return false;
	}
	
	public List<Status> getHomeTimeLine() //throws TwitterException
	{
	//	lt = tw.getHomeTimeline();
		try 											//exception발생시, jsp파일에서 해결하기 위함
		{
			lt = tw.getHomeTimeline();
		} catch (TwitterException e) 
		{
			System.out.println("--------------------1-----------------------");
			System.out.println("TwitterException : tw.getHomeTimeline()");
			System.out.println("---------------------------------------------");
			e.printStackTrace();
		}catch( NullPointerException e1)
		{
			System.out.println("--------------------1-------------------------");
			System.out.println("NullPointerException : tw.getHomeTimeline()");
			System.out.println("---------------------------------------------");
		}
		return this.lt;
	}
}
