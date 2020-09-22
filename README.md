# RackSpace-DevOps
Launch a simple web site in a load balanced and highly available manner utilizing automation and AWS best practices

We are using Terraform and Packer in below example 
```
https://www.terraform.io/
https://www.packer.io/
```
cd s3
```
terraform init
terraform plan
terraform apply 
```
cd iam
```
terraform init
terraform plan
terraform apply 
```

cd Packer
```
packer build packer.json # use ami values inside vars.tf
```

cd Infra # set values inside vars.tf 
```
terraform init
terraform plan
terraform apply 
```

