package Test.TimeLine;
import java.util.Date;
import java.util.Vector;
import twitter4j.DirectMessage;
import twitter4j.User;

/*각 user의 메시지를 분류하여 보관하는데 사용할 클래스 
 * generic을 사용하여 Vector를 선언할 때 DirectMessage형으로 사용한다. */
public class EachMessageInfo
{	
//	private String screen_name;
	private User sender;
	private Vector<DirectMessage> message_list;
	
	public EachMessageInfo(User sender)
	{
	//	this.screen_name = null;
		this.sender = sender;
		this.message_list = new Vector<DirectMessage>();
	}
/*	
	public void setScreenName(String screen_name)
	{
		this.screen_name = screen_name;
	}
*/
	public void addMessage(String kind,  DirectMessage dm )
	{	/*MessageList에서 사용될 함수로 sender별로 recipient별로 분류하여 Message를 추가하기 위*/
		//this.message_list.add( dm );
		if( kind.equals("get"))
		{
			this.message_list.add(dm);
	//		System.out.println("-----------------------------------------------------------------------------------------------------------------");
	//		System.out.println("[EachMessageInfo] addMessage: add getMessage");
	//		System.out.println("[EachMessageInfo] addMessage: "+dm.getText());
	//		System.out.println("-----------------------------------------------------------------------------------------------------------------");
		}
		else
		{
			int size = this.getSize();
			for( int index=0; index<size; index++ )
			{
				DirectMessage message = this.message_list.elementAt(index);
		//		System.out.println("[EachMessageInfo] addMessage index:"+index);
				if( dm.getCreatedAt().compareTo( message.getCreatedAt() ) > 0 )	//dm이 작성된 때(date)가 message가 작성된 때(date)를 앞선다.
				{
					//message_list는 가장 최근에 쓴 message부터 차례로 정렬되어있다. 
					//그러니 비교하여 매개변수로 넘어온 dm이 더 최근에 쓰여진 것이라면 해당 인덱스에 추가한다.
					this.message_list.add(index, dm);
			//		System.out.println("-----------------------------------------------------------------------------------------------------------------");
			//		System.out.println("[EachMessageInfo] addMessage: greater ");
			//		System.out.println("[EachMessageInfo] addMessage: index: "+index);
			//		System.out.println("[EachMessageInfo] addMessage: date: "+dm.getCreatedAt());
			//		System.out.println("[EachMessageInfo] addMessage: text: "+dm.getText());
			//		System.out.println("-----------------------------------------------------------------------------------------------------------------");
					
					break;
				}else if( dm.getCreatedAt().compareTo( message.getCreatedAt() ) == 0 )
				{
					this.message_list.add(index+1, dm);
			//		System.out.println("-----------------------------------------------------------------------------------------------------------------");
			//		System.out.println("[EachMessageInfo] addMessage : equal");
			//		System.out.println("[EachMessageInfo] addMessage: index: "+index);
			//		System.out.println("[EachMessageInfo] addMessage: date: "+dm.getCreatedAt());
			//		System.out.println("[EachMessageInfo] addMessage: text: "+dm.getText());
			//		System.out.println("-----------------------------------------------------------------------------------------------------------------");
					
					break;
				}else
				{
			//		System.out.println("[EachMessageInfo] addMessage : lower");
					if( index == this.getSize()-1 )
					{
						this.message_list.add(dm);
			//			System.out.println("-----------------------------------------------------------------------------------------------------------------");
			//			System.out.println("[EachMessageInfo] addMessage : lower and last");
			//			System.out.println("[EachMessageInfo] addMessage: index: "+index);
			//			System.out.println("[EachMessageInfo] addMessage: date: "+dm.getCreatedAt());
			//			System.out.println("[EachMessageInfo] addMessage: text: "+dm.getText());
			//			System.out.println("-----------------------------------------------------------------------------------------------------------------");
					}
					
				}
		//		System.out.println("[EachMessageInfo] addMessage last index:"+index);
			}
			
		}
	}
	
	public int getMessageSize()
	{
		if( message_list.isEmpty() )
		{
			System.out.println("[EachMessageInfo] getMessageSize : empty");
		}
		
		return this.message_list.size();
	}	
	
	public String getName()
	{
		return sender.getScreenName();
	}
	
	public User getSender()
	{
		return sender;
	}
	
	public Date getDate(int index)
	{
		return message_list.elementAt(index).getCreatedAt();
	}
	
	public int getSize()
	{
		return this.message_list.size();
	}
	
	public DirectMessage getMessage(int index)
	{
		return this.message_list.elementAt(index);
	}
	
	/*메시지 목록을 리턴함*/
	public Vector<DirectMessage> getMessageList()	
	{
		return this.message_list;
	}
}

