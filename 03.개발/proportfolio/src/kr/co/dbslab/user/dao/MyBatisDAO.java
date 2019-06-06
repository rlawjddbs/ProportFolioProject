package kr.co.dbslab.user.dao;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MyBatisDAO {
	
	private static MyBatisDAO mb_dao;
	private SqlSessionFactory ssf;
	
	private MyBatisDAO() {
	} // MyBatisDAO
	
	public static MyBatisDAO getInstance() {
		if( mb_dao == null ) {
			mb_dao = new MyBatisDAO();
		} // end if
		return mb_dao;
	} // getInstance
	
	public synchronized SqlSessionFactory getSessionFactory() {
		if(ssf == null) {
			org.apache.ibatis.logging.LogFactory.useLog4JLogging();
			
			Reader reader = null;
			try {
				reader = Resources.getResourceAsReader("kr/co/dbslab/user/dao/mybatis_config.xml");
				SqlSessionFactoryBuilder ssfb = new SqlSessionFactoryBuilder();
				ssf = ssfb.build(reader);
				if( reader != null ) {
					reader.close();
				} // end if
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		} // end if
		return ssf;
	} // getSessionFactory
	
}
