docker build -t gravboy/multi-client:latest -t gravboy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gravboy/multi-server:latest -t gravboy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gravboy/multi-worker:latest -t gravboy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gravboy/multi-client:latest
docker push gravboy/multi-server:latest
docker push gravboy/multi-worker:latest

docker push gravboy/multi-client:$SHA
docker push gravboy/multi-server:$SHA
docker push gravboy/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=gravboy/multi-client:$SHA
kubectl set image deployments/server-deployment server=gravboy/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=gravboy/multi-worker:$SHA