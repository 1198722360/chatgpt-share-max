# ChatGPT Share Max

## 新机快速部署
```
wget https://raw.githubusercontent.com/1198722360/chatgpt-share-max/refs/heads/main/quick-install.sh && bash quick-install.sh
```

## 访问地址
http://ip:6777/list

## 管理员账号
admin
123456

## 反向代理
### Caddy
```
# 粘贴到/etc/caddy/Caddyfile
www.chatgpt-share-max.com {
    reverse_proxy /max-login 127.0.0.1:6777
    reverse_proxy /max-register 127.0.0.1:6777
    reverse_proxy /list 127.0.0.1:6777
    reverse_proxy /list/chatgpt 127.0.0.1:6777
    reverse_proxy /list/claude 127.0.0.1:6777
    reverse_proxy /list/grok 127.0.0.1:6777
    reverse_proxy /codex 127.0.0.1:6777
    reverse_proxy /claude-code 127.0.0.1:6777
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
```

### Nginx
```
~~狗都不用~~不会
```