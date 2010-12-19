package Test.TimeLine;

import java.util.List;

import twitter4j.Paging;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;

public class RetweetMention {
	private Twitter twitter;
	private List<Status> statusList;
	private int retweet_page;
	private Paging page;
	
	public RetweetMention(Twitter twitter, String kind)
	{
		try
		{
			this.twitter = twitter;
			retweet_page =1;
			if( kind.equals("retweet") )
				statusList = this.getRetweets();
			else
				statusList = this.getMentions();
				
		}catch(TwitterException twitException)
		{
			System.out.println("[RetweetMention] init : TwitterException 발생 ");
		}
		
		
	}
	
	private List<Status> getRetweets() throws TwitterException
	{
		int num = 1;
		List<Status> list;
		page.setPage(num);
		list = twitter.getRetweetedByMe();
		
		if( !list.isEmpty())
		{
			while( num<retweet_page )
			{
				num++;
				page.setPage(num);
				list.addAll( twitter.getRetweetedByMe(page) );
				
				while( list.size()<10 )
				{
					num++;
					page.setPage(num);
					List<Status> nextList = twitter.getRetweetedByMe(page);
					if( nextList.isEmpty() )
						break;
					else
						list.addAll( nextList );
				}
			}
		}
		return list;
	}
	
	private List<Status> getMentions() throws TwitterException
	{
		int num = 1;
		List<Status> list;
		page.setPage(num);
		list = twitter.getMentions();
		
		if( !list.isEmpty())
		{
			while( num<retweet_page )
			{
				num++;
				page.setPage(num);
				list.addAll( twitter.getMentions(page) );
				
				while( list.size()<10 )
				{
					num++;
					page.setPage(num);
					List<Status> nextList = twitter.getMentions(page);
					if( nextList.isEmpty() )
						break;
					else
						list.addAll( nextList );
				}
			}
		}
		return list;
	}
	
	public List<Status> getResult()
	{
		return this.statusList;
	}
	/*
	private int getPageNum()
	{
		return this.
	}
	
	
	private void setPageNum(int num)
	{
		this.home_page_num = num;
		System.out.println("[setPageNum] home_page_num: "+this.home_page_num);
	}
	*/
}
