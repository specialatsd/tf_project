# 개요
- 테라폼 연습 - IaC실습
- EC2 구성
- 문법

# 구조
## 기본 구성
- *.tf : 테라폼 파일
- * : 이름 제한 x => 서비스 혹은 기능 혹은 커스텀 의미 부여 가능
- *.tfvars : 테라폼 환경변수 -> 외부에서 세팅하는 기본값
```
/basic
L provider.tf
L terraform.tfvars
L variables.tf
L main.tf
L outputs.tf
L .gitignore
```

## 인프라 구성 핵심 절차
- 인프라 코드가 있는 위치로 이동(단 옵션부여로 경로지정 가능)
```
cd basic
```
- step1 : 테라폼 초기화
```
terraform init
```
결과물 체크
- .terraform/~ : 공급자 플러그인, 바이너리, 모듈, 정보등 생성
- .terraform.lock.hcl : 프로바이더 모듈의 지정한 버전, 해시값 잠금 관리 -> 안정적 관리, 자동생성시 체킹 용도 활용
```

- step2 : 문법 검사(체킹)
```
terraform validate
```
- 옵션 : 형식 맞추기
```
terraform fmt
```
- step3 : 실행 계획 확인(플래닝, 시뮬레이션)
```
terraform plan
---
data.aws_vpc.default: Reading...
data.aws_vpc.default: Read complete after 1s [id=vpc-0eebee125226fd6c5]
data.aws_subnets.default: Reading...
data.aws_subnets.default: Read complete after 0s [id=ap-northeast-2]

Changes to Outputs:
  + default_subnets_ids = [
      + "subnet-049c8f72bb109a11e",
      + "subnet-0cc79271aae2ac523",
      + "subnet-0928223142a64ef05",
      + "subnet-011432f9b62dee9b6",
    ]
  + default_vpc_ids     = "vpc-0eebee125226fd6c5"

You can apply this plan to save these new output values to the Terraform state, without changing any real
infrastructure.

---
data.aws_subnets.default: Reading...
data.aws_subnets.default: Read complete after 0s [id=ap-northeast-2]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # aws_security_group.ai-cp2-06-sg will be created
  + resource "aws_security_group" "ai-cp2-06-sg" {
      + arn                    = (known after apply)
      + description            = "ai-cp2-06 security group"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
                # (1 unchanged attribute hidden)
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTP"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
          + {
              + cidr_blocks      = [
                  + "222.108.125.33/32",
                ]
              + description      = "SSH"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = "ai-cp2-06-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "ap-northeast-2"
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = "vpc-0eebee125226fd6c5"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + default_subnets_ids = [
      + "subnet-049c8f72bb109a11e",
      + "subnet-0cc79271aae2ac523",
      + "subnet-0928223142a64ef05",
      + "subnet-011432f9b62dee9b6",
    ]
  + default_vpc_ids     = "vpc-0eebee125226fd6c5"
    ----
    data.aws_ami.amazon_linux: Read complete after 0s [id=ami-05d406896d0284d57]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.ai-cp2-06-ec2 will be created
  + resource "aws_instance" "ai-cp2-06-ec2" {
      + ami                                  = "ami-05d406896d0284d57"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + enable_primary_ipv6                  = (known after apply)
      + force_destroy                        = false
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "ai-cp2-06-key"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_group_id                   = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + region                               = "ap-northeast-2"
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = "subnet-049c8f72bb109a11e"
      + tags                                 = {
          + "Name" = "ai-cp2-06-ec2"
        }
      + tags_all                             = {
          + "Name" = "ai-cp2-06-ec2"
        }
      + tenancy                              = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification (known after apply)

      + cpu_options (known after apply)

      + ebs_block_device (known after apply)

      + enclave_options (known after apply)

      + ephemeral_block_device (known after apply)

      + instance_market_options (known after apply)

      + maintenance_options (known after apply)

      + metadata_options (known after apply)

      + network_interface (known after apply)

      + primary_network_interface (known after apply)

      + private_dns_name_options (known after apply)

      + root_block_device (known after apply)

      + secondary_network_interface (known after apply)
    }

  # aws_security_group.ai-cp2-06-sg will be created
  + resource "aws_security_group" "ai-cp2-06-sg" {
      + arn                    = (known after apply)
      + description            = "ai-cp2-06 security group"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
                # (1 unchanged attribute hidden)
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "HTTP"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
          + {
              + cidr_blocks      = [
                  + "222.108.125.33/32",
                ]
              + description      = "SSH"
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
        ]
      + name                   = "ai-cp2-06-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + region                 = "ap-northeast-2"
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = "vpc-0eebee125226fd6c5"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + aws_ami_amazon_linux_id = "ami-05d406896d0284d57"
  + default_subnets_ids     = [
      + "subnet-049c8f72bb109a11e",
      + "subnet-0cc79271aae2ac523",
      + "subnet-0928223142a64ef05",
      + "subnet-011432f9b62dee9b6",
    ]
  + default_vpc_ids         = "vpc-0eebee125226fd6c5"

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if
you run "terraform apply" now.
```
- step4 : 테라폼 적용 (실제 생성)
```
terraform apply
```
생성후 접속 테스트
    - 호스트 IP 변경: ec2 인스턴스 대시보드로 확인
    - 사용자 변경 : ec2-user
```
- step5 : 테라폼 삭제
```
terraform 
```

# 목표 인프라 시스템
```
Internet
    |
    |
Elastic IP          <- 리소스 할당 생성
    |
    EC2
AMzonLinux 2        <- 아마존 리눅스 사용/ ec2-user
    |
Security Group      <- 보안 그룹 , 인바운드(ssh-22), 아웃바운드(전체)
    |
VPC(Default)        <- 클라우드내 사설 클라우드, 기본(default)를 사용
```