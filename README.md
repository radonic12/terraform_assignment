# terraform_assignment

To be able to use the code in main.tf to change you aws account-settings please follow the following steps:
1. Install terraform
2. Run the command <pre><code>terraform init</pre></code>
3. Set you aws credentials using the following commands <pre><code>export AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID></pre></code> and <pre><code>export AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY> </pre></code>
4. Run the following command and verify that the palnned changes are correct <pre><code>terraform plan</pre></code> 
5. Run the command <pre><code>terraform apply</pre></code> 
