## Git鼓励大量使用分支：

- 查看本地分支：

  ```
  git branch
  ```

- 创建分支：git branch <name>

- 切换分支：git checkout <name>

- 创建+切换分支：git checkout -b <name>

- 合并某分支到当前分支：git merge <name>

- 删除本地分支：git branch -d <name>

- 查看远程分支：git branch -a

- 删除远程分支：git push origin :branch-name（注意冒号）

> 其实多个分支是共用暂存区的，也就是说如果在分支1上仅add而不commit，实际暂存区中已经记录该次修改。哪怕后续切换到分支2上再进行commit也是有效的操作，只不过已经不是自己想要的处理。这块确实需要注意，避免误操作。