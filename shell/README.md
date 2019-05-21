# [shell script](https://github.com/qitas/script)

输出重定向：
```
>>test.log 2>&1       正确或错误结果追加到test.log文件里
 >test.log 2>&1       正确或错误结果覆写test.log文件
```
脚本执行退出：
```
#!/bin/bash
set -e
command 1
command 2
...
exit 0

非正常退出：

command  
if [ "$?"-ne 0]; then
   echo "command failed";
   exit 1;
fi

后者能够被代替为：

command || { echo "command failed"; exit 1; }

或者替代为：

if ! command; then  
    echo "command failed";   
   exit 1;   
fi
```