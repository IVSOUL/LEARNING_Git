解决Git中文文件名或Log乱码
core.quotepath设为false的话，就不会对0x80以上的字符进行quote。中文显示正常
git config --global core.quotepath false
add line in Mac OS X.