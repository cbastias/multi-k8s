docker build -t cbastias/multi-client:latest -t cbastias/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cbastias/multi-server:latest -t cbastias/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t cbastias/multi-worker:latest -t cbastias/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push cbastias/multi-client:latest
docker push cbastias/multi-server:latest
docker push cbastias/multi-worker:latest

docker push cbastias/multi-client:$SHA
docker push cbastias/multi-server:$SHA
docker push cbastias/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=cbastias/multi-client:$SHA
kubectl set image deployments/server-deployment server=cbastias/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=cbastias/multi-worker:$SHA
