# bonus セットアップ手順

## 1. クラスタ・GitLab・ArgoCDの起動

まず以下のコマンドで必要なサービスを立ち上げます。

```
make all
```

このコマンドで以下が自動的に実行されます：
- クラスタ作成
- GitLabインストール&起動
- GitLabのPodがReadyになるまで待機
- ArgoCDインストール&起動
- ArgoCDのPodがReadyになるまで待機
- ポートフォワード

---

## 2. GitLabの初期設定（GUI）

1. ブラウザでGitLabにアクセスします。
2. 管理者パスワードの設定や初期セットアップを行います。
3. 左サイドメニューの右上のアイコンから「Edit profile」→「Access tokens」でPersonal Access Tokenを作成します。
4. Adminメニューから「Settings」→「General」→「Import and export settings」に進みます。
5. 「import github, by url」を有効にし「Save Changes」で保存します。
6. 作成したAccess Tokenを`.env`ファイルに記載します。

例：
```
GITLAB_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

---

## 3. リポジトリのインポート

GitLabの初期設定が完了したら、以下のコマンドでGitHubリポジトリをGitLabにインポートします。

```
make add-git-repo
```

---

## 4. 注意

- ArgoCDのPodがReadyになるまで、最大180秒ほどかかる場合があります。画面が表示されるまでしばらくお待ちください。
- ArgoCDはGitリポジトリの同期（ポーリング）をデフォルトで3分（180秒）ごとに行います。そのため、リポジトリを追加してからArgoCDに反映されるまで最大3分程度かかる場合があります。
