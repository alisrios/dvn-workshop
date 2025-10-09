# DVN Workshop - DevOps na Nuvem

Este projeto é um workshop completo de DevOps na nuvem que demonstra a implementação de uma aplicação full-stack com infraestrutura como código (IaC) usando Terraform, containerização com Docker, e CI/CD com GitHub Actions no Amazon EKS.

## 🏗️ Arquitetura do Projeto

O projeto está organizado em duas partes principais:

### 📱 Aplicações (`dvn-workshop-apps/`)
- **Backend**: API REST em .NET 7 com Swagger/OpenAPI
- **Frontend**: Aplicação Next.js 14 com TypeScript e Tailwind CSS

### ☁️ Infraestrutura (`dvn-workshop-terraform/`)
- **00-remote-state-backend-stack**: Configuração do backend remoto do Terraform (S3 + DynamoDB)
- **01-networking-stack**: Infraestrutura de rede (VPC, subnets, gateways)
- **02-eks-cluster-stack**: Cluster EKS com repositórios ECR e configurações IAM

## 🚀 Tecnologias Utilizadas

### Backend
- **.NET 7**: Framework principal
- **ASP.NET Core**: API REST
- **Swagger/OpenAPI**: Documentação da API
- **Health Checks**: Monitoramento de saúde da aplicação

### Frontend
- **Next.js 14**: Framework React
- **TypeScript**: Tipagem estática
- **Tailwind CSS**: Framework CSS utilitário
- **ESLint**: Linting de código

### Infraestrutura
- **Terraform**: Infrastructure as Code
- **AWS EKS**: Kubernetes gerenciado
- **AWS ECR**: Registry de containers
- **AWS VPC**: Rede virtual privada
- **S3 + DynamoDB**: Backend remoto do Terraform

### CI/CD
- **GitHub Actions**: Pipelines de CI/CD
- **Docker**: Containerização
- **Kustomize**: Gerenciamento de manifests Kubernetes
- **GitOps**: Deployment automatizado

## 📋 Pré-requisitos

- AWS CLI configurado
- Terraform >= 1.0
- Docker
- Node.js >= 18
- .NET 7 SDK
- kubectl
- Kustomize

## 🛠️ Configuração do Ambiente

### 1. Configuração da AWS

```bash
# Configure suas credenciais AWS
aws configure

# Ou use assume role (como configurado no projeto)
# Role ARN: arn:aws:iam::148761658767:role/Workshop-role
```

### 2. Deploy da Infraestrutura

#### Passo 1: Backend Remoto do Terraform
```bash
cd dvn-workshop-terraform/00-remote-state-backend-stack
terraform init
terraform plan
terraform apply
```

#### Passo 2: Infraestrutura de Rede
```bash
cd ../01-networking-stack
terraform init
terraform plan
terraform apply
```

#### Passo 3: Cluster EKS
```bash
cd ../02-eks-cluster-stack
terraform init
terraform plan
terraform apply
```

### 3. Configuração do Kubernetes

```bash
# Configure o kubectl para o cluster EKS
aws eks update-kubeconfig --region us-east-1 --name dvn-workshop-eks-cluster
```

## 🏃‍♂️ Executando Localmente

### Backend
```bash
cd dvn-workshop-apps/backend/YoutubeLiveApp
dotnet restore
dotnet run
```
A API estará disponível em: `http://localhost:5000/backend`
Swagger UI: `http://localhost:5000/backend/swagger`

### Frontend
```bash
cd dvn-workshop-apps/frontend/youtube-live-app
npm install
npm run dev
```
A aplicação estará disponível em: `http://localhost:3000`

## 🐳 Executando com Docker

### Backend
```bash
cd dvn-workshop-apps/backend/YoutubeLiveApp
docker build -t youtube-live-backend .
docker run -p 80:80 youtube-live-backend
```

### Frontend
```bash
cd dvn-workshop-apps/frontend/youtube-live-app
docker build -t youtube-live-frontend .
docker run -p 80:80 youtube-live-frontend
```

## 🔄 CI/CD Pipeline

O projeto utiliza GitHub Actions para automatizar o processo de build e deploy:

### Pipeline do Backend (`.github/workflows/backend-pipeline.yml`)
1. **Checkout** do código
2. **Configuração** das credenciais AWS
3. **Login** no Amazon ECR
4. **Build e Push** da imagem Docker
5. **Atualização** do repositório GitOps com Kustomize

### Pipeline do Frontend (`.github/workflows/frontend-pipeline.yml`)
1. **Checkout** do código
2. **Configuração** das credenciais AWS
3. **Login** no Amazon ECR
4. **Build e Push** da imagem Docker
5. **Atualização** do repositório GitOps com Kustomize

### Variáveis Necessárias no GitHub

Configure as seguintes variáveis no seu repositório GitHub:

**Variables:**
- `AWS_REGION`: us-east-1
- `AWS_ROLE_TO_ASSUME`: arn:aws:iam::148761658767:role/Workshop-role

**Secrets:**
- `PAT`: Personal Access Token para acesso ao repositório GitOps

## 🌐 Infraestrutura AWS

### Recursos Criados

#### Networking Stack
- **VPC**: `dvn-workshop-vpc` (10.0.0.0/24)
- **Subnets Públicas**: 
  - us-east-1a (10.0.0.0/26)
  - us-east-1b (10.0.0.64/26)
- **Subnets Privadas**:
  - us-east-1a (10.0.0.128/26)
  - us-east-1b (10.0.0.192/26)
- **Internet Gateway** e **NAT Gateway**
- **Route Tables** públicas e privadas

#### EKS Cluster Stack
- **Cluster EKS**: `dvn-workshop-eks-cluster` (v1.33)
- **Node Group**: 2 instâncias t3.medium
- **ECR Repositories**:
  - `dvn-workshop/production/backend`
  - `dvn-workshop/production/frontend`
- **IAM Roles** e políticas necessárias
- **AWS Load Balancer Controller**

#### Remote State Backend
- **S3 Bucket**: `workshop-s3-remote-backend-bucket`
- **DynamoDB Table**: `workshop-s3-state-locking-table`

## 🔧 Configurações Importantes

### Health Checks
O backend inclui health checks disponíveis em `/backend/health`

### Roteamento
- Backend configurado para responder em `/backend/*`
- Frontend serve na raiz `/`

### Logs do EKS
Habilitados os seguintes tipos de log:
- API Server
- Audit
- Authenticator
- Controller Manager
- Scheduler

## 📚 Estrutura de Diretórios

```
dvn-workshop/
├── .github/
│   └── workflows/
│       ├── backend-pipeline.yml
│       └── frontend-pipeline.yml
├── dvn-workshop-apps/
│   ├── backend/
│   │   └── YoutubeLiveApp/
│   │       ├── Controllers/
│   │       ├── Properties/
│   │       ├── Dockerfile
│   │       ├── Program.cs
│   │       └── YoutubeLiveApp.csproj
│   └── frontend/
│       └── youtube-live-app/
│           ├── src/
│           ├── public/
│           ├── Dockerfile
│           ├── package.json
│           └── next.config.mjs
└── dvn-workshop-terraform/
    ├── 00-remote-state-backend-stack/
    ├── 01-networking-stack/
    └── 02-eks-cluster-stack/
```

## 🤝 Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto é um workshop educacional para demonstrar práticas de DevOps na nuvem.

## 📞 Suporte

Para dúvidas ou suporte, abra uma issue no repositório do projeto.

---

**Desenvolvido para o Workshop DevOps na Nuvem** 🚀