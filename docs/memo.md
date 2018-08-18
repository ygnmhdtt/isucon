# nginx

* kataribe

```
cat /var/log/nginx/access.log | ./kataribe [-f kataribe.toml]
```

# MySQL

* スロークエリログ設定確認

```
USE information_schema
SELECT * FROM `GLOBAL_VARIABLES` WHERE `VARIABLE_NAME` LIKE '%query%' LIMIT 0,1000;
```

* index確認

```
SHOW INDEX FROM table_name
```

* index作成

```
ALTER TABLE table_name ADD INDEX index_name (column);
```

* その他
 - 小さな数値はTINYINT(8bit)やSMALLINT(16bit)などを用いる。INT(3) などはINTと同様のパフォーマンス。
 - 0.00001 等の値を管理しないといけない場合は100万倍してBIGINTを使うと高速に演算でき、浮動小数点の精度を気にしなくても済む。
 - IPアドレスはCHAR(15)ではなく、32bit整数値(INT)を用いて保存し、比較をする場合にはINET_ATON(192.168.0.1→3232235521)やINET_NTOA((3232235521→192.168.0.1)を使う
 - JOINする際には、結合するカラムが同じ型であることを確認する
 - 列の数が多すぎて、パフォーマンスが落ちるのは数百列ある場合

# カーネルパラメータ

### ref: https://kazeburo.hatenablog.com/entry/2014/10/14/170129

$ sudo vim /etc/sysctl.conf

```
net.ipv4.tcp_max_tw_buckets = 2000000
net.ipv4.ip_local_port_range = 10000 65000
net.core.netdev_max_backlog = 8192
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_fin_timeout = 10

# RAM を使いきるまでスワップしないようにする
vm.swappiness = 0

# IPv6の無効化
# IPv6でのルーティングがないのであれば、わずかなオーバーヘッドも惜しいので削る。
# というか昔、IPv6が有効な環境で通信が遅くなる事例に見舞われたので条件反射的にやってしまうやつ。
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1

# IPv4のソケットを使いまわす(送受両方)
# 同一IPから複数セッション張られることが予想される場合、tcp_tw_recycle=0 がいいかも
net.ipv4.tcp_tw_recycle=1
net.ipv4.tcp_tw_reuse=1

# FIN-WAIT-2 のソケットを強制クローズする
net.ipv4.tcp_fin_timeout=2

# TCPキープアライブの設定
# アイドル状態のTCP接続を早めに落として連続してベンチたたいても影響がないようにしたかった。
# net.ipv4.tcp_keepalive_probesとnet.ipv4.tcp_keepalive_intvlを設定しなかったので効いていなかった。※65s + 75s × 9回 = 740s の間、アイドル状態の通信が切られãªい設定になっていた
net.ipv4.tcp_keepalive_time=65

# できるだけ多くの接続を受け付けられるように接続のキューを増やす
net.core.somaxconn=65535
net.ipv4.tcp_max_syn_backlog=65535

# 送受信のバッファサイズも大きめに設定する
net.core.rmem_max=16777216
net.core.wmem_max=16777216

# swapの発生頻度を下げる設定
# 0にしてもよかった
vm.swappiness=10

# カーネルレベルでのファイルディスクリプタ上限数変更
# プロセス単位のチューニングをやったけど、こっちもやっておく
fs.file-max=65535
```

```
# 適用
$ sudo /sbin/sysctl -p
```

# その他

* カーネルのバージョン確認

```
cat /proc/version
```

* kataribeインストール

```
git clone https://github.com/matsuu/kataribe.git
cd kataribe
go get github.com/BurntSushi/toml
go build -o kataribe
sudo mv kataribe /usr/bin/kataribe
mv kataribe.toml ~/kataribe.toml

cd ../
rm -rf kataribe
```

* percona インストール

```
# ubuntu
sudo apt-get -y install percona-toolkit

# centos
sudo yum -y install perl-Time-HiRes perl-IO-Socket-SSL perl-DBD-MySQL
sudo rpm -ivh http://www.percona.com/redir/downloads/percona-toolkit/2.2.11/RPM/percona-toolkit-2.2.11-1.noarch.rpm
```

* aws-cliインストール

```
# ubuntu
$ sudo apt-get install -y python-pip
$ sudo pip install awscli

# centos
$ sudo yum install -y python-setuptools
$ easy_install pip
$ pip install awscli
```

* FW等はproductionモードにする
