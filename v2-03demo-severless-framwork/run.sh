# instalar
npm i -g serverless@3.16.0

# sls ou serverless para inicializar
sls 
# escolhi o HTTP API TEMPLATE
# nao usei org
# deploy yes

# sempre que mudou o código, dentro da pasta criada usa o
sls deploy

# traz endereços e informações sobre as funções
sls info

# invocar local / não precisa --logs, que ele ja mostra os logs
sls invoke local -f hello

# invocar em prod
sls invoke -f hello

# configurar o serverless dashboard
sls
# Deploy yes

# matar todo mundo!
sls remove