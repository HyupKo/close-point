package Test.TimeLine;

import java.util.List;

import twitter4j.IDs;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.User;

public class followerList {

	private Twitter twitter;
	private List<User> followers = null;
	private List<User> friends = null;
	
	public followerList(Twitter twitter)
	{
		try
		{
			this.twitter = twitter;
			this.followers = twitter.getFollowersStatuses();
			this.friends = twitter.getFriendsStatuses();
//			this.setFollowerList();
//			this.setFriendList();
		}catch(TwitterException twitException)
		{
			System.out.println("[followerList] init: TwitterException");
		}
	}
/*	
	사용자의 follower들의 list를 얻기위한 private함수로 생성자에서 호출하는 함수이다.
	private void setFollowerList()
	{
		try {
		//		IDs followerIDs = twitter.getFollowersIDs();		//follower들의 아이디를 얻는다.
	//		int[] ids = followerIDs.getIDs();						//그 아이디를 배열로 반환하
	//		for(int index=0; index<ids.length; index++)
	//			followers.add( twitter.showUser( ids[index] ).getScreenName() );		//배열에 있는 아이디로 사용자정보를 얻어 ScreenName을 list에 추가한다.
		} catch (TwitterException e) {
			System.out.println("[followerList] setList: TwitterException발생");
		}

	}
	
	private void setFriendList()
	{
		try {
			IDs friendIDs = twitter.getFriendsIDs();
			int[] ids = friendIDs.getIDs();
			for(int index=0; index<ids.length; index++)
				friends.add( twitter.showUser(ids[index]).getScreenName() );
		} catch (TwitterException e) {
			System.out.println("[followerList] setFriendList: TwitterException 발생");
		}

	}
	*/
	
	/*외부에서 직접 접근할 수 없도록 private으로 선언하여 접근한다. 내부의 public함수에서 호출하여 사용한다.*/
	private List<User> getList(String kind)
	{
		if( kind.equals("friends"))
			return this.friends;
		else
			return this.followers;
	}
	
	public List<User> getPublicList(String kind)
	{
		return this.getList(kind);
	}
/* jsp에서 처리할거임..	
	private int getSize(String kind)
	{
		if( kind.equals("friends"))
			return this.friends.getItemCount();
		else
			return this.followers.getItemCount();
	}
		
	public int getPublicSize(String kind)
	{
			return this.getSize(kind);
	}
	*/
}
