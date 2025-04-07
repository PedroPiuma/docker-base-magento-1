![Magento 1](https://cdn.rawgit.com/rafaelstz/magento2-snippets-visualstudio/master/images/icon.png)

# Magento 1 Docker com PHP 7.4

Este é um projeto Docker para desenvolvimento com Magento 1 utilizando PHP 7.4. Ele foi configurado para facilitar o desenvolvimento local, incluindo ferramentas como PHPMyAdmin, MailHog e suporte ao XDebug.

## Tecnologias Utilizadas

- **PHP 7.4**: Versão do PHP compatível com o Magento 1.
- **Apache 2**: Servidor web configurado para o Magento.
- **MariaDB**: Banco de dados para armazenar os dados do Magento.
- **PHPMyAdmin**: Interface gráfica para gerenciar o banco de dados.
- **MailHog**: Ferramenta para capturar e-mails enviados localmente.
- **XDebug**: Ferramenta para depuração de código PHP.
- **Magerun**: Ferramenta CLI para gerenciar o Magento.

---

## Pré-requisitos

Certifique-se de ter as seguintes ferramentas instaladas no seu sistema:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

---

## Como Usar

### 1. Clone o Repositório

```bash
git clone <URL_DO_REPOSITORIO>
cd <URL_DO_REPOSITORIO>
```

### 2. Configure o Arquivo `.env`

Edite o arquivo `.env` para ajustar as configurações do projeto, como portas, credenciais do banco de dados e nome do projeto. Um exemplo de configuração está disponível no arquivo `.env.example`.

### 3. Inicie o Ambiente

Execute o comando abaixo para iniciar os containers:

```bash
./start.sh
```

**Sugestão**: Se quiser testar o Docker antes de adicionar seu projeto Magento na pasta `src`, crie um arquivo `index.php` com o seguinte conteúdo para verificar o ambiente:

```php
<?php
phpinfo();
```

Acesse [http://localhost](http://localhost) para visualizar as informações do PHP.

### 4. Acesse os Serviços

- **Magento**: [http://localhost](http://localhost)
- **PHPMyAdmin**: [http://localhost:8080](http://localhost:8080)
- **MailHog**: [http://localhost:8025](http://localhost:8025)

---

## Comandos Disponíveis

| Comando         | Descrição                                                                 | Exemplo                     |
|------------------|---------------------------------------------------------------------------|-----------------------------|
| `./start.sh`     | Inicia os containers do projeto.                                          | `./start.sh`                |
| `./stop.sh`      | Para os containers do projeto.                                           | `./stop.sh`                 |
| `./kill.sh`      | Para os containers e remove volumes nomeados.                            | `./kill.sh`                 |
| `./shell.sh`     | Acessa o container do Apache.                                            | `./shell.sh`                |
| `./n98.sh`       | Executa comandos do Magerun no container.                                | `./n98.sh cache:clean`      |
| `./xdebug.sh`    | Ativa ou desativa o XDebug no container.                                 | `./xdebug.sh`               |

---

## Estrutura do Projeto

```plaintext
docker-base-magento-1/
├── .docker/
│   ├── bin/
│   │   ├── xdebug.sh
│   ├── config/
│   │   ├── custom-xdebug.ini
│   │   ├── magento.conf
│   │   ├── opcache.ini
│   │   ├── php.ini
│   ├── users/
│       ├── .bashrc
│       ├── local.xml.sample
├── src/                # Código-fonte do Magento
├── .env                # Configurações do ambiente
├── docker-compose.yml  # Configuração do Docker Compose
├── Dockerfile          # Configuração da imagem do Apache + PHP
├── kill.sh             # Script para parar e remover volumes
├── n98.sh              # Script para executar n98 associado com seus parâmetros
├── shell.sh            # Script para acessar o shell do container
├── start.sh            # Script para iniciar os containers
├── stop.sh             # Script para parar os containers
├── xdebug.sh           # Script para ativar ou desativar o XDebug no container 
└── README.md           # Documentação do projeto
```

---

## Configurações Importantes

### Arquivo `.env`

Certifique-se de configurar corretamente as variáveis no arquivo `.env`. Aqui está um exemplo:

```bash
# Configurações gerais
PROJECT_NAME=magento_1
NETWORK_NAME=MYMAGENTO-network

# Configurações do Apache
APACHE_HTTP_PORT=80
APACHE_HTTPS_PORT=443
XDEBUG_PORT=9001

# Configurações do banco de dados
DB_IMAGE=mariadb
DB_PORT=3300
DB_NAME=magento
DB_USER=magento
DB_PASSWORD=magento
DB_ROOT_PASSWORD=root

# Configurações do PHPMyAdmin
PHPMYADMIN_PORT=8080

# Configurações do MailHog
MAILHOG_SMTP_PORT=1025
MAILHOG_WEB_PORT=8025
```

---

## Painéis Disponíveis

- **Web Server**: [http://localhost](http://localhost)
- **PHPMyAdmin**: [http://localhost:8080](http://localhost:8080)
- **MailHog**: [http://localhost:8025](http://localhost:8025)

---

Este projeto foi inspirado na imagem Docker disponível em [rafaelcgstz/magento1](https://hub.docker.com/r/rafaelcgstz/magento1), que oferece uma base sólida para o desenvolvimento com Magento 1.

## Licença

MIT © 2025 [Pedro Piuma](https://github.com/pedro-piuma).
