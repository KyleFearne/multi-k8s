docker build -t kylef26/multi-client:latest -t kylef26/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kylef26/multi-server:latest -t kylef26/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kylef26/multi-worker:latest -t kylef26/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kylef26/multi-client:latest
docker push kylef26/multi-server:latest
docker push kylef26/multi-worker:latest
docker push kylef26/multi-client:$SHA
docker push kylef26/multi-server:$SHA
docker push kylef26/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kylef26/multi-server:$SHA
kubectl set image deployments/client-deployment client=kylef26/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kylef26/multi-worker:$SHA
