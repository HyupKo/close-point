package dbconncet;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;
import comm.db.SqlMap;

public class dbtest {
	public dbtest() {   }
	
	private SqlMapClient sqlMapper = SqlMap.getInstance();
	
	public String testdbconnect()
	{
		String result = "";
		
		try
		{
			String resultQuery = sqlMapper.queryForObject("dbtest.testdbconnection").toString();
			if(resultQuery.equals("1"))
			{
				result = "Success to connect";
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			result = "fail to connect..... try again";
		}
		
		return result;
	}
	
	
}
