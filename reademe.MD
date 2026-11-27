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
```
- step4 : 테라폼 적용 (실제 생성)
```
terraform apply
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