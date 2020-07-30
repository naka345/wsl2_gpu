# wsl2_gpu
[wsl2](https://docs.microsoft.com/ja-jp/windows/wsl/compare-versions)でCUDAを用いてGPUを使えるようにした。

必要バージョン

* windows: 20150.1000 以降
* docker: 19.03 以降
* WSL2: 4.19.121 以降
* CUDA: 11.0

windowsはinsider programを ~~fastを選択~~ Dev チャネルを選択に変わりました。
dockerはスクリプト通りにすると最新が入るはず
WSLはwindowsの`「更新とセキュリティ」->「詳細オプション」->「windows
の更新時に〜」のチェックをオンに`する必要がある。
その後にコマンドプロンプトで `wsl --update`を実行

## 留意点
[nvidiaのフォーラム](https://forums.developer.nvidia.com/t/hiccups-setting-up-wsl2-cuda/128641)で言われているように、
現段階ではwindowsの`docker desktop`経由だとGPUサポートされていないため、
WSL2上では`nvidia-container-toolkit`か`nvidia-docker2`経由で使う必要がある。
予め`docker desktop WSL 2`を使用している環境だとwin上の `docker desktop` を見に行こうとするため、設定でdisableにする必要がある。
レビュー版ということもあり、設定が中途半端だとubuntu上のdockerとカチ合ってグリーンバック画面に直行することもままある。
そのため、環境に未練が無いなら新しいdistroを作り直した方が早い。

## 使い方
基本はbashで動作させる前提

### 前提条件
windows側でWSL2カーネルとCUDAのインストールを済ませておく。
今回使用するCUDAバージョンは11.0

### 各種スクリプト
* セットアップ

```
bash setup.sh
```

fishとssh-agentを併せて使いたいためのスクリプト。
以降のスクリプトが`~/.config/fish/config.fish`に書き込むため、初めに実行する必要あり。
また再起動が必要のため一旦シャットダウンする。

* docker のインストール

```
bash docker_on_ubuntu.sh
```

本来ならdocker再起動だけでgroup周りの設定が適用されるはずだが、
どうにもWSLだとうまくいかないため一旦シャットダウンする。

* cuda toolkit & nvidia-container-toolkit のインストール

```
bash nvidia-docker.sh
```

最終行の`docker run`でGPUが認識できていれば構築完了

* おまけ

```
bash docker_on_wsl.sh
```

`docker desktop`経由でdockerを使いたい時。
linux上のdockerdと共存できないため、nvidia-dockerは使用できない。
wsl integlation の項目をチェックした上で`docker desktop`をrefreshする必要あり。

```
bash remove_docker.sh
```

WSL2上のdockerを入れ直したい場合に、
docker関連の設定も併せて削除していく。
