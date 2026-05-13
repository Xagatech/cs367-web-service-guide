# Troubleshooting Guide

A collection of common errors encountered in the Lab with step-by-step solutions.

---

## 1. ErrImagePull / ImagePullBackOff

**Symptom:** `kubectl get pods` shows status `ErrImagePull` or `ImagePullBackOff`

**Causes and Fixes:**

```bash
# View detailed error message
kubectl describe pod <pod-name>
```

| Cause | Fix |
| ----- | --- |
| Incorrect image name | Update `image:` in api-deployment.yaml to match Docker Hub |
| Image not pushed yet | Run `docker push <username>/go-api:latest` |
| Docker Hub rate limit | Run `docker login` first, or wait 1 hour |
| Private repo missing Secret | Create an `imagePullSecret` in K8s |

---

## 2. CrashLoopBackOff

**Symptom:** Pod keeps restarting with status `CrashLoopBackOff`

```bash
# View logs from the crashed container
kubectl logs <pod-name> --previous

# View detailed events
kubectl describe pod <pod-name>
```

**Common Causes:**

| Cause | Fix |
| ----- | --- |
| Cannot connect to DB | Check if `db-service` is running: `kubectl get svc` |
| Wrong environment variable | Check Secret name/key in yaml |
| Wrong port | Verify the container is listening on the port matching `containerPort` |
| Binary built for wrong arch | Build with `GOARCH=amd64 GOOS=linux` |

---

## 3. Pod Stuck at Pending

**Symptom:** Pod stays in `Pending` state without changing

```bash
kubectl describe pod <pod-name>
# Check the "Events" section at the bottom
```

| Cause | Fix |
| ----- | --- |
| No node available | `kubectl get nodes` – if NotReady, restart minikube |
| Insufficient resources | Reduce `resources.requests` in yaml |
| PVC not Bound | `kubectl get pvc` – if Pending, check StorageClass |

---

## 4. Service Unreachable

**Symptom:** `curl` to NodePort returns Connection refused / timeout

```bash
# Check if the Pod is registered as an Endpoint
kubectl get endpoints go-api-service

# Get URL directly from minikube
minikube service go-api-service --url
```

---

## 5. GitHub Actions Runner Not Working

**Symptom:** Workflow waits a long time for a Runner, or Job never starts

```bash
# Check runner process status
cd ~/actions-runner && ./run.sh &

# Verify Runner is online in GitHub
# Settings → Actions → Runners
```

**Note:** The Runner must be running for the entire duration of the Lab.  
Use `tmux` or `nohup ./run.sh &` to keep it running in the background.

---

## 6. kubectl: connection refused

**Symptom:** `kubectl get nodes` returns `connection refused`

```bash
# Minikube may have stopped
minikube status
minikube start --driver=docker

# Check context
kubectl config current-context
kubectl config use-context minikube
```

---

## Quick Reference

```bash
# List all Pods with status
kubectl get pods -A

# Stream logs in real-time
kubectl logs -f deployment/go-api

# Restart deployment
kubectl rollout restart deployment/go-api

# Delete a Pod to force recreation
kubectl delete pod <pod-name>

# Check resource usage
kubectl top pods

# Open a shell inside a container (debug)
kubectl exec -it <pod-name> -- sh
```
