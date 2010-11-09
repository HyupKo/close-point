package Test.TimeLine;

import java.util.List;

import twitter4j.Paging;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;

public class timeLine
{
	private int home_page_num;
	private int user_page_num;
	private String screen_name;
	private Twitter twitter;
	private Paging page_home;		//page of homeTimeLine
	private Paging page_user;		//page of myTimeLine
	public int[] home_scroll;	
	boolean callHomeNextPage;
	
	public timeLine(Twitter twitter)
	{
		System.out.println("------[init] start---------------------");
		this.twitter = twitter;
		screen_name = this.getScreenName();		
		this.home_page_num= 0;
		this.user_page_num = 0;
		this.page_home = new Paging();
		this.page_user = new Paging();
		this.home_scroll = new int[2];
		this.callHomeNextPage = false;

		System.out.println("------[init] end-------------------------");
	}
	
	private String getScreenName()
	{
		try
		{
			return twitter.getScreenName();
		}catch(TwitterException twitException)
		{
			return null;
		}
	}
	
	private int getPageNum( String kind )
	{
		if( kind.equals("home") )
			return this.home_page_num;
		else if( kind.equals("user") )
			return this.user_page_num;
		else
			return 0;			//誘몄��섏엫
	}
	
	private void setPageNum( String kind, int num )
	{
		if( kind.equals("home") )
		{
			this.home_page_num = num;
			System.out.println("[setPageNum] home_page_num: "+this.home_page_num);
		}
		else if( kind.equals("user") )
		{
			this.user_page_num = num;
			System.out.println("[setPageNum] user_page_num: "+this.user_page_num);
		}
		else
			System.out.println("[setPageNum] kind error");
	}
	
		
	/*Paging��page_home怨�page_user 媛믪쓣 蹂�꼍*/
	private void setPage(String kind, int page)
	{
		if( kind.equals("home") )
			this.page_home.setPage(page);
		else if(kind.equals("user") )
			this.page_user.setPage(page);
		else
			System.out.println("[setPage] kind error");
	}
	
	private List<Status> getHome()			//changed
	{
		try
		{
			int num=1;
			List<Status> list;
			
			this.setPage("home", num);
			list = twitter.getHomeTimeline(this.page_home); 
			System.out.println("[1]page: "+num);	//test
		
			if( list.size()!=0 )			
			{					
				while( num < this.home_page_num )
				{
					num+=1;							
					System.out.println("[2]page: "+num);	//test
					this.setPage("home", num);
					list.addAll( twitter.getHomeTimeline(this.page_home) );
				}
					
				while( list.size() < 10 )
				{											
					num+=1;
					System.out.println("[3]page: "+num);	//test
					this.setPage("home", num);
					list.addAll( twitter.getHomeTimeline(this.page_home) );	
				}
				
				this.setPageNum("home", num);
			}else
				System.out.println("no MyTimeLine");
			
			System.out.println("home_page_num: "+this.home_page_num);	//test
			return list;
			
		}catch(TwitterException twitException)
		{
			System.out.println("[getHome()] TwitterException");
			return null;
		}catch(NullPointerException nullException)
		{
			System.out.println("[getHome()] NullPointerException");
			return null;
		}
		
	}
	
	private List<Status> getUser()		//changed
	{
		try
		{
			int num=1;
			List<Status> list;
			
			this.setPage("user", num);
			list = twitter.getUserTimeline(page_user);
			System.out.println("[4]page: "+num);	//test
				
			if( list.size() != 0)
			{
				while( num < this.user_page_num )	
				{
					num+=1;
					System.out.println("[5]page: "+num);	//test
					this.setPage("user", num);
					list.addAll( twitter.getUserTimeline(page_user) );
				}
					
				while( num < 10 )
				{
					num+=1;
					System.out.println("[6]page: "+num);	//test
					this.setPage("user", num);
					list.addAll(twitter.getUserTimeline(page_user) );
						
				}
				
				this.setPageNum( "user", num);   
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
	
	public void setPublicPage(String kind, int page)
	{
		this.setPageNum(kind, page);
	}
	
	public int getPublicPage(String kind)
	{
		return this.getPageNum(kind);
	}
		
	public void setPublicScroll(int x, int y)
	{
		this.home_scroll[0] = x;
		this.home_scroll[1] = y;
	}
	
	public void setPublicNext(boolean result)
	{
		if( result )
			this.callHomeNextPage = true;
		
		System.out.println("isNext?  "+callHomeNextPage);
	}
	
	public int getPublicNext()
	{
		System.out.println("여기 들어오긴 함?");
		if( this.callHomeNextPage )
		{
			System.out.println("[timeline] true");
			return 1;
		}
		else
		{
			System.out.println("[timeline] false");
			return 0;
		}
	}
	
	public int[] getPublicScroll()
	{
		return  this.home_scroll;
	}
	
	/*泥섏쓬 ��엫�쇱씤��異쒕젰����*/
	public List<Status> HomeTimeLine()	
	{
		return this.getHome(); 		//changed
	}
	
	
	
}