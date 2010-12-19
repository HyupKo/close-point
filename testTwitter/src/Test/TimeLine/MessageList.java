package Test.TimeLine;

import java.util.List;
import java.util.Vector;
import twitter4j.DirectMessage;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.User;



public class MessageList {
	Twitter twitter;
	public List<DirectMessage> get_list=null;
	List<DirectMessage> sent_list=null;
	Vector<EachMessageInfo> vec; 
	java.awt.List friends_list;
	
	public MessageList(Twitter twitter)
	{
		try
		{
			this.twitter = twitter;
			get_list = twitter.getDirectMessages();
			sent_list = twitter.getSentDirectMessages();
			friends_list = new java.awt.List();
		}catch(TwitterException twitException)
		{
			System.out.println("[MessageList] init: TwitterException");
		}catch(NullPointerException nullException)
		{
			System.out.println("[MessageList] init: NullPointerException");
		}
		vec = new Vector<EachMessageInfo>();	 
		this.getFriendsList();
		if( !get_list.isEmpty() )
			this.groupingGetMessages();	//get_list의 message들을 sender별로 분류 
		else
			System.out.println("[MessageList] init: get_list is empty!");
		
		if( !sent_list.isEmpty() )
			this.groupingSentMessages();		//sent_list의 message들을 recipient별로 분류하고 시간순서대로 vector에 끼워넣기 
		else
			System.out.println("[MessageList] init: sent_list is empty!");
	}
	
	private void getFriendsList()
	{
		try
		{
			List<User> list = twitter.getFriendsStatuses();
			for( int index=0; index<list.size(); index++)
				friends_list.add(list.get(index).getScreenName());	
		}catch(TwitterException twitException)
		{
			System.out.println("[MessageList] getFriendsLis: TwitterException");	//test
		}
	}
	
	/*user의 friend(user가 following하는 다른 user들)의 목록을 배열에 저장
	private void getFriendsList()
	{
		try 
		{
			
			IDs ids = twitter.getFriendsIDs();		//IDs형로 friend 아이디를 반환
			System.out.println("[MessageList] getFriendsList"+count++);	//test
			int[] friends_id = ids.getIDs();			//friend의 아이디를 배열현태로 반환하여 배열에 저장한다.
			
			for( int index=0; index<friends_id.length; index++)	//배열의 아이디로 User정보를 받아 List에 저장 
			{
				this.friends_list.add( twitter.showUser(friends_id[index]).getScreenName() );
				System.out.println("[MessageList] getFriendsList"+count++);	//test
			}
			
			
		} catch (TwitterException twitException) {
			System.out.println("[getFriedsList] TwitterException");
		}catch(NullPointerException e)
		{
			System.out.println("[getFriedsList] NullPointerException");
		}
	}
	*/
	private void groupingGetMessages()
	{
		int index=0;		//get_list의 각 sender별로 분류하여 그 index와 date를 EachMessageInfo형인 vector에 저장
	
		for( DirectMessage dm : get_list )
		{
			User sender = dm.getSender();
	//		System.out.println("-------------------------------------------------------------------------------");
	//		System.out.println("[MessageList] groupingGetMessages");
	//		System.out.println(dm.getSenderScreenName());
	//		System.out.println(dm.getText());
	//		System.out.println("-------------------------------------------------------------------------------");

			if( !this.isContains(sender.getScreenName()) )
			{
				//vec에 sender의 이름(sender_name)이 없으면 그 sender에 대한 값을 저장하기 위해 vec에 기본정보(sender_name)을 추가한다.
				EachMessageInfo info = new EachMessageInfo(sender);
				this.vec.add(info);	//sender_name으로 vec에 기본정보 추가
		//		System.out.println("[MessageList] grouping: not Contains!!");				
			//	System.out.println("vec : "+vec.elementAt(0).getName());
			}
			
			//최소한 sender가 보낸 메시지를 저장하는 장소(Vector)가 생성되었으니 그 정보의 인덱스만 필요함.
			int vec_index = this.indexOf(sender.getScreenName());  //vec의 인덱스 = sender가 보낸 메시지를 저장하는 위치
			this.addElement(vec_index, dm );
		
	//		System.out.println("---------result------------------------------------");
	//		EachMessageInfo info = vec.elementAt(vec_index.getIndex()); //test
	//		System.out.println("vec "+vec_index.getIndex());
	//		System.out.println("<info>screen_name: "+info.getName());
	   // 	System.out.println("<info>getMessageSize: "+info.getMessageSize());
	    //	System.out.println("<info>message_list.elementAt: "+info.message_list.elementAt(0));
	    //	System.out.println("---------------------------------------------------------");
			index++;
		}		
	}
	
	/*user가 보낸 message 목록을 recipient에 따라 분류하여 vec에 date를 비교하여 끼워넣기*/
	private void groupingSentMessages()
	{
		for( DirectMessage dm : this.sent_list )
		{
			User recipient = dm.getRecipient();
	//		System.out.println("-------------------------------------------------------------------------------");
	//		System.out.println("[MessageList] groupingSentMessages");
	//		System.out.println(dm.getRecipientScreenName());
	//		System.out.println(dm.getText());
	//		System.out.println("-------------------------------------------------------------------------------");
			
			if( !this.isContains(dm.getRecipientScreenName()) )
			{
				EachMessageInfo info = new EachMessageInfo(recipient);
				this.vec.add(info);	//recipient의 ScreenName으로 vec에 기본정보 추가
			}
			
			int vec_index = this.indexOf( dm.getRecipientScreenName() ); 	//recipient의 메시지를 저장하는 위치(인덱스)를 얻어 
			this.vec.elementAt(vec_index).addMessage("sent", dm);						//해당 위치에 저장
		}
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
			System.out.println("[MessageList] isContains : vec is empty"); //test print
			return result;
		}
	}
	
	/*해당 sender가 보낸 메시지를 저장할 위치가 생성된 후에(존재할 때) 이 함수를 호출하여 그 위치(인덱스)를 반환*/
	public int indexOf(String screen_name)
	{
		int index = 0;
	//	System.out.println("[MessageList] indexOf ");
		while( index<vec.size() )
		{
			EachMessageInfo info = vec.elementAt(index);
			if( screen_name.equals( info.getName() ) )
			{	//해당 sender를 찾았으니 while문을 빠져나가도록 한다.
				break;
			}else
				index++;	//해당 sender를 못찾았으니 다름 인덱스의 값을 확인할 수 있도록 증가.
		}
		
		return index;
	}
	
	//해당 인덱스(vect_index: 해당 sender 혹은 recipient의 메시지를 저장한 vec의 인덱)에 Message를 추가함
	public void addElement( int vec_index, DirectMessage dm)
	{
//		System.out.println("addElement!!");
		vec.elementAt(vec_index).addMessage("get", dm);
//		System.out.println("[MessageList] vec_index: "+vec_index); //test print
		
//		EachMessageInfo info = vec.elementAt(vec_index);	//test
//		System.out.println("[MessageList] name"+info.getName()); 		//test print
//		int last_index = info.getMessageSize()-1 ;		//test
//		System.out.println("[MessageList] last value"+info.getBasic( last_index )); 		//test print
		
	}
	
	public int listSize()
	{
//		System.out.println("vec size : "+vec.size()); //test print
		return vec.size();
	}
	
	public EachMessageInfo elementAt(int index)
	{
		return vec.elementAt(index);
	}
	
	public java.awt.List getFreinds()
	{
		return this.friends_list;
	}
}
