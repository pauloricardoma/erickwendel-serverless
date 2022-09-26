# criando s3 bucket
aws s3api create-bucket --bucket ew-hello-bucket

# copiando arquivo para o bucket
aws s3 cp hello.txt s3://prma-hello-bucket
aws s3 cp s3://prma-hello-bucket/hello.txt h.txt

# apagando primeiro tudo que tem dentro do bucket
# exluindo o bucket
aws s3 rm s3://prma-hello-bucket --recursive
aws s3api delete-bucket --bucket prma-hello-bucket