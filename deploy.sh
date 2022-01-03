docker build -t kylef26/multi-client-k8s:latest -t kylef26/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t kylef26/multi-server-k8s-pgfix:latest -t kylef26/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t kylef26/multi-worker-k8s:latest -t kylef26/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push kylef26/multi-client-k8s:latest
docker push kylef26/multi-server-k8s-pgfix:latest
docker push kylef26/multi-worker-k8s:latest

docker push kylef26/multi-client-k8s:$SHA
docker push kylef26/multi-server-k8s-pgfix:$SHA
docker push kylef26/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kylef26/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=kylef26/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=kylef26/multi-worker-k8s:$SHA