create:
	argocd app create \
		--name example-helm-multiapp \
		--repo https://github.com/adyb-fj-cns/example-helm-multiapp.git \
		--dest-server https://kubernetes.default.svc \
		--dest-namespace default \
		--path . \

fix:
	argocd app create \
		--name example-helm-multiapp \
		--repo https://github.com/adyb-fj-cns/example-helm-multiapp.git \
		--dest-server https://kubernetes.default.svc \
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

build-clusters:
	minikube start --profile argocd
	minikube start --profile apps

	kubectx argocd
	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
	kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2

	kubectx apps
	kubectl create namespace argo-rollouts
	kubectl apply -n argo-rollouts -f https://raw.githubusercontent.com/argoproj/argo-rollouts/stable/manifests/install.yaml

kill-clusters:
	minikube delete --profile argocd
	minikube delete --profile apps

#--dest-server https://192.168.64.5:8443
#--dest-server https://kubernetes.default.svc
