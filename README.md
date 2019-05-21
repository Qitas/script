# [linux script](https://github.com/qitas/script)

linux系统下脚本，学习和使用过程都比较简单，虽然比二进制程序执行效率要低一些。

Script是一种批处理文件的延伸，是一种纯文本保存的程序，一般来说的计算机脚本程序是确定的一系列控制计算机进行运算操作动作的组合，在其中可以实现一定的逻辑，通过解释器完成执行过程。

可用于编写脚本的语言有很多，如Scala、JavaScript，PHP，SQL，Perl，Shell，python，Ruby，Lua等。

## [shell script](shell/)

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

Python是一种动态的、面向对象的脚本语言，最初就是被设计用于编写自动化脚本(shell)，随着版本的不断更新和语言新功能的添加，越来越多被用于独立的、大型项目的开发。

查看python版本
```
python --version
#或者进入python环境会自动打印相关版本信息
python 
```

python 2和3有较大的兼容性问题，所以一般通过python2 和python3区分不同的版本，默认是有相应区分的，没有的化需要自己手动创建相应的链接或者alias。

python script文件的编写风格同shell ，只是开头的指定解释器变为：
* #!/usr/bin/python（或#!/usr/bin/python2）
* #!/usr/bin/env python3

后者 #!/usr/bin/env python这种用法是为了防止操作系统用户没有将python装在默认的/usr/bin路径里。当系统看到这一行的时候，首先会到env设置里查找python的安装路径，再调用对应路径下的解释器程序完成操作。

同样，执行文件需要赋予执行权限： chmod +x xxx.py


```
脚本文件可以使用任意文本编辑器，也可以使用任意后缀名，都不影响脚本的执行
```
---

### [example](https://github.com/qitas/script)

#### [config](config/)

获取资源系统设置

* build.sh

用于较大型工程的编译，组织各种资源安装配置等，可用于系统开发的相关工程

#### [image](image/)

图片处理相关

* all2all

通过opencv资源完成图片的色彩和编码格式转换。

## 锻造最美之器

[![sites](qitas/qitas.png)](http://www.qitas.cn)
