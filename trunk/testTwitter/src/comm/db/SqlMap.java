package comm.db;

import java.io.IOException;
import java.io.Reader;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class SqlMap {
	public SqlMap()  {   }
	
	static SqlMapClient sqlMapper;
	
	public static SqlMapClient getInstance(){
		return sqlMapper;
	}
	
	static{
		String path = "/sqlMapConfig.xml";
		Reader reader = null;
		
		try
		{
			reader = Resources.getResourceAsReader(path);
		}catch(IOException e)
		{
			e.printStackTrace();
		}
		
		sqlMapper = SqlMapClientBuilder.buildSqlMapClient(reader);
	}
}
