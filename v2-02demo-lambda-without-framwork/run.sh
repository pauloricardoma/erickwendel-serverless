# 1o criar arquivo de politicas de seguranca
# 2o atachar a role para a nossa lambda
aws --version

ROLE_NAME=lambda-example
NODEJS_VERSION=nodejs16.x
FUNCTION_NAME=hello-cli-2

mkdir -p logs

aws iam create-role \
  --role-name $ROLE_NAME \
  --assume-role-policy-document file://policies.json \
  | tee logs/1.role.log

POLICY_ARN="arn:aws:iam::678492497133:role/lambda-example"
POLICY_ARN=$(cat logs/1.role.log | jq -r .Role.Arn)

# 3o criar o arquivo
# 4o zipar o projeto
zip function.zip index.js

aws lambda create-function \
  --function-name $FUNCTION_NAME \
  --zip-file fileb://function.zip \
  --handler index.handler \
  --runtime $NODEJS_VERSION \
  --role $POLICY_ARN \
  | tee logs/2.lambda-create.log

sleep 1

aws lambda invoke \
  --function-name $FUNCTION_NAME logs/3.lambda-exec.log \
  --log-type Tail \
  --query 'LogResult' \
  --output text | base64 -d

# atualizar
zip function.zip index.js

aws lambda update-function-code \
  --zip-file fileb://function.zip \
  --function-name $FUNCTION_NAME \
  --publish \
  | tee logs/4.lambda-update.log

aws lambda invoke \
  --function-name $FUNCTION_NAME logs/5.lambda-exec-update.log \
  --log-type Tail \
  --query 'LogResult' \
  --cli-binary-format raw-in-base64-out \
  --payload '{"name":"pauloricardo"}' \
  --output text | base64 -d

# deletar function and role
aws lambda delete-function \
  --function-name $FUNCTION_NAME \
  | tee logs/6.lambda-rm.log

aws iam delete-role \
  --role-name $ROLE_NAME