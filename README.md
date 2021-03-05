

### #1 Set up GitHub Secrets

 - AWS_ACCESS_KEY_ID - &#x3c;AWS user API key&#62;    
 - AWS_SECRET_ACCESS_KEY - &#x3c;AWS user secret access key&#62;     
 - REGISTRY_USERNAME - &#x3c;container registry username&#62;    
 - REGISTRY_PASSWORD - &#x3c;container registry user password&#62;

### #2 Set up & deploy remote state backend
Clone the repository to a local machine.

Export env variables:
```
export AWS_REGION="<aws region>"
export AWS_ACCESS_KEY_ID="<aws acesss key>"
export AWS_SECRET_ACCESS_KEY="<aws secret access key>"
```

Go to **&#x3c;project repository&#62;/terraform/remote_state/** and run a command: **terraform apply** in order to deploy a remote state backend.


### #3 Run CI/CD pipelines
Make commit to **/backend** or **/frontend folder** in order to run CI/CD pipelines.


### #4 Destroy everything & clean up

 - **Destroy backend & frontend deployments:**
 
   Make commit to **/.github/workflows/terraform-destroy.yml** with commit message "**destroy**" in order destroy **backend** & **frontend** deployments.
   

 - **Destroy a remote state:**
 
   On your local machine go to: **&#x3c;project repository&#62;/terraform/remote_state/** and run a command: **terraform destroy** in order to destroy a remote state deployment.

   Alternatively you can remove manually **DynamoDb table** where is stored deployment locks and **S3 bucket** where is stored remote deployment state files.

