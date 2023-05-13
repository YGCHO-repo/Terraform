### [HOME](https://github.com/YGCHO-repo/Terraform/blob/main/README.md) / [DOCS](https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/README.md) / [01.Configuration Language](https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/README.md) / [08.Local Values](https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/08_Local_Values/README.md)

---

#### DOCS TREE

<pre>
<a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/README.md">DOCS</a>
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/00_Terraform/README.md">Terraform</a>
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/README.md">Configuration Language</a>
    │                        ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/01_Files_and_Directories/README.md">Files_and_Directories</a>
    │                        ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/02_Syntax/README.md">Syntax</a>
    │                        ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/03_Resources/README.md">Resources</a>
    │                        ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/04_Data_Sources/README.md">Data_Sources</a>
    │                        ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/05_Providers/README.md">Providers</a>
    │                        ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/06_Input_Variables/README.md">Input_Variables</a>
    │                        ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/07_Output_Values/README.md">Output_Values</a>
    │                        ├── <i><b><a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/08_Local_Values/README.md">Local_Values</a></b></i>
    │                        ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/09_Modules/README.md">Modules</a>
    │                        ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/10_Expressions/README.md">Expressions</a>
    │                        ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/11_Functions/README.md">Functions</a>
    │                        ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/12_Settings/README.md">Settings</a>
    │                        └── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/13_State/README.md">State</a>  
    ├── <a href ="https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/README.md">Commands(CLI)</a>
    └── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/03_Backends/README.md">Backends</a>
</pre>

---

### Local Values

> Local Value는 이름을 표현식에 지정하여 모듈 내에서 반복하지 않고 여러 번 사용할 수 있습니다.

#### Declaring a Local Value

> Locals 블록을 사용하여 설정합니다.

```hcl
locals {
  service_name = "forum"
  owner        = "Community Team"
}
```

> 간단한 상수이거나, 다른 모듈 또는 다른 리소스 값을 반환하거나, 복잡한 표현식도 가능합니다.

```hcl
locals {
  # 두개의 인스턴스의 ID List를 반환 합니다.
  instance_ids = concat(
    aws_instance.blue.*.id,
    aws_instance.green.*.id,
  )
}

locals {
  # 모든 자원에서 사용할 공통 태그
  common_tags = {
    Service = local.service_name
    Owner   = local.owner
  }
}

locals {
  # vpc 를 만들도록 설정 했으면 생성된 리소스에서 id 를 가져오고,
  # 만들지 않 도록 설정 헸으면 변수에서 가져 온다.
  vpc_id = var.create_vpc ? element(concat(aws_vpc.this.*.id, [""]), 0) : var.vpc_id
}
```

---

### [이전 페이지](https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/07_Output_Values/README.md)

### [다음 페이지](https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/09_Modules/README.md)

### [HOME](https://github.com/YGCHO-repo/Terraform/blob/main/README.md)
