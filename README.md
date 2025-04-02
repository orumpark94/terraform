
# AWS에 Terraform을 이용하여 EC2 인스턴스 생성 및 웹서버(Nginx) 배포

# 구성 목표

Git Action을 이용하여 AWS 인스턴스를 구축하고, 그 안에 웹서버를 구축하는 것을 목적으로 한다.

Git Action / AWS / Terraform 사용 예정

![image](https://github.com/user-attachments/assets/f9363824-1f29-42fb-96dd-1340d4ca7ce1)


# 구성 목표

Git Action을 이용하여 AWS 인스턴스를 구축하고, 그 안에 웹서버를 구축하는 것을 목적으로 한다.

Git Action / AWS / Terraform 사용 예정


# 구성 순서도

1. Git Action과 AWS 계정간의 연동 진행 및 deploy.yaml 파일 작성을 통하여 AWS 인스턴스 배포 코드 작성

2. AWS에 배포하고자 하는 인스턴스에 대한 코드 작성 (main.tf variables.tf)

# 실행 결과

코드 실행 내역 

![image](https://github.com/user-attachments/assets/af04c1ad-a8d0-41de-8c94-215ab2905662)


배포 진행된 EC2 instance 및 네트워크 설정

![image](https://github.com/user-attachments/assets/8c5b5211-1663-478c-9be1-610f835d6705)
![image](https://github.com/user-attachments/assets/deb5f9e4-badd-4bd4-90bf-53714ab20e30)
![image](https://github.com/user-attachments/assets/db388fe2-28ca-425e-972c-e66298513917)


# 주의 사항

기본적으로 GitHub에서 Action으로 실행되는 task는 Github가 제공하는 VM머신에서 실행되며 해당 VM 머신은 사용된 후 삭제되기에 #terraform destroy 같은 명령을 실행할 수 없다.
이유는 VM 머신이 실행된 후 자동 삭제 되기에 Terraform의 상태 파일인 terraform.tfstate 또한 삭제되기는 것이 원인이이다.  
