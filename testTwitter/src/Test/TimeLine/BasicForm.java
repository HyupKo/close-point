package Test.TimeLine;

import java.util.Date;

public class BasicForm
{
	int list_index;
	Date date;
	
	public BasicForm(int index, Date date)
	{
		list_index=index;
		date = date;
	}
	
	private int getIndex()
	{
		return list_index;
	}
	
	public int getPublicIndex()
	{
		return this.getIndex();
	}
}