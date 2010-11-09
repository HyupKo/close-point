package Test.TimeLine;

import java.util.List;

import twitter4j.Paging;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.User;

public class UserTimeline {
	private int user_page_num;
	private String screen_name;
	private Twitter twitter;
	private Paging page_user;		//page of myTimeLine
	public int[] user_scroll;	
	
	public UserTimeline( Twitter twitter )
	{
		this.twitter = twitter;
		this.screen_name = this.getScreenName();
		this.user_page_num = 0;
		this.page_user = new Paging();
		this.user_scroll = new int[2];
	}
	
	private String getScreenName()
	{
		try
		{
			return this.twitter.getScreenName();
		}catch( TwitterException twitException )
		{
			System.out.println("[User-getScreenName] TwitterException");
			return null;
		}
	}
	
	private String getName()
	{
		return this.screen_name;
	}
	
	private void setPageNum(int num)
	{
		this.user_page_num = num;
		System.out.println("[setPageNum] user_page_num: "+this.user_page_num);
	}
	
	private void setPage(int page)
	{
		this.page_user.setPage(page);
	}	
	
	private int getPageNum()
	{
		return this.user_page_num;
	}
	
	private List<Status> getUser()		//changed
	{
		try
		{
			int num=1;
			List<Status> list;
			
			this.setPage( num );
			list = twitter.getUserTimeline(page_user);
			System.out.println("[4]page: "+num);	//test
			System.out.println("list size : "+list.size());	//test
				
			if( list.size() != 0)
			{
				while( num < this.user_page_num )	
				{
					num+=1;
					System.out.println("[5]page: "+num);	//test
					this.setPage( num);
					list.addAll( twitter.getUserTimeline(page_user) );
				}
					
				while( list.size() < 10 )
				{
					num+=1;
					System.out.println("[6]page: "+num);	//test
					this.setPage(num);
					list.addAll(twitter.getUserTimeline(page_user) );
						
				}
				
				this.setPageNum(num);   
			}else
				System.out.println("no MyTimeLine");
			
			System.out.println("[getUser()] user_page_num : "+this.user_page_num);
			return list;
		}catch(TwitterException twitException)
		{
			System.out.println("[TimeLine] TwitterException");
			return null;		
		}catch(NullPointerException nullException)
		{
			System.out.println("[TimeLine] NullPointerException");
			return null;
		}
	}

	
	public List<Status> getMyTimeLine()
	{
		return this.getUser();	//changed
	}

	public void setPublicPage(int page)
	{
		this.setPageNum( page );
	}
	
	public int getPublicPage()
	{
		return this.getPageNum();
	}
	
	public String getPublicName()
	{
		return this.getName();
	}
	
	public void setPublicScroll(int scroll_x, int scroll_y)
	{
		this.user_scroll[0] = scroll_x;
		this.user_scroll[1] = scroll_y;
	}
	
	/*	
	public void setPublicScroll(int x, int y)
	{
		this.user_scroll[0] = x;
		this.user_scroll[1] = y;
	}
	*/
}
