
# AWS에 Terraform을 이용하여 EC2 및 RDS 생성, 네트워크 구성 TEST

# 구성 목표

Git Action,Terraform을 이용하여 AWS 인스턴스를 구축하는 것을 목적으로 한다.

Git Action / AWS / Terraform 사용 예정

![image](https://github.com/user-attachments/assets/4f117912-c256-4eb9-8759-90084aeafe10)

# 사용 기술 스택

CI/CD: GitHub Actions, Terraform
인프라: AWS EC2, VPC, RDS

# 구성 순서도

1. Git Action과 AWS 계정간의 연동 진행 및 인스턴스 배포를 위한 code 작성을 통하여 AWS 인스턴스 배포

# 실행 결과

코드 실행 내역 

![image](https://github.com/user-attachments/assets/e759d23b-4050-4be3-8d5a-afba82d2868b)

정상적으로 배포 완료 (상세 내역 코드 레포지토리 내 업로드된 코드 참조)

배포 진행된 EC2, RDS, 네트워크 설정

![image](https://github.com/user-attachments/assets/493055b4-3e01-4433-bec1-2497ae0cdb67)
![image](https://github.com/user-attachments/assets/a9d93844-72b0-4255-bdf4-912a10860b35)
![image](https://github.com/user-attachments/assets/9b47a7f3-8ffa-4278-b23d-e17a375cadd4)


# 주의 사항

1. 기본적으로 GitHub에서 Action으로 실행되는 task는 Github가 제공하는 VM머신에서 실행되며 해당 VM 머신은 사용된 후 삭제되기에 #terraform destroy 같은 명령을 실행할 수 없다.
이유는 VM 머신이 실행된 후 자동 삭제 되기에 Terraform의 상태 파일인 terraform.tfstate 또한 삭제되기는 것이 원인이이다.
이 문제를 해결하기 위하여 S3 버킷을 사용하여 terraform.tfstate를 저장하였고, 이를 이용하여 destroy도 가능하게 끔 설정하였다.

3. web 서버의 경우 외부에 노출되는 public subnet으로 구성하였다, db의 경우는 외부에 노출되면 안되기에 별도의 private subnet으로 구성하였고, RDS의 경우에는 가용성 확보를 위한 리전 이중화 및 서브넷 이중화를 적용해야지만 생성된다.

4. 현재 구성의 경우 단순 test이기에 권한을 넉넉하게 줬지만, 기본적으로 db에 관련된 구성을할때는 각 iam 사용자별 권한에 대한 설정을 제대로 구성하여야 한다.

   
