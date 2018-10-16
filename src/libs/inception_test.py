#!/usr/bin/python
# -\*-coding: utf-8-\*-
import pymysql
import sys, os
import time

# 执行还是校验
operation = '--enable-execute'
# operation = '--enable-execute;--enable-ignore-warnings;--enable-force'

# 发布目标服务器列表，目标服务器
connstr_target = {'host': 'rm-bp1q926uimur046k5.mysql.rds.aliyuncs.com', 'port': 3306, 'user': 'chenwu_rw', 'password': 'chenwu!@#1', 'db': 'inception01', 'charset': 'utf8'}
# inception server的配置
connstr_inception = {'host': '127.0.0.1', 'port': 3306, 'user': 'inception', 'password': '', 'db': '',  'charset': 'utf8mb4'}



# inception格式要求
prefix_format = "/*--user={};--password={};--host={};{};--port={};*/ ".format(connstr_target['user'],
                                                                                      connstr_target['password'],
                                                                                      connstr_target['host'],
                                                                                      operation,
                                                                                      connstr_target['port']) \
                + '\n' \
                + "inception_magic_start;"
suffix_format = "inception_magic_commit;"


#待执行的sql语句
sql_demo1 = ''' use inception01; 
            CREATE TABLE `aliyun_rds_slow_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `execute_time` datetime not null DEFAULT now() COMMENT '执行开始时间',
   primary key (`id`),
  KEY `idx_execute_time` (`execute_time`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 comment 'test'
PARTITION BY RANGE (to_days(sql_date))
(PARTITION p0 VALUES LESS THAN (737364) ENGINE = INNODB,
 PARTITION p1 VALUES LESS THAN (737394) ENGINE = INNODB,
 PARTITION p2 VALUES LESS THAN (737425) ENGINE = INNODB,
 PARTITION p3 VALUES LESS THAN (737456) ENGINE = INNODB,
 PARTITION p4 VALUES LESS THAN (737484) ENGINE = INNODB,
 PARTITION p5 VALUES LESS THAN (737515) ENGINE = INNODB,
 PARTITION p6 VALUES LESS THAN (737545) ENGINE = INNODB,
 PARTITION p7 VALUES LESS THAN (737576) ENGINE = INNODB,
 PARTITION p8 VALUES LESS THAN (737606) ENGINE = INNODB,
 PARTITION p9 VALUES LESS THAN (737637) ENGINE = INNODB,
 PARTITION p10 VALUES LESS THAN (737668) ENGINE = INNODB,
 PARTITION p11 VALUES LESS THAN (737698) ENGINE = INNODB,
 PARTITION p12 VALUES LESS THAN (737729) ENGINE = INNODB,
 PARTITION p13 VALUES LESS THAN (737759) ENGINE = INNODB,
 PARTITION p14 VALUES LESS THAN (737790) ENGINE = INNODB,
 PARTITION p15 VALUES LESS THAN (737821) ENGINE = INNODB,
 PARTITION p16 VALUES LESS THAN (737850) ENGINE = INNODB,
 PARTITION p17 VALUES LESS THAN (737881) ENGINE = INNODB,
 PARTITION p18 VALUES LESS THAN (737911) ENGINE = INNODB,
 PARTITION p19 VALUES LESS THAN (737942) ENGINE = INNODB,
 PARTITION p20 VALUES LESS THAN (737972) ENGINE = INNODB,
 PARTITION p21 VALUES LESS THAN (738003) ENGINE = INNODB,
 PARTITION p22 VALUES LESS THAN (738034) ENGINE = INNODB,
 PARTITION p23 VALUES LESS THAN (738064) ENGINE = INNODB,
 PARTITION p24 VALUES LESS THAN (738095) ENGINE = INNODB,
 PARTITION p25 VALUES LESS THAN (738125) ENGINE = INNODB,
 PARTITION sql_max VALUES LESS THAN MAXVALUE ENGINE = INNODB);'''


try:
    # 将待执行的sql语句组合成inception识别的格式
    sql_demo1_with_format = prefix_format + "\n" + sql_demo1 + "\n" + suffix_format

    print(sql_demo1_with_format)

    # 连接至inception 服务器
    conn_inception = pymysql.connect(host=connstr_inception['host'],
                                      port=connstr_inception['port'],
                                      user=connstr_inception['user'],
                                      password=connstr_inception['password'],
                                      charset=connstr_inception['charset'])


    cur = conn_inception.cursor()

    cur.execute(sql_demo1_with_format)
    result = cur.fetchall()
    num_fields = len(cur.description)
    field_names = [i[0] for i in cur.description]
    print(field_names)
    #打印出来Inception对MySQL语句的审计结果
    for row in result:
        print(row[0], "|", row[1], "|", row[2], "|", row[3], "|", row[4], "|", row[5], "|", row[6], "|",  row[7], "|",
              row[8], "|", row[9], "|", row[10])

    cur.close()
    conn_inception.close()

except  Exception as err:
    print(err)
finally:
    print('****************')
