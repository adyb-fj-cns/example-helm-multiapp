create-app:
	argocd app create \
		--name example-helm-multiapp \
		--repo https://github.com/adyb-fj-cns/example-helm-multiapp.git \
		--dest-server https://192.168.64.5:8443 \
		--dest-namespace default \
		--path . \
		--sync-policy automated \

sync-app:
	argocd app sync example-helm-multiapp

delete-app:
	argocd app delete example-helm-multiapp
