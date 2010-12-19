package comm.util;

import java.util.HashMap;

public class HashMapTwit extends HashMap {
	public HashMapTwit()
	{
		
	}
	
	public Object put(Object key, Object value)
	{
		if(key != null)
			key.toString().toUpperCase();
		
		return super.put(key, value);
	}
}
