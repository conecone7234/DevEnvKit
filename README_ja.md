# VScodeEnvKit - Python

VScodeEnvKit の Python 向けセットアップスクリプトです。

[English README](https://github.com/conecone7234/VScodeEnvKit/blob/python/README.md)

## 前提条件
- Windows 環境
- PowerShell が利用可能
- VSCode インストール済みで `code` コマンドが PATH に通っていること

## Python 環境の利用方法
### 1. Pythonのインストール
#### Git 未使用
1. `Download ZIP`からプロジェクトファイルをダウンロードし、展開
2. プロジェクト直下にある `.vscode` フォルダ（extensions.json, settings.json）が存在することを確認
3. ターミナルで `setup.bat` を実行

#### Git 環境下
```bash
git clone <REPO_URL>
cd DevEnvKit
git checkout python
cd python
setup.bat
```

### 2. Setup.batの動作
1. Python バージョンを入力（空 Enter で最新を自動判定）
   - https://www.python.org/ftp/python/ 内のバージョン一覧から取得したいバージョンを選択する
2. `python-portable` フォルダが生成される
3. 自動で VSCode が起動し、プロジェクトが開かれる

### 3. VScodeの拡張機能の準備
VScodeが起動すると右下に案内が出るため、インストールを押せば完了

## ファイル構成
```
  .
  ├ .vscode/
  │   ├ extensions.json
  │   └ settings.json
  ├ setup.bat
  └ python-portable/   ← 自動生成フォルダ
```

## カスタマイズ
- `setup.bat` の内容を編集して動作を変更可能
- VSCode の設定や推奨拡張は `.vscode` 以下で調整

## ライセンス
MIT License
