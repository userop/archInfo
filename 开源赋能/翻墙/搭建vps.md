    v2ray info //查看 V2Ray 配置信息
    v2ray config //修改 V2Ray 配置
    v2ray link //生成 V2Ray 配置文件链接
    v2ray infolink //生成 V2Ray 配置信息链接
    v2ray qr //生成 V2Ray 配置二维码链接
    v2ray ss //修改 Shadowsocks 配置
    v2ray ssinfo //查看 Shadowsocks 配置信息
    v2ray ssqr //生成 Shadowsocks 配置二维码链接
    v2ray status //查看 V2Ray 运行状态
    v2ray start //启动 V2Ray
    v2ray stop //停止 V2Ray
    v2ray restart //重启 V2Ray
    v2ray log //查看 V2Ray 运行日志
    v2ray update //更新 V2Ray
    v2ray update.sh //更新 V2Ray 管理脚本
    v2ray uninstall //卸载 V2Ray

# 方案一 搭建v2ray
 * 使用比较稳定的linux   centOS

## 1、安装v2ray

    bash <(curl -s -L https://git.io/v2ray.sh)


## 2、获取vmess url

    v2ray url

## 3、修改协议

    v2ray  // 进入shell对话后，根据指示选择2，然后再选择想用的协议


# 方案二 搭建v2ray

## 1、安装
    bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)

## 卸载

    bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh) --remove


# v2ray修改配置
配置文件常见目录
 + /etc/v2ray/config.json
 + /usr/local/etc/v2ray/config.json

如果上述两个地方都没有，可以使用find查找配置文位置

    find / -name v2ran/config.json

## 基础配置 也是核心配置
 + inbounds 代理入口，也就是暴露给客户端用于连接代理的配置
   + port 端口，不要占用系统端口以及一些常用功能的端口 0-1023
   + protocol 协议，可以通过交互命令修改
   + clients.id 客户端ID，格式尽量保持一致
 + outbounds 代理出口，如果没有特殊设置，直接用示例的就行


    {
        "inbounds": [
            {
                "port": 8388, 
                "protocol": "vmess",    
                "settings": {
                    "clients": [
                        {
                            "id": "af41686b-cb85-494a-a554-eeaa1514bca7",  
                            "alterId": 0
                        }
                    ]
                }
            }
        ],
        "outbounds": [
            {
                "protocol": "freedom",  
                "settings": {}
            }
        ]
    }

# 附加功能

如果场景访问ChatGPT，会发现VPS用一段时间后就访问不了。
 * ChatGPT会检测访问的IP，如果被识别出来是VPS，就会禁止访问。
 * 因此可以通过VPS安装CloudFlare Warp来解决 [archlinux](https://aur.archlinux.org/cloudflare-warp-bin.git)
## CloudFlare Warp非官方客户端WGCF
### 安装wgcf (自行选择目录)
  * sudo yum install cloudflare-warp
  * warp-cli register  # 首次使用 注册
  * warp-cli set-mode proxy   # 设置为代理模式，否则无法远程链接VPS
  * warp-cli connect && warp-cli enable-always-on
  * warp-cli warp-states  # 查看连接状态
## 解决新版客户端无法使用的问题
### 方法一 服务端降级内核版本
    v2ray update core 4.45.2

### 方法二 升级客户端

## 修改v2ray配置使warp生效

### outbounds 增加一个warp出口

    "outbounds": [
        ...,
        {
            "tag": "warp",
            "protocol": "socks",
            "settings": {
                "servers": [
                    {
                        "address": "127.0.0.1",
                        "port": 40000,
                        "users": []
                    }
                ]
            }
        }
    ]

### routing 增加openai的规则

    "routing": {
        "rules": [{
            "type": "field",
            "domain": [
                "openai.com",
                "ai.com",
            ],
            "outboundTag": "warp"
        }]
    }



