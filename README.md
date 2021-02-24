

### #1 Set up GitHub Secrets

 - **AWS_ACCESS_KEY_ID** - &#x3c;AWS user API key&#62;    
 - **AWS_SECRET_ACCESS_KEY** - &#x3c;AWS user secret access key&#62;    
 - **AWS_REGION** - &#x3c;AWS Region&#62;       
 - **AWS_STATE_BUCKET_NAME** - &#x3c;AWS S3 Bucket global unique name where remote state will be stored&#62; (def: *my-users-app-2021-tfstate*)    
 - **AWS_STATE_BUCKET_PATH** - &#x3c;AWS S3 Bucket path to remote state file&#62; (def: *apps/backend/app.state*)    
 - **AWS_STATE_DB_TABLE** - &#x3c;AWS DynamoDB table name for a remote state&#62; (def: *apps-backend-tfstatelock*)    
 - **REGISTRY_LOGIN_URL** - &#x3c;container registry login url&#62;   
 - **REGISTRY_USERNAME** - &#x3c;container registry username&#62;    
 -  **REGISTRY_PASSWORD** - &#x3c;container registry user password&#62;

### #2 Set up & deploy remote state backend
Clone the repository to a local machine.
Go to **&#x3c;project repository&#62;/terraform/remote_state/** and run a command: **terraform apply** in order to deploy a remote state backend.


### #3 Run CI/CD pipelines
Make commit to **/backend** or **/frontend folder** in order to run CI/CD pipelines.


### #4 Destroy everything & clean up

 - **Destroy a remote state:**
 
   On your local machine go to: **&#x3c;project repository&#62;/terraform/remote_state/** and run a command: **terraform destroy** in order to destroy a remote state deployment.

 - **Destroy backend & frontend deployments:**
 
   Make commit to **/.github/workflows/terraform-destroy.yml** with commit message "**destroy**" in order destroy **backend** & **frontend** deployments

