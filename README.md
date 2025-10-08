# ChatGPT Share Max - 优雅、多功能的AI服务聚合平台
## 联系方式
![](https://raw.githubusercontent.com/1198722360/picture/main/20251009051633332.png)

## 部署要求
- 熟悉chatgpt-share-server等镜像服务的使用方法
- 2c2g以上的服务器

## 快速预览
https://demo.xxsxx.fun
![](https://raw.githubusercontent.com/1198722360/picture/main/20251009051536971.png)

## 功能
- [x] ChatGPT镜像 (@xyhelper)
- [x] Claude镜像 (@lyy0709)
- [x] Grok镜像 (@lyy0709)
- [x] 在线支付(当面付、易支付)，各种权限任意搭配，灵活定价
- [x] 激活码
- [x] 优惠券
- [x] 邀请返利
- [x] 站内公告
- [x] 镜像内部接入API
- [x] 虚拟车队
- [ ] Codex
- [ ] Claude Code
- [ ] Grok Code
- [ ] Gemini Code
- [ ] 邮件推送(会员临期、站内优惠...)
- [ ] ......

## 新机快速部署
```
wget https://raw.githubusercontent.com/1198722360/chatgpt-share-max/refs/heads/main/quick-install.sh && bash quick-install.sh
```

## 访问地址
http://ip:6777/list

## 管理员账号
admin
123456

## 进阶
### Claude
```
cd ~
# 拉取修改配置文件后的ddclaude
git clone https://github.com/1198722360/ddclaude-share-server-deploy.git
cd ddclaude-share-server-deploy
# 部署ddclaude
./deploy.sh
```

### Grok
```
cd ~
# 拉取修改配置文件后的grok-share-server
git clone https://github.com/1198722360/grok-share-server-deploy.git
cd grok-share-server-deploy
# 部署grok-share-server
./deploy.sh
```

## 反向代理
### Caddy
```
# 粘贴到/etc/caddy/Caddyfile
demo.xxsxx.fun {
    reverse_proxy /max-login 127.0.0.1:6777
    reverse_proxy /max-register 127.0.0.1:6777
    reverse_proxy /list 127.0.0.1:6777
    reverse_proxy /list/chatgpt 127.0.0.1:6777
    reverse_proxy /list/claude 127.0.0.1:6777
    reverse_proxy /list/grok 127.0.0.1:6777
    reverse_proxy /codex 127.0.0.1:6777
    reverse_proxy /claude-code 127.0.0.1:6777
    reverse_proxy /grok-code 127.0.0.1:6777
    reverse_proxy /gemini-code 127.0.0.1:6777
    reverse_proxy /mall 127.0.0.1:6777
    reverse_proxy /docs 127.0.0.1:6777
    reverse_proxy /contact 127.0.0.1:6777
    reverse_proxy /profile 127.0.0.1:6777
    reverse_proxy /max-admin* 127.0.0.1:6777
    reverse_proxy /job* 127.0.0.1:6777

    # 嵌入API
    reverse_proxy /backend-api/models 127.0.0.1:6777
    reverse_proxy /backend-api/f/conversation 127.0.0.1:6777

    # 其余转给share
    reverse_proxy 127.0.0.1:8300
}

demo-claude.chatgpt-share-max.com {
    reverse_proxy 127.0.0.1:8400
}

demo-grok.chatgpt-share-max.com {
    reverse_proxy 127.0.0.1:8500
}
```


## 致谢
https://github.com/xyhelper/chatgpt-share-server-deploy
https://github.com/lyy0709/ddclaude-share-server-deploy
https://github.com/lyy0709/grok-share-server-deploy