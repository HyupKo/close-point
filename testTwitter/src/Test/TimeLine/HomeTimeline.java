package Test.TimeLine;

import java.util.List;

import twitter4j.Paging;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;

public class HomeTimeline
{
	private int home_page_num;
	private String screen_name;
	private Twitter twitter;
	private Paging page_home;		//page of homeTimeLine
	public int[] home_scroll;	
	
	public HomeTimeline(Twitter twitter)
	{
		System.out.println("------[init] start---------------------");
		this.twitter = twitter;
		screen_name = this.getScreenName();		
		this.home_page_num= 0;
		this.page_home = new Paging();
		this.home_scroll = new int[2];

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
	
	private int getPageNum()
	{
		return this.home_page_num;
	}
	
	private void setPageNum(int num)
	{
		this.home_page_num = num;
		System.out.println("[setPageNum] home_page_num: "+this.home_page_num);
	}
	
		
	/*Paging��page_home怨�page_user 媛믪쓣 蹂�꼍*/
	private void setPage(int page)
	{
		this.page_home.setPage(page);
	}
	
	private List<Status> getHome()			//changed
	{
		try
		{
			int num=1;
			List<Status> list;
			
			this.setPage(num);
			list = twitter.getHomeTimeline(this.page_home); 
			System.out.println("[1]page: "+num);	//test
		
			if( list.size()!=0 )			
			{					
				while( num < this.home_page_num )
				{
					num+=1;							
					System.out.println("[2]page: "+num);	//test
					this.setPage(num );
					list.addAll( twitter.getHomeTimeline(this.page_home) );
				}
					
				while( list.size() < 10 )
				{											
					num+=1;
					System.out.println("[3]page: "+num);	//test
					this.setPage( num );
					list.addAll( twitter.getHomeTimeline(this.page_home) );	
				}
				
				this.setPageNum(num);
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
	
	public void setPublicPage(String kind, int page)
	{
		if( kind.equals("home") )
			this.setPageNum(page);
	}
	
	public int getPublicPage(String kind)
	{
		if( kind.equals("home") )
			return this.getPageNum();
		else
			return 0;
	}
		
	public void setPublicScroll(int x, int y)
	{
		this.home_scroll[0] = x;
		this.home_scroll[1] = y;
	}

/*필요없음
	public void setPublicNext(boolean result)
	{
		if( result )
			this.callHomeNextPage = true;
		
		System.out.println("isNext?  "+callHomeNextPage);
	}
*/
	/* 필요없어 졌음
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
	*/
	/*
	public int[] getPublicScroll()
	{
		return  this.home_scroll;
	}
*/	
	/*泥섏쓬 ��엫�쇱씤��異쒕젰����*/
	public List<Status> HomeTimeLine()	
	{
		return this.getHome(); 		//changed
	}
	
	
	
}