# Terraform Code

### Terraform example code

> 간단한 3-Tier 구조를 통해 알아보는 Code 샘플
> 가능한 Terraform에서 사용 가능한 형식의 블럭을 최대한 사용해볼수 있도록 구성
> Version별 폴더로 구성하여 자츰 코드를 다듬어 가는 과정을 표현

---

#### [ 폴더구성 및 설명 ]

1.  **`var_1_plaintext`**

    - **_`main.tf`_** 파일에 일괄적으로 생성하고자 하는 리소스 설정
      >

2.  **`var_2_plaintext`**

    - **_`main.tf`_** 파일 및 각 서비스 혹은 용도의 블럭을 나눠서 **`*.tf`** 파일로 구성
      >

3.  **`var_3_hierarchy`**

    - **`S3 bucket`** 을 사용하여 `terraform.tfstate`파일 관리 구성
    - `VPC`, `SG`, `EC2`, `ALB`, `RDS` 폴더에서 각각 **`생성/수정/삭제`** 가능하도록 구성
    - **`backend`** & **`output`** 활용법 확인
      >

4.  **`var_4_hierarchy`**

    - **`variable`** 사용하여 여러 block에서 사용하도록 구성
    - 반복적으로 사용 가능한 값을 변수로 생성하여 처리
    - **`function`** 사용
      >

5.  **`var_5_hierarchy`**
    - **`variable.tf`** 파일에서 `variable value` 를 **`terraform.tfvars`** 로 분리
    - **`terraform.tfvars`** 파일을 사용하여 변수 값을 변경(재사용성) 가능하게 설정
    - **`local`** block 사용하여 **`variable`** 값 가공하여 설정
      >

---

#### [ 시작전 사전 준비]

- **Terraform Command 실행을 위한 디바이스 환경 설정**

  - **Terraform 설치**

    - **Windows OS**

      - **[설치 파일 다운로드 및 설치](https://www.terraform.io/downloads) _(Link)_**

        >

      - **패키지 매니저 사용 설치**

        ```
        [실행창]
          cmd.exe
        ```

        ```
        [명령창]
          C:\ choco install terraform [설치 버전
        ```

    - **MAC OS**
      - **Homebrew _(설치 되어 있다면 Skip)_**
      - **패키지 매니저 사용 설치**
        ```
          $ brew tap hashicorp/tap
          $ brew install hashicorp/tap/terraform
        ```

  - **AWS CLI 설치 및 credentials(AK/SK) 설정**
    - https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/getting-started-install.html

---

#### [ 예제 Code 구성도 ]

![3-Tire](https://user-images.githubusercontent.com/41570538/192953204-975df47b-7881-46ff-a0a4-de3be6b77acb.png)

<img src="https://user-images.githubusercontent.com/41570538/192953204-975df47b-7881-46ff-a0a4-de3be6b77acb.png"  width="1000" height="900">
