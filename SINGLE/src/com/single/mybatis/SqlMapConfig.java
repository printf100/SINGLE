package com.single.mybatis;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlMapConfig {
   
   private SqlSessionFactory sqlSessionFactory;
   
   public SqlSessionFactory getSqlSessionFactory() {
      
      String resource = "com/single/mybatis/config.xml";
      
      try {
         Reader reader = Resources.getResourceAsReader(resource);
         sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
         
         reader.close();
      } catch (IOException e) {
         e.printStackTrace();
      }
      
      return sqlSessionFactory;
   }
}