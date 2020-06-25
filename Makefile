create:
	argocd app create \
		--name example-helm-multiapp \
		--repo https://github.com/adyb-fj-cns/example-helm-multiapp.git \
		--dest-server https://192.168.64.8:8443 \
		--dest-namespace default \
		--path . \

fix:
	argocd app create \
		--name example-helm-multiapp \
		--repo https://github.com/adyb-fj-cns/example-helm-multiapp.git \
		--dest-server https://192.168.64.8:8443 \
		--dest-namespace default \
		--path . \
		--upsert
sync:
	argocd app sync example-helm-multiapp

delete:
	argocd app delete example-helm-multiapp --cascade

get:
	argocd app get example-helm-multiapp

list:
	argocd app list

list-rollouts:
	kubectl argo rollouts list rollouts

# Currently the ArgoCD cascade delete isnt deleting Rollout resources in multiapps
delete-rollouts:
	kubectl delete rollout example-helm-app-bluegreen
	kubectl delete rollout example-helm-app-bluegreen2

#--dest-server https://192.168.64.5:8443
#--dest-server https://kubernetes.default.svc