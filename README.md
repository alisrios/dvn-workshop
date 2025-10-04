# Projeto de Infraestrutura como Código com Terraform na AWS

Este projeto provisiona uma infraestrutura de rede na AWS usando Terraform. Ele é dividido em duas stacks principais:

## Stacks

### 00-remote-state-backend-stack

Esta stack é responsável por criar a infraestrutura para o armazenamento do estado remoto do Terraform. Ela cria:

-   **Bucket S3**: Para armazenar o arquivo `terraform.tfstate`.
-   **Tabela DynamoDB**: Para o bloqueio de estado (state locking), garantindo que apenas um usuário possa aplicar alterações por vez.

### 01-networking-stack

Esta stack provisiona a infraestrutura de rede e utiliza o backend S3 configurado pela stack anterior. Os recursos criados incluem:

-   **VPC**: Uma Virtual Private Cloud para isolar os recursos da AWS.
-   **Sub-redes Públicas e Privadas**: Para separar os recursos com base em sua necessidade de acesso à internet.
-   **Internet Gateway**: Para permitir o acesso à internet para os recursos nas sub-redes públicas.
-   **NAT Gateway**: Para permitir que os recursos nas sub-redes privadas acessem a internet sem serem expostos diretamente.
-   **Tabelas de Rotas**: Para controlar o fluxo de tráfego dentro da VPC.
-   **Elastic IPs**: Para os NAT Gateways.

## Como usar

1.  **Configure suas credenciais da AWS**: Certifique-se de que suas credenciais de acesso à AWS estejam configuradas corretamente no ambiente em que você executará o Terraform.

2.  **Provisione o Backend Remoto**:
    -   Navegue até o diretório `00-remote-state-backend-stack`.
    -   Execute `terraform init`.
    -   Execute `terraform apply`.

3.  **Provisione a Stack de Rede**:
    -   Navegue até o diretório `01-networking-stack`.
    -   Execute `terraform init`. O Terraform será configurado para usar o backend S3 criado na etapa anterior.
    -   Execute `terraform apply`.

## Pré-requisitos

-   [Terraform](https://www.terraform.io/downloads.html) instalado.
-   [AWS CLI](https://aws.amazon.com/cli/) instalado e configurado.
-   Uma conta na AWS com as permissões necessárias para criar os recursos descritos.
