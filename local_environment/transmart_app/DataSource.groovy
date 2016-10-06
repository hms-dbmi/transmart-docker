 /**
 * Configuration for database connection - this file will be loaded
 * by the tranSMART application when the tomcat is restarted
 */

dataSource {
// pooled connection
pooled = true
// standard jdbc driver
driverClassName ="oracle.jdbc.driver.OracleDriver"

//url = "jdbc:oracle:thin:@10.0.0.2:1521:xe"
url = "jdbc:oracle:thin:@172.19.0.2:1521:xe"
username = "biomart_user"
password = "biomart_user"

// hibernate database connection dialect
dialect = "org.hibernate.dialect.Oracle10gDialect"
// enable this for SQL debugging
        loggingSql =true
}

hibernate {
// hibernate cache config
cache.use_second_level_cache=true
//turn on query cache
cache.use_query_cache=true
cache.provider_class='org.hibernate.cache.EhCacheProvider'
// pool size
connection.pool_size=30
//format_sql = true
//use_sql_comments = true
}
