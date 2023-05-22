# Teste SRE Lion

## Observações:
> **Obs:** Liberei as portas somente para o meu IP no SG.
> **Obs:** Alguns recursos criei via AWS CLI.
> **Obs:** O repositório está privado, então sinta-se à vontade para testar
> **Obs:** VPC padrão
> **Obs:** SG padrão

## Config Terraform
- Criação do S3 para backend
- Criação do bucket para backend
- Crie o recurso que você precisa criar
> **Obs:** Separeo os **AMBIENTES** do TF utilizando o terraform workspace e os referencio na chave do Bucket
> **Obs:** Em ambientes de produção, eu prefiro criar o arquivo "backend.tfvars" para facilitar a reutilização dos códigos tf
> **Obs:** O user_data da instância está configurando basicamente tudo o que é necessário. Tentei automatizar a configuração do Runner mas há um token dinâmico gerado pelo Github.

- Referencie o módulo do recurso com as variáveis que irá utilizar para criá-lo:
### e.g.: Instância EC2
```
module "ec2" {
  source                 = "../../../modules/ec2"
  name                   = "nome_da_instancia"
  instance_count         = <numeral quantidade de instancias>
  ami                         = "<AMI ID>"
  key_name                    = "<keyname>"
  instance_type               = "<tipo da instancia>"
  monitoring                  = true
  vpc_security_group_ids      = ["<SG1>","<SG2>","<SG3>"]
  subnet_id                   = "<SUBETNETID>"
  associate_public_ip_address = true
  user_data                  = "${file("user_data.sh")}"
  root_block_device = [{
    volume_type = "<TIPO_DO_VOLUME(gp2,gp3)>"
    volume_size = <numeral GB de disco>
  }]
}
```
- Comandos TF:
```
$ terraform init
$ terraform workspace new <nome_do_workspace>
$ terraform plan
$ terraform apply
```

## Acesso às apps e monitoramento Grafana

| App      |      Pub Acess      |
|----------|-------------|
| Vote |  http://34.228.187.92:31000/ |
| Result |http://34.228.187.92:31001/|
| Grafana |http://34.228.187.92:3000/|

> **Obs:**
Rodar:
```
microk8s kubectl port-forward -n observability service/kube-prom-stack-grafana --address 0.0.0.0 3000:3000
```
Para acessar o grafana

## Alerta criado
Configurei o seguinte alerta:
http://34.228.187.92:3000/alerting/7pN4F7w4z/edit?returnTo=%2Falerting%2Fgrafana%2F7pN4F7w4z%2Fview%3FreturnTo%3D%252Falerting%252Flist

Quando não há Réplicas no deployment Vote (interface de voto). Um alerta no grafana é criado. Configurei para enviar para o time de Monit (meu email. Porém configuração de SMTP precisa ser realizada no grafana).

## CI/CD
[Actions de deploy do Voting App](https://github.com/matheusleaao/teste-lion-sre/blob/master/.github/workflows/deploy-vote.yaml)

### Processo
- Autenticação com a aws
> **Obs:** prefiro usar assume-roles para autenticação, principalmente quando o serviço roda numa instância EC2. No caso precisei configurar o secret no k8s e aws configure na instancia
- Conteúdo da aplicação sendo enviada para o ~/app do user ubuntu
- Build do Vote: Docker build, tag e push para o ECR com o hash do commit
- Deploy: replace da nova imagem no deployment e k apply
> **Obs:** Meu teste de entrega da app foi alterar a cor do botão no CSS

# Qualquer coisa estou aqui