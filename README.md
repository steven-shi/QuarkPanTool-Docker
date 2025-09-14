# QuarkPanTool

[![Python Version](https://img.shields.io/badge/python-3.11.6-blue.svg)](https://www.python.org/downloads/release/python-3116/)
[![Latest Release](https://img.shields.io/github/v/release/ihmily/QuarkPanTool)](https://github.com/ihmily/QuarkPanTool/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/ihmily/QuarkPanTool/total)](https://github.com/ihmily/QuarkPanTool/releases/latest)
![GitHub Repo stars](https://img.shields.io/github/stars/ihmily/QuarkPanTool?style=social)


QuarkPanTool 是一个简单易用的小工具，旨在帮助用户快速批量转存分享文件、批量生成分享链接和批量下载夸克网盘文件。

## 功能特点

- 运行稳定：基于playwright支持网页登录夸克网盘，无需手动获取Cookie。
- 轻松操作：简洁直观的命令行界面，方便快捷地完成文件转存。
- 批量转存：支持一次性转存多个夸克网盘分享链接中的文件。
- 批量分享：支持一次性将某个文件夹内的所有文件夹批量生成分享链接，无需手动分享文件。
- 本地下载：支持批量下载网盘文件夹中的文件，已绕过web端文件大小下载限制，无需VIP。

## 如何使用

如果不想自己部署环境，可以下载打包好的可执行文件(exe)压缩包 [QuarkPanTool](https://github.com/ihmily/QuarkPanTool/releases) ，解压后直接运行即可。

1.下载代码

```
git clone https://github.com/ihmily/QuarkPanTool.git
```

2.安装依赖

```
pip install -r requirements.txt
playwright install firefox
```

3.运行

```
python quark.py
```

运行后会使用playwright进行登录操作，当然也可以自己手动获取cookie填写到config/cookies.txt文件中。更多说明请浏览 [wiki](https://github.com/ihmily/QuarkPanTool/wiki) 页面

## 使用 Docker 运行

本项目支持使用 Docker 与 Docker Compose 运行，适用于无需在本机安装浏览器与依赖的场景。

重要说明：容器内无法弹出图形化浏览器进行登录，首次使用请自行在浏览器获取并填写 Cookie 到 `config/cookies.txt` 后再运行容器。Cookie 格式支持：

- 直接粘贴为一行 Cookie 字符串：`key1=value1; key2=value2; ...`
- 或粘贴从浏览器导出的 cookie 列表（JSON 列表，程序会自动转换）

### 1. 构建镜像

```bash
docker compose build
```

### 2. 准备配置与数据目录（宿主机）

```bash
mkdir -p config share downloads
# 将你的 Cookie 写入到宿主机的 config/cookies.txt 文件中
touch url.txt  # 用于批量任务的分享地址清单（每行一个）
```

### 3. 启动（交互式菜单）

**方法一：使用 docker compose run（推荐）**
```bash
docker compose run --rm app
```

**方法二：使用 docker compose up（需要附加到容器）**
```bash
# 启动容器
docker compose up -d

# 附加到容器进行交互
docker compose exec app python quark.py

# 停止容器
docker compose down
```

容器会挂载以下目录，数据将持久化到宿主机：

- `./config` ↔ `/app/config`
- `./share` ↔ `/app/share`
- `./downloads` ↔ `/app/downloads`
- `./url.txt` ↔ `/app/url.txt`

提示：如果 `config/cookies.txt` 为空，程序会尝试在容器内启动浏览器登录，这在无图形环境下不可用，请务必先填好 Cookie。

## 注意事项

- 首次运行会比较缓慢，请注意底部任务栏，程序会自动打开一个浏览器，让你登录夸克网盘，登录完成后，请不要手动关闭浏览器，回到软件界面按Enter键，浏览器会自动关闭并保存你的登录信息，下次运行就不需要登录了。（如果是Linux环境，请自行在网页获取Cookie后填入config/cookies.txt文件使用）
- 执行批量转存之前，请先在url.txt文件中填写网盘分享地址（一行一个）。
- **如果分享地址有密码**，则在地址末尾加上 `?pwd=提取码`，例如`https://pan.quark.cn/s/abcd`是文件分享地址，提取码是123456，则输入到程序的地址应该是`https://pan.quark.cn/s/abcd?pwd=123456`

## 效果演示

![ScreenShot1](./images/Snipaste_2024-09-23_19-02-03.jpg)

## 许可证

QuarkPanTool 使用 [Apache-2.0 license](https://github.com/ihmily/QuarkPanTool#Apache-2.0-1-ov-file) 许可证，详情请参阅 LICENSE 文件。

------

**免责声明**：本工具仅供学习和研究使用，请勿用于非法目的。由使用本工具引起的任何法律责任，与本工具作者无关。
