
### #1 Set up GitHub Secrets
**AWS_ACCESS_KEY_ID** - &#x3c;AWS user API key&#62;

**AWS_SECRET_ACCESS_KEY** - &#x3c;AWS user secret access key&#62;

**AWS_REGION** - &#x3c;AWS Region&#62;
  
**AWS_STATE_BUCKET_NAME** - &#x3c;AWS S3 Bucket global unique name where remote state will be stored&#62; (def: *my-users-app-2021-tfstate*)

**AWS_STATE_BUCKET_PATH** - &#x3c;AWS S3 Bucket path to remote state file&#62; (def: *apps/backend/app.state*)

**AWS_STATE_DB_TABLE** - &#x3c;AWS DynamoDB table name for a remote state&#62; (def: *apps-backend-tfstatelock*)

**REGISTRY_LOGIN_URL** - &#x3c;container registry login url&#62;

**REGISTRY_USERNAME** - &#x3c;container registry username&#62;

**REGISTRY_PASSWORD** - &#x3c;container registry user password&#62;



### #2 Set up & deploy remote state backend
Make commit to **/.github/workflows/terraform-remote-state.yml** with commit message "**init**" in order to deploy backend for remote state.


### #3 Run CI/CD pipelines
Make commit to **/backend** or **/frontend folder** in order to run CI/CD pipelines.


## #4 Destroy everything & clean up
