# [linux script](https://github.com/qitas/script)

linux下面的脚本和驱动模板

## [shell script](https://github.com/qitas/script)

Shell 是用 C 编写的程序，Shell为用户提供了一个界面，用户界面访问操作系统内核的服务，是使用Linux系统最直接高效的方式，

Shell 编程只要有编辑器和一个能解释执行的脚本解释器就行（不需要编译）

Linux 系统下的 Shell 解释器常见的有：

*  Bourne Shell（/usr/bin/sh或/bin/sh）
*  Bourne Again Shell（/bin/bash）
*  C Shell（/usr/bin/csh）
*  K Shell（/usr/bin/ksh）
*  Shell for Root（/sbin/sh）

由于易用和免费，Bash 在日常工作中被广泛使用。同时，Bash 也是大多数Linux 系统默认的 Shell。一般情况下不区分 Bourne Shell 和 Bourne Again Shell，#!/bin/sh可以改为#!/bin/bash执行。

执行shell脚本，需要赋予相应文件执行权限： chmod +x ./xxx.sh

## [python script](https://github.com/qitas/script)

Python是一种解释型语言，开发过程中也没有了编译这个环节，而且在大多数的Linux发行版本中都带有python运行环境，所以可以直接将相应的代码文件作为脚本使用。

查看python版本
```
python --version

#或者进入python环境查看

python 

```
python 2和3有较大的兼容性问题，所以一般通过python2 和python3区分不同的版本，默认是有相应区分的，没有的化需要自己手动创建相应的链接或者alias。

python script文件的编写风格同shell ，只是开头的指定解释器变为： #!/usr/bin/python（或#!/usr/bin/python2）

同样，执行文件需要赋予执行权限： chmod +x xxx.py

---

### [example](https://github.com/qitas/script)

#### [config](config/)

资源获取编译，系统设置等

#### [image](image/)

图片处理相关脚本


## 锻造最美之器

[![sites](qitas/qitas.png)](http://www.qitas.cn)
