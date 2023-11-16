---
theme: /home/xxx/github/glamour/styles/light.json
author: xxx
---

# 命令行的高效操作

当在 shell 下工作时，只用方向键或者 Home/End 在命令行上移动是低效的。

Bash 使用 GNU Readline 来读取命令行，Readline 提供了一系列功能，方便用户快捷地编辑命令行。

Readline 有 emacs 和 vi 两种模式可用，默认是 emacs 模式。

可以通过如下命令来切换不同的模式：

set -o vi

set -o emacs

接下来的介绍都是基于 emacs 模式，涉及到如下几个方面。

- 移动
- 修改
- 历史
- 杂项

---

## 移动

- C-a       移动到行首
- C-e       移动到行尾
- C-f       前移一个字符(character)
- C-b       后移一个字符(character)
- M-f       前移一个词(word)
- M-b       后移一个词(word)
- C-] .     前移到 . 这个字符(. 表示任意一个字符)
- M-C-] .   后移到 . 这个字符(. 表示任意一个字符)

还可以在这些操作前面键入数值参数，表示操作重复的次数。

数值参数通过 M-num 来输入。

例如 M-3 M-b 表示后移 3 个词。
例如 M-1 0 C-b 表示后移 10 个字符。

M-- num 将数值参数设置为负数，负数表示操作方向相反。

例如 M-- 3 M-b 表示前移 3 个词

---

## 修改

- C-u             删除到行首
- C-k             删除到行尾
- C-h, Backspace  向后删除一个字符
- C-d, Delete     向前删除一个字符
- M-Backspace     向后删除一个词
- M-d             向前删除一个词
- C-w             向后删除一个词，使用空白符作为词边界
- M-\             删除光标附近的空白符
- C-t             交换光标前的两个字符
- M-t             交换光标前的两个词
- M-u             向后使一个词全部大写
- M-l             向后使一个词全部小写
- M-c             向后使一个词首字母大写
- C-y             粘贴最近删除的内容
- M-y             循环粘贴删除的内容，前一个命令是 C-y 或者 M-y 时才起作用
- C-_, C-x C-u    撤销一次修改，每行单独记忆
- M-r, M-C-r      撤销全部修改

---

## 历史

- C-p           获取上一条命令
- C-n           获取下一条命令
- C-r           逆向增量搜索历史记录
- C-s           正向增量搜索历史记录
- M-p           逆向非增量搜索历史记录
- M-n           正向非增量搜索历史记录
- M-<           获取第一条历史记录
- M->           获取最后一条历史记录，即当前输入的行
- M-C-e         像 shell 一样展开当前行
- M-^           在当前行进行历史展开
- !n            执行第 n 条命令
- !-n           执行倒数第 n 条命令，上一条命令 !-1 也可写为 !!
- !:n           获取上一条命令第 n 个参数
- !:x-y         获取上一条命令从第 x 到第 y 的参数
- !:n*          获取上一条命令从第 n 开始到最后的参数
- !*            获取上一条命令的所有参数
- !^, M-C-y     获取上一条命令的第一个参数
- !$, M-., M-_  获取上一条命令的最后一个参数
- !#            引用当前行
- :h            获取路径开头
- :t            获取路径结尾
- :r            获取文件名
- :e            获取扩展名
- :p            打印命令行
- :s/old/new    将 old 换成 new，针对上一条命令可简写为 ^old^new
- :gs/old/new   将 old 全部换成 new

如果在命令开头输入空格可使该命令不被记录到历史中。

键入 C-r/C-s 并输入一些字符后，可以继续键入 C-r/C-s 来查看别的匹配结果。如果 isearch-terminators 这个变量没有设置值，默认使用 ESC 或者 C-j 来终止搜索；C-g 用来终止搜索并恢复当前行。

如果在 M-./M-C-y 这些操作前面输入数值参数，则获取上一条命令的第 n 个参数。

---

## Completing

- M-?    List the possible completions of the text before point.
- M-*    Insert all possible completions of the text before point.
- M-/    Attempt filename completion on the text before point.
- C-x /  List the possible completions of the text before point, treating it as a filename.
- M-~    Attempt completion on the text before point, treating it as a username.
- C-x ~  List the possible completions of the text before point, treating it as a username.
- M-$    Attempt completion on the text before point, treating it as a shell variable.
- C-x $  List the possible completions of the text before point, treating it as a shell variable.
- M-@    Attempt completion on the text before point, treating it as a hostname.
- C-x @  List the possible completions of the text before point, treating it as a hostname.
- M-!    Attempt completion on the text before point, treating it as a command name.
- C-x !  List the possible completions of the text before point, treating it as a command name.
- M-TAB  Attempt completion on the text before point, comparing the text against lines from the history list for possible completion matches.
- M-{    Perform filename completion and insert the list of possible completions enclosed within braces so the list is available to the shell.

---

## 杂项

- C-q, C-v        字面插入下一个字符，例如：C-v Tab 会插入 Tab
- M-#             注释当前行，如果带参数的话并且该行已经被注释，则取消注释该行
- C-x C-e         使用 EDITOR 指定的编辑器来编辑当前行
- C-x (           开始录制宏
- C-x )           结束录制宏
- C-x e           执行最近录制的宏
- C-@, M-<space>  标记当前位置，如果提供数值参数的话，标记数值指定的位置
- C-x C-x         交换当前位置与之前标记的位置

# The keychords of control characters

https://unix.stackexchange.com/questions/226327/what-does-ctrl4-and-ctrl-do-in-bash

- C-2, C-`, C-<space>  →  ^@
- C-3                  →  ^[
- C-4                  →  ^\
- C-5                  →  ^]
- C-6                  →  ^^
- C-7, C-/, C--        →  ^_
- C-8, Backspace       →  ^?