### [HOME](https://github.com/YGCHO-repo/Terraform/blob/main/README.md) / [DOCS](https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/README.md) / [02.Commands(CLI)](<https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/README.md>) / [01.Environment Value](<https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/01_Environment_Variables/README.md>)

---

#### DOCS TREE

<pre>
<a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/README.md">DOCS</a>
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/00_Terraform/README.md">Terraform</a>
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/README.md">Configuration Language</a>
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/README.md">Commands(CLI)</a>
    │               ├── <i><b><a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/01_Environment_Variables/README.md">Environment_Variables</a></b></i>
    │               ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/02_Apply/README.md">Apply</a>
    │               ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/03_Destroy/README.md">Destroy</a>
    │               ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/04_FMT/README.md">FMT</a>
    │               ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/05_Graph/README.md">Graph</a>
    │               ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/06_Import/README.md">Import</a>
    │               ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/07_Init/README.md">Init</a>
    │               ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/08_Output/README.md">Output</a>
    │               ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/09_Plan/README.md">Plan</a>
    │               ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/10_Providers/README.md">Providers</a>
    │               └── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/11_State/README.md">State</a>
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/03_Providers/README.md">Providers</a>
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/04_Provisioners/README.md">Provisioners</a>
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/05_Modules/README.md">Modules</a>
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/06_State/README.md">State</a>
    └── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/07_Backends/README.md">Backends</a>

</pre>

### Environment Value

> Terraform은 동작의 다양한 측면을 사용자 정의하기 위한 여러 환경변수를 사용할 수 있습니다.

#### TF_VAR_name

> 환경변수를 사용하여 변수를 설정할 수 있습니다. 환경변수는 TF_VAR_name 형식입니다.

```hcl
export TF_VAR_region='ap-northeast-2'
export TF_VAR_ami='ami-049d8641'
export TF_VAR_alist='[1, 2, 3]'
export TF_VAR_amap='{ foo = "bar", baz = "qux" }'
```

---

### [다음 페이지](<https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/02_Apply/README.md>)

### [HOME](https://github.com/YGCHO-repo/Terraform/blob/main/README.md)
