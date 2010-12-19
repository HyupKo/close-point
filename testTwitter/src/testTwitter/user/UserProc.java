package testTwitter.user;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.ibatis.sqlmap.client.SqlMapClient;
import comm.db.SqlMap;
import comm.util.HashMapTwit;
import comm.util.requestManager;

public class UserProc {
	private SqlMapClient sqlMapper;
	public UserProc()
	{
		sqlMapper = SqlMap.getInstance();
	}
	
	public String regist_user(HashMap hm)
	{
		String result = "";
		try
		{
			String passwd = md5(hm.get("USER_PASSWORD").toString());
			hm.remove("USER_PASSWORD");
			hm.put("USER_PASSWORD", passwd);
			sqlMapper.insert("users.insert_user", hm);							//  INSERT 문을 삽입하는 곳..
			result = "SUCCESS";
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		if(result.equals(""))
			result = "FAIL TO REGIST";
		return result;
	}
	
	public String checkUserStatusInfo(HttpServletRequest request) throws UnsupportedEncodingException
	{
		HashMapTwit hm = requestManager.getRequest(request);
		
		if(!hm.containsKey("USER_EMAIL") && hm.containsKey("USER_PASSWORD") && 
				hm.containsKey("USER_NAME") && hm.containsKey("USER_TWITTER_ID"))
		{
			return "INPUT ERROR";
		}
		
		if(hm.get("USER_EMAIL").toString().length()<1){
			return "EMAIL LENGTH ERROR";
		}
		/*
		if(!hm.get("USER_PASSWORD").toString().equals(hm.get("USER_PASSWORDC").toString())){
			return "PASSWORD ERROR";
		}*/
		if(hm.get("USER_PASSWORD").toString().length()<1){
			return "PASSWORD LENGTH ERROR";
		}
		if(hm.get("USER_TWITTER_ID").toString().length()<1){
			return "TWITTER ID LENGTH ERROR";
		}
		if(!isValidEmail(hm.get("USER_EMAIL").toString())){
			return "USER EMAIL VALIED ERROR";
		}
		return "SUCCESS";		
	}
	
	
	/*
	 * 	입력된 메일 주소의 형식을 검사하는 함수.
	 * */
	public boolean isValidEmail(String str) {	//STATIC이었음!
		boolean result = false;
		String regex = "^[_a-z0-9-]+(.[_a-z0-9-]+)*@(?:\\w+\\.)+\\w+$";

	    Pattern p = Pattern.compile(regex);
	    Matcher m = p.matcher(str);
	    if( m.matches() ) {
	    	result = true; 
	    }
	    return result;
	}
	
	public boolean checkMailAdd(String mailAdd)
	{
		try {
			Object obj = sqlMapper.queryForObject("users.check_Email", mailAdd);
			if( obj != null)
			{
				String result = obj.toString();
				if( result.equals(mailAdd) )
					return false;		//일치하는 이메일이 있으니 생성할 수 없다.
				else 
					return true;
			}else
				return true;
		} catch (SQLException e) {
			System.out.println("[UserProc] checkMailAdd: SQL Exception 발생");
		}
		return false;
	}
	
	public boolean checkTwitID(String twitId)
	{
		try {
			Object obj = sqlMapper.queryForObject("users.check_twitID", twitId);
			if( obj != null )
			{
				String result = obj.toString();
				if( result.equals(twitId) )
					return false;
				else 
					return true;
			}else
				return true;				
		} catch (SQLException e) {
			System.out.println("[UserProc] checkMailAdd: SQL Exception 발생");
		}
		return false;	//예외발생했으니 사용할 수 없음?ㅋㅋㅋㅋ
	}
	
	public HashMapTwit confirmLogin(String email, String password)
	{
		Object obj;
		String md5_password = md5(password);
		HashMapTwit mp;
		try {
			obj = sqlMapper.queryForObject("users.login", email);
			if( obj!=null )
			{
				String user_password = obj.toString();
				if( md5_password.equals(user_password) )
				{
					mp = (HashMapTwit)sqlMapper.queryForObject("users.getUserInfo", email);
					mp.remove("USER_PASSWORD");
					return mp;
				}
			}else
				return null;	//없음!!
		} catch (SQLException e) {
			System.out.println("[UserProc] confirmLogin: SQL Exception 발생!");
		}
		return null;
	}
	
	/*
	 * 	비밀번호를 MD5형식으로 암호화 시켜주는 부분.
	 * 
	 * */
	
	public String md5(String str)	//STATIC이었음! 
	{
		StringBuffer sb = new StringBuffer();
		
		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			md5.update(str.getBytes());
			byte[] md5Bytes = md5.digest();
			
			for (int i = 0; i < md5Bytes.length; i++) {
				sb.append(md5Bytes[i]);
			}
		} catch (Exception e) {
		}
		return sb.toString();
	}
	

}
