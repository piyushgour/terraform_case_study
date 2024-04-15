# Case Study | Cloud Migration

Clone the repo
------------------

```
# git clone https://github.com/piyushgour/linux-admin-task.git
```


## Prerequisites 
 - provider.tf contains only provider information.
 - 'aws configure' configure aws cred's that has permission to depoly AWS Resources.
 - install terraform latest version for cli commands. 


Change the working directory 
------------------

```
# cd case_study
# ls 
```

Output looks like -
```
README.md  asg.tf  ec2.tf  elb.tf  iam_user.tf  provider.tf  user_data.sh*  variables.tf  vpc.tf

```

Working with Terraform  
--------------------

first we need to basic command for creating executable environment.

Update **provider.tf** value according to you target region and terraform backend.
```
# terraform init 
```

Output looks like -
```

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v5.45.0

Terraform has been successfully initialized!
```


Execute Terraform Command
------------------

Update **variables.tf** value according to your **VPC CIDR, SUBNET CIDR, AMI-ID** etc.

```
# terraform plan 

```

Output looks like :
```
...
+ tags                                           = {
          + "Application" = "Web Server"
          + "Environment" = "Test"
          + "Name"        = "Web_VPC_Subnet-2"
        }
      + tags_all                                       = {
          + "Application" = "Web Server"
          + "Environment" = "Test"
          + "Name"        = "Web_VPC_Subnet-2"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_vpc.web_vpc will be created
  + resource "aws_vpc" "web_vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "20.20.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Application" = "Web Server"
          + "Environment" = "Test"
          + "Name"        = "Web_VPC"
        }
      + tags_all                             = {
          + "Application" = "Web Server"
          + "Environment" = "Test"
          + "Name"        = "Web_VPC"
        }
    }

Plan: 17 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + alb_public_url = (known after apply)

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" 
now.

```
```
# terraform apply 

```
Output looks like :
```
...
  + tags_all                                       = {
          + "Application" = "Web Server"
          + "Environment" = "Test"
          + "Name"        = "Web_VPC_Subnet-2"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_vpc.web_vpc will be created
  + resource "aws_vpc" "web_vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "20.20.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Application" = "Web Server"
          + "Environment" = "Test"
          + "Name"        = "Web_VPC"
        }
      + tags_all                             = {
          + "Application" = "Web Server"
          + "Environment" = "Test"
          + "Name"        = "Web_VPC"
        }
    }

Plan: 17 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + alb_public_url = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:

```
Update **YES/NO** value according 
- **yes** for apply all the changes. 
- **no** to deny the changes.


##### After type yes 

Output look like:

```
data.aws_instances.web_server_data: Reading...
aws_iam_user.web_server_user: Refreshing state... [id=web-server-user]
aws_vpc.web_vpc: Refreshing state... [id=vpc-04e2b284b3b25e794]
aws_iam_policy.web_server_restart: Refreshing state... [id=arn:aws:iam::926515726515:policy/web-server-restart-policy]
data.aws_instances.web_server_data: Read complete after 1s [id=us-east-1]
aws_internet_gateway.web_igw: Refreshing state... [id=igw-045210830cf482082]
aws_security_group.allow_web: Refreshing state... [id=sg-00d90e4d3207318be]
aws_lb_target_group.web_server: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-1:926515726515:targetgroup/web-server-target-group/8850cc7833e642ee]
aws_subnet.web_vpc_subnet[1]: Refreshing state... [id=subnet-08f773838b845f87c]
aws_subnet.web_vpc_subnet[0]: Refreshing state... [id=subnet-0e9f1d426c709b1e2]
aws_route_table.web_route_table: Refreshing state... [id=rtb-0b0698580828196df]
aws_launch_configuration.web_lc: Refreshing state... [id=web-server-lc]
aws_lb.web_balancer: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-1:926515726515:loadbalancer/app/web-load-balancer1/d69bbf6163eaea18]
aws_route_table_association.public_route_table_asso[1]: Refreshing state... [id=rtbassoc-004d6603953ce1d7b]
aws_route_table_association.public_route_table_asso[0]: Refreshing state... [id=rtbassoc-097c2301050d5fa83]
aws_autoscaling_group.web_asg: Refreshing state... [id=web-server-asg2]
aws_lb_target_group_attachment.web_server["i-069378d47c52dbe25"]: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-1:926515726515:targetgroup/web-server-target-group/8850cc7833e642ee-20240415151802222000000001]
aws_autoscaling_policy.web_cpu_scaling: Refreshing state... [id=web-server-cpu-scaling]
aws_lb_listener.web_listener: Refreshing state... [id=arn:aws:elasticloadbalancing:us-east-1:926515726515:listener/app/web-load-balancer1/d69bbf6163eaea18/8872950b32e7c13b]

```

Show all list created by Terraform:
----
```
# terraform state list
```
Output look like this:
```
data.aws_instances.web_server_data
aws_autoscaling_group.web_asg
aws_autoscaling_policy.web_cpu_scaling
aws_iam_policy.web_server_restart
aws_iam_user.web_server_user
aws_internet_gateway.web_igw
aws_launch_configuration.web_lc
aws_lb.web_balancer
aws_lb_listener.web_listener
aws_lb_target_group.web_server
aws_lb_target_group_attachment.web_server["i-069378d47c52dbe25"]
aws_route_table.web_route_table
aws_route_table_association.public_route_table_asso[0]
aws_route_table_association.public_route_table_asso[1]
aws_security_group.allow_web
aws_subnet.web_vpc_subnet[0]
aws_subnet.web_vpc_subnet[1]
aws_vpc.web_vpc
```



Clean-UP :
------------------------------
```
# terraform destroy 
```
Output look like:

```
...
   - instance_tenancy                     = "default" -> null
      - ipv6_netmask_length                  = 0 -> null
      - main_route_table_id                  = "rtb-085df8c48c347397b" -> null
      - owner_id                             = "926515726515" -> null
      - tags                                 = {
          - "Application" = "Web Server"
          - "Environment" = "Test"
          - "Name"        = "Web_VPC"
        } -> null
      - tags_all                             = {
          - "Application" = "Web Server"
          - "Environment" = "Test"
          - "Name"        = "Web_VPC"
        } -> null
    }

Plan: 0 to add, 0 to change, 17 to destroy.

Changes to Outputs:
  - alb_public_url = "web-load-balancer1-2142366054.us-east-1.elb.amazonaws.com" -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value:
```
Update **YES/NO** value according 
- **yes** for apply all the changes. 
- **no** to deny the changes.




## Authors

Originally created by [Piyush Gour](http://github.com/piyushgour)