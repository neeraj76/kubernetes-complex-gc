docker build -t neeraj76/multi-client:latest -t neeraj76/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t neeraj76/multi-server:latest -t neeraj76/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t neeraj76/multi-worker:latest -t neeraj76/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push neeraj76/multi-client:latest
docker push neeraj76/multi-server:latest
docker push neeraj76/multi-worker:latest
docker push neeraj76/multi-client:$SHA
docker push neeraj76/multi-server:$SHA
docker push neeraj76/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=neeraj76/multi-client:$SHA
kubectl set image deployments/server-deployment server=neeraj76/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=neeraj76/multi-worker:$SHA