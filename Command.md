## 连接远程库：
### SSH认证连接GitHub库:
​	创建KEY,$ ssh-keygen -t rsa -C "你的邮箱" 
​	Enter file in which to save the key (/Users/xxx/.ssh/id_rsa): 输入目录/文件名，直接回车按默认路径。
​	创建密码：
​	再次输入密码：

### Github中添加KEY：
KEY文件路径/Users/xxx/.ssh/id_rsa，复制内容。
登录 github.com -> Account Settings -> SSH and GPG Keys -> NEW SSH Key

3. 远程库为空，首次推送不成功可尝试强制推送：git push -uf origin master。
4. 把本地仓库推送到远程库：git push -u origin master
5. 添加远程库连接：git remote add origin git@github.com:IVSOUL/Git-Command.git
6. 删除远程库连接：git remote rm origin
7. 查看远程库连接：git remote -v
8. 从远程库克隆到本地：git clone git@github.com:IVSOUL/README.git

### 基本操作：sddddd

	1. 查看文件变化区别 git diff Command.txt