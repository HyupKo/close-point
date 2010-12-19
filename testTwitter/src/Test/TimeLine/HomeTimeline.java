package Test.TimeLine;

import java.util.List;

import twitter4j.Paging;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;

public class HomeTimeline
{
	private int home_page_num;
	private String screen_name;	//사용자 정
	private Twitter twitter;
	private Paging page_home;		//page of homeTimeLine
	public int[] home_scroll;			//페이지가 넘어가면 이전 위치에 스크롤을 위치하기 위함 
	
	public HomeTimeline(Twitter twitter)
	{
//		System.out.println("------[init] start---------------------");	//test
		this.twitter = twitter;
		screen_name = this.getScreenName();		
		this.home_page_num= 0;
		this.page_home = new Paging();
		this.home_scroll = new int[2];
//		System.out.println("------[init] end-------------------------");		//test
	}
	
	/*twitter객체의 함수를 사용하여 사용자의 screen name을 얻는 함수*/
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
	
	/*외부에서 변수에 직접 접근하는 것을 막기위한 용도로 생성된 함수로 home Timeline을 출력할 때
	 * 몇 페이지까지 출력해야하는지 알 수 있는 변수의 값을 얻는다. */
	private int getPageNum()
	{
		return this.home_page_num;
	}
	
	/*home timeline을 몇 페이지까지 출력할지 보여주는 변수 값을 변경한다*/
	private void setPageNum(int num)
	{
		this.home_page_num = num;
		System.out.println("[setPageNum] home_page_num: "+this.home_page_num);
	}
	
		
	/*timeline은 paging으로 페이지를 표시한다. Paging형 변수인 page_home을 int형 매개변수를 받아 값을 변경한다.
	private void setPage(int page)
	{
		this.page_home.setPage(page);
	}*/
	
	private List<Status> getHome()			
	{
		try
		{
			int num=1;
			List<Status> list;
			this.page_home.setPage(num);	//timeline을 얻어올 때 사용하는 Paging형 변수 page_home의 값을 변경시킨다.
			list = twitter.getHomeTimeline(this.page_home); 
			System.out.println("[1]page: "+num);	//test
		
			if( list.size()!=0 )			
			{					
				//home timeline을 출력한 뒤, 사용자가 다음 페이지까지 출력하기를 원할때 그 페이지가 home_page_num에 저장되있으며
				//그 페이지에 도달?할때까지 변수 num을 증가시키며 timeline을 얻는다.
				while( num < this.home_page_num )	
				{
					num+=1;							
					System.out.println("[2]page: "+num);	//test
					this.page_home.setPage(num);	//timeline을 얻어올 때 필요한 Paging형 변수의 값을 set		
					list.addAll( twitter.getHomeTimeline(this.page_home) );
				}
					
				while( list.size() < 10 )
				{											
					//timeline을 출력할 때 그 길이가 너무 짧지않도록, 출력되는 timeline의 길이가 10이상이도록 계속해서 페이지를 늘려가며
					//결과를 얻어온다.
					num+=1;
					System.out.println("[3]page: "+num);	//test
					this.page_home.setPage(num);	//다음 페이지까지 출력할 수 있게 Paging형 변수 page_home을 변경해줘야한다.
					List<Status> nextList = twitter.getHomeTimeline(page_home);
					
					if( !nextList.isEmpty() )
					{
					//	list.addAll( twitter.getHomeTimeline(this.page_home) );
						list.addAll(nextList);
					}else
					{
						System.out.print("list의 크기가 10이하이지만 더 이상 출력할 내용이 없다.");
						break;
					}
				}
				
				this.setPageNum(num);
			}else
				System.out.println("timeline is empty");
			
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
		
	/*private변수를 변경하는 private함수에 접근*/
	public void setPublicPage(String kind, int page)
	{
		if( kind.equals("home") )
			this.setPageNum(page);
	}
	
	/*private변수를 얻어 값을 반환해주는 private함수에 접근*/
	public int getPublicPage(String kind)
	{
		if( kind.equals("home") )
			return this.getPageNum();
		else
			return 0;
	}
	
	/*변수의 값을 변경하는 함수*/
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
	/*timeline의 정보를 갖는 인스턴스에 직접 접근하는 것을 막기위해 public함수에서 private함수로 접근한다.*/
	public List<Status> HomeTimeLine()	
	{
		return this.getHome(); 		//changed
	}
	
	
	
}