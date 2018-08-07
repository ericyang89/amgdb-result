# seeddms
an docment management system from Uwe Steinmann http://www.seeddms.org

1 。将项目下 pear 目录的 pear 扩展库 拷贝到 php 的安装目录 比如为 D:\phpenv\php56_64\pear

2. 修改 php 配置文件 php.ini 找到如下内容 将 include_path 修改为 pear 地址 D:\phpenv\php56_64\pear

```
; Windows: "\path1;\path2"
include_path = ".;D:\phpenv\php56_64\pear"
```

