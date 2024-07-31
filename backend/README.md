# Backend

## Building and Pushing the Docker Image

Follow these commands to build the Docker image, push it to DockerHub, and run it locally. Replace `dfanso` with your DockerHub username.

```sh
# Build the Docker image
docker build -t dfanso/k8s-backend:latest .

# Push the Docker image to DockerHub
docker push dfanso/k8s-backend:latest

# Run the Docker image locally
docker run -d -p 3000:3000 dfanso/k8s-backend:latest
```

## Deploying the Docker Image to Kubernetes

Use the following commands to deploy the Docker image to a Kubernetes cluster.

```sh
# Apply the Kubernetes deployment configuration
kubectl apply -f k8s/backend-deploy.yml

# Get information about the services, including the port the LoadBalancer is pointing to
kubectl get services

# Get information about the running pods
kubectl get pods
```

## Additional Information

To get more details about the services and pods running in your Kubernetes cluster, you can use:

```sh
# Get detailed information about the services
kubectl describe services

# Get detailed information about the pods
kubectl describe pods
```

Replace `your-docker-username` with your actual DockerHub username in all commands.
