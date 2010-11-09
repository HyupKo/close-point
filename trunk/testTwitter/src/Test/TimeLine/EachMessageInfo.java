package Test.TimeLine;
import java.util.Date;
import java.util.Vector;

/*각 user의 메시지를 분류하여 보관하는데 사용할 클래스 
 *  인덱스와 날짜를 가지는 클래스(BasicForm)를 Vector generic으로? 사용 */
public class EachMessageInfo
{	
	private String screen_name;	
	public Vector<BasicForm> message_list;
	
	public EachMessageInfo()
	{
		this.screen_name = null;
		this.message_list  = new Vector<BasicForm>();
	}
	
	public void setScreenName(String screen_name)
	{
		this.screen_name = screen_name;
	}
	
	public void addMessageIndex(int index, Date date)
	{	/*MessageList에서 사용될 함수
	  		실질적인 정보(List<DirectMessages>의 index와 date)를 저장*/
		BasicForm form = new BasicForm(index, date);
		this.message_list.add(form);
		System.out.println("[EachMessageInfo] index: "+form.list_index);
		System.out.println("[EachMessageInfo] date: "+date);
	}
	
	public int getMessageSize()
	{
		if( message_list.isEmpty() )
		{
			System.out.println("[EachMessageInfo] empty");
		}
	//	System.out.println("[EachMessageInfo] messageSize:"+message_list.size());
		
		return this.message_list.size();
	}	
	
	public String getName()
	{
		return screen_name;
	}
	
	public int getBasic(int index)
	{
		return message_list.elementAt(index).list_index;
	}
	
	public int getSize()
	{
		return this.message_list.size();
	}
}

