# 각종 정보 출력 용도, 통상적으로 인프라 구성 후 결과물 값을 출력하는 용도로 활용
# 1. vpc 정보 출력
output "default_vpc_ids" {
    description = "서울 리전의 기본 vpc의 id"
    value = data.aws_vpc.default.id 
}

# 2. 서브넷 정보 출력
output "default_subnets_ids" {
    description = "서울 리전의 기본 vpc에 속한 서브넷들의 id 리스트"
    value = data.aws_subnets.default.ids  
}