# Inception of Things
42 project Kubernetes

このリポジトリは、Kubernetesを使用したIoTシステムの構築と管理に関する3つのプロジェクト（p1, p2, p3）です。

## 必要条件
- Vagrant
- VirtualBox
- kubectl
- k3d
- 十分なメモリとディスク容量

## プロジェクト構成

### p1: シングルノードKubernetesクラスター
- Vagrantを使用して2ノードのKubernetesクラスターを構築
- コントロールプレーン（wilS）とワーカーノード（wilSW）の2つのVMを構成

#### セットアップ方法
```bash
cd p1
vagrant up
```

### p2: Ingressを使用したマルチアプリケーション構成
- Kubernetes Ingressを使用して、ホスト名に基づいて異なるアプリケーションにルーティング
- 3つの異なるアプリケーションをデプロイ：
  - app1.com: アプリケーション1
  - app2.com: アプリケーション2
  - デフォルト: アプリケーション3
- 各アプリケーションはNginxを使用し、ConfigMapでHTMLコンテンツを管理
- アプリケーション構成：
  - デプロイメント（Deployment）
  - サービス（Service）
  - ConfigMap（HTMLコンテンツ）
  - Ingress（ルーティングルール）

#### セットアップ方法
```bash
cd p2
vagrant up
```

#### アクセス方法
1. curlコマンドでHTMLを返す
- アプリケーション1にアクセス：
```bash
curl -H "Host: app1.com" http://192.168.56.110
```

- アプリケーション2にアクセス：
```bash
curl -H "Host: app2.com" http://192.168.56.110
```

- アプリケーション3にアクセス：
```bash
curl http://192.168.56.110
```

2. ブラウザで以下のURLにアクセス：
- http://192.168.56.110 - アプリケーション3を表示

### p3: k3dとArgoCDを使用したGitOps構成
- k3dを使用して軽量なKubernetesクラスターを構築
- ArgoCDを使用したGitOps実装
- 監視対象リポジトリ: https://github.com/shima8823/IoT-shshimad.git

#### 設計
1. クラスター構成
   - k3dを使用したシングルノードクラスター
   - アプリケーションのポートフォワーディング: 8888:8888
   - 名前空間:
     - argocd: ArgoCDのデプロイメント用
     - dev: アプリケーションのデプロイメント用

2. ArgoCD構成
   - ArgoCDサーバーのポートフォワーディング: 8080:80

#### セットアップ方法
1. k3dのインストール
2. クラスターの構築とArgoCDのセットアップ
```bash
cd p3
bash ./scripts/setup-argocd.sh
```

#### アクセス方法
1. ArgoCD UIにアクセス
- URL: http://127.0.0.1:8080
- ユーザー名: admin
- パスワード: セットアップスクリプトの出力で表示されるパスワード

2. アプリケーションの状態確認
- ArgoCD UIでアプリケーションの同期状態を確認
- デプロイメントの進捗をリアルタイムで監視

3. GitOpsの動作確認
この手順では、GitOpsの主要な機能である「宣言的な設定管理」と「自動的な同期」を確認します。

    a. 監視リポジトリの設定
    1. 監視リポジトリ（https://github.com/shima8823/IoT-shshimad.git）をフォーク
    2. `p3/confs/application.yaml`の`repoURL`をフォークしたリポジトリのURLに更新
    3. 変更を適用:
    ```bash
    kubectl apply -f p3/confs/application.yaml
    ```

    b. 現在のデプロイメント状態の確認
    ```bash
    curl http://127.0.0.1:8080
    ```
    このコマンドで現在のイメージタグを確認できます。

    c. アプリケーションの更新
    1. フォークしたリポジトリの`deployments.yaml`を編集
    2. イメージタグを変更（例: v1 → v2）
    3. 変更をコミットしてプッシュ
    4. ArgoCDが自動的に変更を検知し、クラスターに反映

    この手順により、以下のGitOpsの主要な機能を確認できます：
    - 宣言的な設定管理: すべての設定がGitリポジトリで管理される
    - 自動的な同期: リポジトリの変更が自動的にクラスターに反映される
    - バージョン管理: 変更履歴がGitで追跡可能
    - デプロイメントの追跡: ArgoCD UIで変更の状態を確認可能
    - ロールバックの容易さ: 問題が発生した場合、Gitの履歴から以前の状態に戻せる
