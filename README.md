# k8-next-app

All in one Next.JS -> Kubernetes helm template

- set namespace and registry credentials
- build Dockerfile into container image
- publish image to registry
- deploy helm template to kubes cluster

## Getting Started
First, run the development server:

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.js`. The page auto-updates as you edit the file.

This project uses [`next/font`](https://nextjs.org/docs/basic-features/font-optimization) to automatically optimize and load Inter, a custom Google Font.

## Deploy to Kubernetes

### Requirements
- **Due diligence**
- docker
- kubernetes cluster
- kubectl and helm setup
- container image registry (public or private)
- cert-manager and deploy nginx ingress controller
    - https://cert-manager.io/docs/installation/helm/
    - https://cert-manager.io/docs/tutorials/acme/nginx-ingress/#step-2---deploy-the-nginx-ingress-controller
    - set DNS on IP from load balancer (this is IP given by cloud provider, e.g. OVH kubernetes loadbalancer)

### Build
- `npm install`
- Build static webapp `npm run build`
- Put `.env` file in root directory

```sh
PROJECT_NAME=k8-next-app
NAMESPACE=my-namespace

# URL pointing to container image repository
# build pushes to $REGISTRY_URL/$PROJECT_NAME:latest
REGISTRY_URL=reg.example.com/$NAMESPACE

# user/pass to user with permission to push and get
REGISTRY_USERNAME=username
REGISTRY_PASSWORD=password

# name of secret object in kubernetes, used by pods to update image
# (automatically created)
REGISTRY_SECRET=regcred
```

- Publish image to registry `npm run publish`

### Deployment
- Update `chart/values.yaml`

```yaml
replicas: 5
ingress:
  hostname: example.net
  tls:
    emailAddress: admin@example.net
```

- Install helm chart `npm run deploy`

### Update
- Update image in register `npm run publish`
- Perform rollover on kubernetes `npm run update`

### Cleanup
- Uninstall helm with `npm run destroy`
- Clean up leftover build artifacts `npm run clean`

## Nice to have
- nginx-ingress as optional subchart/dependency
- publish chart?
- private docker registry secret handling: WARNING! Using --password via the CLI is insecure. Use --password-stdin.
