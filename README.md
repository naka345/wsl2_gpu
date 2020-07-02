# wsl2_gpu
[wsl2]()でCUDAを用いてGPUを使えるようにした。

[nvidiaのフォーラム](https://forums.developer.nvidia.com/t/hiccups-setting-up-wsl2-cuda/128641)で言われているように、
現段階では `docker desktop WSL 2`経由だとGPUサポートされていないため`nvidia-container-toolkit`か`nvidia-docker2`経由で使う必要がある。
予め`docker desktop WSL 2`を使用している環境だとwin上の `docker desktop` を見に行こうとするため、設定で
