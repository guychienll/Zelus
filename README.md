# Zelus 

![logo](./assets/zelus.png)

這是一份跨平台（macOS、Amazon Linux、Ubuntu）自動化安裝與管理的 Zsh 設定檔，整合常用套件、主題、alias 及自動依賴安裝，適合開發者快速建立一致的 shell 環境。

## 目錄結構

```
.config/Zelus/
├── .zshrc         # 主要 Zsh 設定檔
├── .zprofile      # 終端機環境變數設定
├── util.sh        # 跨平台依賴安裝與初始化函式
├── aliases/
│   └── zsh.sh     # Zsh 相關 alias
└── README.md      # 專案說明文件
```

## 主要功能

- **自動偵測作業系統**，並安裝依賴（如 vim、fzf、python 等）
- 整合 [zplug](https://github.com/zplug/zplug) 管理 Zsh 外掛
- 預設安裝多款常用外掛（自動補全、語法高亮、歷史查詢、alias 提示、docker/composer 支援等）
- 內建 [Powerlevel10k](https://github.com/romkatv/powerlevel10k) 主題
- 常用 alias（zsh）集中管理
- 支援 fzf 快速檔案搜尋

## 安裝步驟

1. **Clone 本專案到 `$HOME/.config/Zelus`**
   ```sh
   git clone <本專案網址> ~/.config/Zelus
   ```

2. **將 `.zshrc` 及 `.zprofile` 連結到家目錄**
   ```sh
   echo "source ~/.config/Zelus/.zshrc" >> ~/.zshrc
   echo "source ~/.config/Zelus/.zprofile" >> ~/.zprofile
   ```

3. **重新啟動終端機或執行**
   ```sh
   source ~/.zshrc
   ```

4. **依照提示安裝外掛（第一次啟動時）**

## 主要檔案說明

- `.zshrc`  
  主要 Zsh 設定，會自動載入 util.sh 依據作業系統安裝依賴，並初始化 zplug 及外掛、主題、alias。

- `.zprofile`  
  設定終端機環境變數（如 TERM、LANG、EDITOR）。

- `util.sh`  
  定義 `install_and_setup_darwin`、`install_and_setup_amzn`、`install_and_setup_ubuntu` 三個依賴安裝函式，支援 macOS、Amazon Linux、Ubuntu。

- `aliases/zsh.sh`  
  Zsh 相關 alias，例如：
  - `zsh_reload`：重新載入 .zshrc
  - `zsh_config`：用 vim 編輯 .zshrc
