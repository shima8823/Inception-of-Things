.PHONY: all create-cluster install-gitlab wait-gitlab add-git-repo install-argocd wait-argocd port-forward delete-cluster

# リソース不足を防ぐため、GitLabとArgoCDのインストールは順番に実行する
all: create-cluster install-gitlab wait-gitlab install-argocd wait-argocd port-forward
	@echo "\n---"
	@echo "GitLabのAccess Tokenを取得しenvファイルを作成して、add-git-repoを実行してください。"
	@echo "例: make add-git-repo"
	@echo "---\n"

create-cluster:
	@echo "クラスタ作成中..."
	@bash ./scripts/create_cluster.sh

install-gitlab:
	@echo "GitLabインストール中..."
	@bash ./scripts/install_gitlab.sh

wait-gitlab:
	@echo "GitLabのPodがReadyになるまで待機..."
	@kubectl wait --for=condition=Ready pod -l app=webservice -n gitlab --timeout=600s

add-git-repo:
	@bash ./scripts/add_git_repo.sh

install-argocd:
	@echo "ArgoCDインストール中..."
	@bash ./scripts/install_argocd.sh
	
wait-argocd:
	@echo "ArgoCDのPodがReadyになるまで待機..."
	@kubectl wait --for=condition=Ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s

port-forward:
	@echo "ポートフォワード開始..."
	@bash ./scripts/port_forward.sh 

delete-cluster:
	@echo "クラスタ削除中..."
	@k3d cluster delete iot-shshimad-bonus