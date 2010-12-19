package testTwitter.article;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;
import comm.db.SqlMap;
import comm.util.HashMapTwit;

public class ArticleProc {
	private SqlMapClient sqlMapper;
		
	public ArticleProc()
	{
		sqlMapper = SqlMap.getInstance();
	}
	
	public HashMapTwit getArticles(String writer)
	{
		try {
			HashMapTwit articles = (HashMapTwit)sqlMapper.queryForObject("article.getHomeArticle", writer);
			return articles;
		} catch (SQLException e) {
			System.out.println("[ArticleProc] getArticles : SQL Exception발생");
		}
		return null;
	}

	

}
