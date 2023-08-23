# Microservice
模块介绍  
  
#### cloud-demo
微服务框架相关代码，涉及Eureka 注册中心、Ribbon 负载均衡、Nacos 注册中心、http 客户端 Feign、统一网关 Gateway。  
  
#### hotel
elasticsearch相关代码，利用分布式搜索引擎查询酒店信息。  
  
#### item-service
多级缓存相关代码，涉及JVM进程缓存（Caffeine）、多级缓存、缓存同步（Canal）、OpenResty 代码编写（nginx、Lua）。

#### mq-demo
服务异步通讯相关代码，通过SpringAMQP配合RabbitMQ，涉及消息可靠性、死信交换机、惰性队列、MQ 集群。

#### redis-demo
通过Redis实现分布式缓存的相关代码。  
五种数据类型：string（字符串），hash（哈希），list（列表），set（集合）及zset(sorted set：有序集合)。 

#### seata-demo
分布式事务相关代码，涉及Seata架构的四种解决方案：XA 模式、AT 模式、TCC 模式、SAGA 模式。
