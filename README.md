# miniproject-LEWIS-LINDY

## prerequisites

1. Ruby
2. Bundler gem


## how to run

```
git clone https://github.com/stelligent/miniproject-LEWIS-LINDY.git  
cd miniproject-LEWIS-LINDY
bundle install
ruby pipeline.rb deploy
```


## what is running

- The ```ruby pipeline.rb deploy``` command launches a CloudFormation stack  
- The default stack name is 'StelligentProjectCFStack'  
- The CloudFormation stack provisions a VPC, subnet, Internet gateway, and an
ELB with an ASG  
- User data is provided to the ASG's Launch Configuration and calls cfn-init to
provision an Apache server
- CFN Init installs the apache web server in the default Apache location
- The ASG registers with the ELB
- The acceptance tests are run against the ELB's URL
- The acceptance tests ensure that the ELB is responding with http 200 code  
and that the desired content is returned in the html body
- The ELB's URL and physical resource name can be found as outputs on the  
  CloudFormation stack
- The pipeline queries these CFN outputs and uses them to schedule and coordinate  
the acceptance tests
- The acceptance tests are automatically run against the newly created stack after  
immediately after the stack is deployed.

## how to cleanup

`ruby pipeline.rb cleanup`

## tests

Calling ```ruby pipeline.rb deploy``` will deploy the stack and then run the
  acceptance test against the newly deployed stack.

The acceptance test can be run at any time the stack is running with the following command:

```ruby pipeline.rb test```
