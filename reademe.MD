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
- step2 : 문법 검사(체킹)
```
terraform validate
```
- step3 : 실행 계획 확인(플래닝, 시뮬레이션)
```
terraform plan
```
- step4 : 테라폼 적용 (실제 생성)
```
terraform apply
```
- step5 : 테라폼 삭제
```
terraform 
```