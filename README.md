# DevOps Interview Challenge - Solution

This repository contains my solution for the **DevOps Interview Challenge**. The setup covers containerization, local Kubernetes orchestration, automated releases with SemVer and Changelogs.

---

## 🚀 Architecture & Tech Stack

* **Orchestration:** Local Kubernetes cluster (`k3s`) provisioned using **Ansible** (Infrastructure as Code).
* **Workload:** Custom containerized application based on `hashicorp/http-echo`, built from scratch using a dedicated `Dockerfile`.
* **Kubernetes Deployment:** Declarative manifests incorporating custom liveness/readiness probes for reliable startup, explicit resource constraints, and a NodePort service.
* **CI/CD Automation & GitOps:** Automated pipelines built with **GitHub Actions** and synchronized via **ArgoCD**. Pushing a Semantic Versioning tag (e.g., `v1.0.0`) triggers a build, a security vulnerability scan via **Trivy**, a push to Docker Hub, an automated manifest update back to the repository, and a GitOps sync via ArgoCD.
* **Versioning & Changelogs:** Semantic Versioning (`SemVer`) combined with automated changelog.
* **Networking:** Kubernetes Services and `kubectl port-forward` for secure local application testing.

---

## 📋 Code Reviews & Fixes Implemented

### 1. Shell Script Refactoring (`shell/script.sh`)

* **Shebang Declaration:** Added `#!/bin/bash` at the top of the file to guarantee correct interpreter execution.
* **Variable Quoting:** Replaced single quotes (`' '`) with double quotes (`" "`) around variable inputs to allow proper variable expansion and prevent word-splitting bugs.
* **Typo Correction:** Fixed the variable name inconsistency from `$LOGFILE` to `"$LOG_FILE"` to ensure logs write out correctly.

### 2. Kubernetes Deployment Refactoring (`k8s/nginx.yaml`)

* **RFC 1123 Compliance:** Renamed uppercase/camelCase identifiers (`myNginx`) to lowercase (`mynginx`) to satisfy Kubernetes naming rules for DNS subdomains.
* **Resource Constraints:** Added CPU and memory `requests` and `limits` to prevent resource starvation on local nodes.
* **Labels & Selectors:** Standardized and aligned `labels` and `matchLabels` selectors across deployments and pod templates for proper replica management.
* **Port Alignment:** Configured standard container port `80` to match default image behaviors.
* **Service Configuration:** Added an explicit `type: ClusterIP`, defined the `targetPort`, and renamed the service to `mynginx-svc` for clear resource identification.
