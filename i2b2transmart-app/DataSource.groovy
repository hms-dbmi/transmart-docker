dataSource {
    driverClassName = 'oracle.jdbc.driver.OracleDriver'
    url             = 'jdbc:oracle:thin:@i2b2transmartdb:1521:xe'
    dialect         = 'org.hibernate.dialect.Oracle10gDialect'
    username        = 'biomart_user'
    password        = 'biomart_user'
    dbCreate        = 'none'
}

hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache        = true
    cache.provider_class         = 'org.hibernate.cache.EhCacheProvider'
}

environments {
    development {
        dataSource {
            logSql    = false
            formatSql = true
             properties {
                maxActive   = 10
                maxIdle     = 5
                minIdle     = 2
                initialSize = 2
            }
        }
    }
    production {
        dataSource {
            logSql    = false
            formatSql = false
             properties {
                maxActive   = 50
                maxIdle     = 25
                minIdle     = 5
                initialSize = 5
            }
        }
    }
}

// vim: set ts=4 sw=4 et:
