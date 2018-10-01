ps aux|grep guni|grep 8000|grep -v grep|awk '{print $2}'|xargs kill -9
