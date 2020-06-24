create-app:
	argocd app create \
		--name apps \
		--repo https://github.com/adyb-fj-cns/example-helm-multiapp.git \
		--dest-server https://kubernetes.docker.internal:6443 \
		--dest-namespace default \
		--path . \
		--upsert
#--dest-server https://192.168.64.5:8443

sync-app:
	argocd app sync example-helm-multiapp

delete-app:
	argocd app delete example-helm-multiapp
