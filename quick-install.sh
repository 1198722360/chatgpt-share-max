#!/bin/sh
cd ~
git clone https://github.com/xyhelper/chatgpt-share-server-deploy.git
git clone https://github.com/1198722360/chatgpt-share-max.git

echo "version: '3.8'
services:
  chatgpt-mysql:
    image: mysql:8
    command: --mysql-native-password=ON --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
    restart: always
    volumes:
      - ./data/mysql/:/var/lib/mysql/
      - ./docker-entrypoint-initdb.d/:/docker-entrypoint-initdb.d/
    environment:
      TZ: Asia/Shanghai # 指定时区
      MYSQL_ROOT_PASSWORD: "123456" # 配置root用户密码
      MYSQL_DATABASE: "cool" # 业务库名
      MYSQL_USER: "cool" # 业务库用户名
      MYSQL_PASSWORD: "123123" # 业务库密码
  chatgpt-redis:
    image: redis
    # command: --requirepass "12345678" # redis库密码,不需要密码注释本行
    restart: always
    environment:
      TZ: Asia/Shanghai # 指定时区
    volumes:
      - ./data/redis/:/data/
  chatgpt-share-server:
    image: xyhelper/chatgpt-share-server:latest
    restart: always
    ports:
      - 8300:8001
    environment:
      TZ: Asia/Shanghai # 指定时区
      # 接入网关地址
      CHATPROXY: "https://muchai.v4.xyhelper-gateway.com"
      # 接入网关的authkey
      AUTHKEY: "xyhelper"
      # 内容审核及速率限制
      AUDIT_LIMIT_URL: "http://chatgpt-share-max:6777/job/audit_limit"
      OAUTH_URL: "http://chatgpt-share-max:6777/job/chatgpt/oauth"
    volumes:
      - ./config.yaml:/app/config.yaml
      - ./data/chatgpt-share-server/:/app/data/
    labels:
      - "com.centurylinklabs.watchtower.scope=xyhelper-chatgpt-share-server"
  auditlimit:
    image: xyhelper/auditlimit
    restart: always
    # ports:
    #   - 9611:8080
    environment:
      LIMIT: 40  # 限制每个userToken允许的次数
      PER: "3h" # 限制周期 1s, 1m, 1h, 1d, 1w, 1y
    labels:
      - "com.centurylinklabs.watchtower.scope=xyhelper-chatgpt-share-server"
  watchtower:
    image: containrrr/watchtower
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    command: --scope xyhelper-chatgpt-share-server --cleanup
    restart: always
    environment:
      - TZ=Asia/Shanghai
    labels:
      - "com.centurylinklabs.watchtower.scope=xyhelper-chatgpt-share-server"
      
networks:
  default:
    name: max
    driver: bridge" > ~/chatgpt-share-server-deploy/docker-compose.yml
	
echo "database:
  default: # 数据源名称,当不指定数据源时 default 为默认数据源
    type: "mysql" # 数据库类型
    host: "chatgpt-mysql" # 数据库地址
    port: "3306" # 数据库端口
    user: "root" # 数据库用户名
    pass: "123456" # 数据库密码
    name: "cool" # 数据库名称
    charset: "utf8mb4" # 数据库编码
    timezone: "Asia/Shanghai" # 数据库时区
    # debug: true # 是否开启调试模式，开启后会打印SQL日志
    createdAt: "createTime" # 创建时间字段
    updatedAt: "updateTime" # 更新时间字段

redis:
  cool:
    address: "chatgpt-redis:6379"
    db: 0


cool:
  autoMigrate: true
  eps: true
  file:
    mode: "local"
    domain: "http://127.0.0.1:8300"

modules:
  base:
    jwt:
      sso: false
      secret: "chatgpt-share-server"
      token:
        expire: 7200 # 2*3600
        refreshExpire: 1296000 # 24*3600*15
    middleware:
      authority:
        enable: 1
      log:
        enable: 1" > ~/chatgpt-share-server-deploy/config.yaml
	
cd ~/chatgpt-share-server-deploy
./deploy.sh

cd ~/chatgpt-share-max
chmod +x ./deploy.sh
./deploy.sh