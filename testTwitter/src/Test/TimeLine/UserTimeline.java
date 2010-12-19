package Test.TimeLine;

import java.util.List;

import twitter4j.Paging;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;

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
	/*twitter객체로부터 사용자의 screen name을 얻는 함수*/
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
	/*
	private void setPage(int page)
	{
		this.page_user.setPage(page);
	}	*/
	
	private int getPageNum()
	{
		return this.user_page_num;
	}
	
	private List<Status> getUser()		
	{
		try
		{
			int num=1;
			List<Status> list;
			
			this.page_user.setPage(num);		//user timeline을 출력할 때 필요한 Paging형 변수 page_user의 값을 변경한다. 
			list = twitter.getUserTimeline(page_user);
			System.out.println("[4]page: "+num);	//test
			System.out.println("list size : "+list.size());	//test
				
			if( list.size() != 0)	//첫 페이지의 결과가 0이면 사용자가 쓴 글 즉, user timeline이 없는 것이다. 
			{
				//사용자가 출력된 user timeline외에 다음 페이지를 출력하기를 원할 때의 페이지가 user_page_num이므로
				//user_page_num까지 변수 num을 증가시키며 user timeline을 얻어온다.
				while( num < this.user_page_num )	
				{
					num+=1;
					System.out.println("[5]page: "+num);	//test
					this.page_user.setPage(num);		//다음 페이지를 출력하기 위해 필요한 Paging형 변수 page_user를 변경한다.
					list.addAll( twitter.getUserTimeline(page_user) );
				}
				//timeline의 결과가 10개 이상이 되도록 페이지를 늘려가며 timeline을 얻어오고 그 결과가 10개 이상인지 확인한다.
				while( list.size() < 10 )
				{
					num+=1;
					System.out.println("[6]page: "+num);	//test
					this.page_user.setPage(num);		//다음 페이지를 출력하기 위해 필요한 Paging형 변수 page_user를 변경한다.
					List<Status> nextList = twitter.getUserTimeline(page_user);
					if( !nextList.isEmpty() )
						list.addAll( nextList );
					else
					{
						System.out.print("list의 크기가 10이하이지만 더 이상 출력할 내용이 없다.");
						break;
					}
				}
				
				this.setPageNum(num);   
			}else
				System.out.println("UserTimeline empty");
			
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
		return this.getUser();
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
