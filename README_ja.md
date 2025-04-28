# VScodeEnvKit - C/C++

WinLibs MinGW‑w64 を使用した C/C++ 開発環境セットアップスクリプトです。

[English README](https://github.com/conecone7234/VScodeEnvKit/blob/c_cpp/README.md)

## 前提条件
- Windows 環境
- PowerShell が利用可能
- VS Code がインストール済みで `code` コマンドが PATH に通っていること

## 環境利用手順

### 1. C/C++ ツールチェインのインストール
#### Git 未使用
1. 「Download ZIP」から ZIP をダウンロードし、展開します  
2. プロジェクト直下に `.vscode`（`launch.json`, `extensions.json`, `settings.json`, `tasks.json`）があることを確認  
3. ターミナルで `setup.bat` を実行    

#### Git 環境下
```bash
git clone <REPO_URL>
cd DevEnvKit
git checkout c_cpp
cd c_cpp
setup.bat
```

### 2. Setup.batの動作
1. MinGW‑w64 のバージョンタグを入力（Enter で最新を自動判定）
   - 下記のURLから使用したいReleaseのタグ名をターミナルに入力してください。
      https://github.com/brechtsanders/winlibs_mingw/releases/

      例: https://github.com/brechtsanders/winlibs_mingw/releases/tag/14.2.0posix-19.1.7-12.0.0-msvcrt-r3 => 14.2.0posix-19.1.7-12.0.0-msvcrt-r3

2. `mingw64` フォルダが生成され、C/C++ ツールチェインが配置されます

3. 自動で VS Code が起動し、プロジェクトが開かれます

### 3. VS Code 拡張機能の準備
VS Code 起動後、右下の通知から以下をインストールしてください：  
- **C/C++**（ms-vscode.cpptools）  

## ファイル構成
```
.
├ .vscode/
|   ├ launch.json
│   ├ extensions.json
│   ├ settings.json
|   └ tasks.json
├ setup.bat
└ mingw64/        ← 自動生成された MinGW‑w64 フォルダ
```

## カスタマイズ
- `setup.bat` のダウンロード URL パターンや展開動作を自由に変更可能  
- `.vscode` 以下で VS Code 設定や推奨拡張を編集可能  

## ライセンス
MIT License
