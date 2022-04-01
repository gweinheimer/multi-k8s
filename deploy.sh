docker build -t gweinheimer/multi-client:latest -t gweinheimer/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gweinheimer/multi-server:latest -t gweinheimer/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gweinheimer/multi-worker:latest -t gweinheimer/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# push images to dockerhub
docker push gweinheimer/multi-client:latest  
docker push gweinheimer/multi-server:latest  
docker push gweinheimer/multi-worker:latest
docker push gweinheimer/multi-client:$SHA  
docker push gweinheimer/multi-server:$SHA  
docker push gweinheimer/multi-worker:$SHA  
#
kubectl apply -f k8s
#
kubectl set image deployments/server-deployment server=gweinheimer/multi-server:$SHA
kubectl set image deployments/client-deployment client=gweinheimer/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gweinheimer/multi-worker:$SHA