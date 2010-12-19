package comm.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

public class requestManager {
	
	public static HashMapTwit getRequest(HttpServletRequest request) throws UnsupportedEncodingException
	{
		HashMapTwit hm = new HashMapTwit();
		
		String key = "";
		String value = "";
		String arr_values[];
		
		ArrayList al_values = null;
		Enumeration e = request.getParameterNames();
		
		while(e.hasMoreElements())
		{
			key = (String)e.nextElement();
			arr_values = request.getParameterValues(key);
			
			if(arr_values != null && arr_values.length == 1)
			{
				value = arr_values[0];
				value = URLDecoder.decode(value, "UTF-8");
				hm.put(key.toUpperCase(), value);
			}
			else if(arr_values != null && arr_values.length > 1)
			{
				al_values = new ArrayList();
				
				for(int i=0 ; i<arr_values.length ; i++)
				{
					arr_values[i] = value = URLDecoder.decode(arr_values[i], "UTF-8");
					al_values.add(arr_values[i]);
				}
				hm.put(key.toUpperCase(), al_values);
			}
			else
				hm.put(key.toUpperCase(), null);
		}
		
		return hm;
	}
}
