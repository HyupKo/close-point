package Test.TimeLine;

import java.util.Date;
import java.util.List;
import java.util.Vector;

import twitter4j.DirectMessage;
import twitter4j.Twitter;
import twitter4j.TwitterException;


public class MessageList {
	
	Twitter twitter;
	public List<DirectMessage> get_list;
	List<DirectMessage> sent_list;
	Vector<EachMessageInfo> vec; 
	
	public MessageList(Twitter twitter) throws Exception 
	{
		this.twitter = twitter;
		get_list = twitter.getDirectMessages();
		sent_list = twitter.getSentDirectMessages();
		vec = new Vector<EachMessageInfo>();
		
		if( !get_list.isEmpty() )
			this.groupingGetMessages();
		
		if( !sent_list.isEmpty() )
			this.groupingSentMessages();	//아직 내용 없음
	}
	
	public void groupingGetMessages()
	{
		int index=0;		//get_list의 각 sender별로 분류하여 그 index와 date를 EachMessageInfo형인 vector에 저장
	
		for( DirectMessage dm : get_list )
		{
			String sender_name = dm.getSender().getScreenName();
			Date date = dm.getSender().getCreatedAt();
			System.out.println("[MessageList] grouping: "+sender_name);  //test print
			System.out.println("[MessageList] grouping (date): "+date);  //test print
			System.out.println("[MessageList] grouping (text): "+dm.getText());  //test print

			if( !this.isContains(sender_name) )
			{
				//vec에 sender의 이름(sender_name)이 없으면 그 sender에 대한 값을 저장하기 위해 vec에 기본정보(sender_name)을 추가한다.
				EachMessageInfo info = new EachMessageInfo();
				info.setScreenName(sender_name);
				this.vec.add(info);	//sender_name으로 vec에 기본정보 추가
				System.out.println("[MessageList] grouping: not Contains!!");				
			//	System.out.println("vec : "+vec.elementAt(0).getName());
			}
			
			returnValues vec_index = this.indexOf(sender_name);  //vec의 인덱스 = sender가 보낸 메시지를 저장하는 위치
			
			//사실 필요없는 조건문임...생성자에서 get_list가 비었는지 확인한 뒤 정렬하기 호출하는 함수이므로 결과가 없을 리가 없다.
			if( !vec_index.getResult().isEmpty() )	
				this.addElement(vec_index.getIndex(), index, date);
		
			System.out.println("---------result------------------------------------");
			EachMessageInfo info = vec.elementAt(vec_index.getIndex());
			System.out.println("vec "+vec_index.getIndex());
			System.out.println("<info>screen_name: "+info.getName());
	    	System.out.println("<info>getMessageSize: "+info.getMessageSize());
	    	System.out.println("<info>message_list.elementAt: "+info.message_list.elementAt(0));
	    	System.out.println("---------------------------------------------------------");
			index++;
		}		
	}
	
	public void groupingSentMessages()
	{
		
	}
	
	public boolean isContains(String screen_name)
	{
		boolean result=false;
		
		if( !vec.isEmpty() )
		{
			int index=0;
			while(index<vec.size())
			{
				EachMessageInfo info = vec.elementAt(index);
				if( screen_name.equals( info.getName() ) )
				{
					result=true;
					break;
				}
				index++;
			}
			return result;
				
		}else
		{
			System.out.println("[MessageList] vec is empty"); //test print
			return result;
		}
	}
	
	public returnValues indexOf(String screen_name)
	{
		returnValues values=new returnValues();
		int index = 0;
		String result = null;			//return값으로 index와 String을 넘겨 값이 존재하지 않을 때 즉, index=0을 읽지 않도록 result를 0으로 한다. 
		
		while( index<vec.size() )
		{
			EachMessageInfo info = vec.elementAt(index);
			if( screen_name.equals( info.getName() ) )
			{
				result="not null";
				break;
			}else
				index++;
		}
		values.setResult(result, index);
		return values;
	}
	
	public void addElement(int vec_index, int index, Date date)
	{
		System.out.println("addElement!!");
		vec.elementAt(vec_index).addMessageIndex(index, date);
		System.out.println("[MessageList] vec_index: "+vec_index); //test print
		
		EachMessageInfo info = vec.elementAt(vec_index);
		System.out.println("[MessageList] name"+info.getName()); 		//test print
		int last_index = info.getMessageSize()-1 ;
		System.out.println("[MessageList] last value"+info.getBasic( last_index )); 		//test print
		
	}
	
	public int listSize()
	{
		System.out.println("vec size : "+vec.size()); //test print
		return vec.size();
	}
	
	public EachMessageInfo elementAt(int index)
	{
		return vec.elementAt(index);
	}

	public DirectMessage getElement(String str, int index)
	{
		if( str.equals("get") )
		{
			System.out.println("request get_list ");
			return this.get_list.get(index);
		}else
		{
			System.out.println("request sent_list ");
			return this.sent_list.get(index);
		}
	}

}

class returnValues
{
	private String result;
	private int index;
	
	public returnValues()
	{
		result = null;
		index = 0;
	}
	
	public void setResult(String result, int index)
	{
		this.result = result;
		this.index = index;
	}
	
	public String getResult()
	{
		return result;
	}
	
	public int getIndex()
	{
		return index;
	}

}