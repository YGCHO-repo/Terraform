### [HOME](https://github.com/YGCHO-repo/Terraform/blob/main/README.md) / [DOCS](https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/README.md) / [02.Commands(CLI)](<https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/README.md>) / [03.Destroy](<https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/03_Destroy/README.md>)

---

#### DOCS TREE

<pre>
<a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/README.md">DOCS</a>
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/00_Terraform/README.md">Terraform</a>
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/01_Configuration_Language/README.md">Configuration Language</a>
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/README.md">Commands(CLI)</a>
    │               ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/01_Environment_Variables/README.md">Environment_Variables</a>
    │               ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/02_Apply/README.md">Apply</a>
    │               ├── <i><b><a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/03_Destroy/README.md">Destroy</a></b></i>
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
    ├── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/07_Backends/README.md">Backends</a>
    └── <a href = "https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/08_Functions/README.md">Functions</a>


</pre>

### Destroy

> terraform destroy 명령은 Terraform 관리 인프라를 삭제하는데 사용됩니다.
>
> ```
>
> ```

#### Usage

```
terraform destroy [options] [dir]
```

> Terraform에서 관리하는 인프라가 파괴됩니다. 파괴하기 전에 확인을 요청합니다.
> 이 명령은 계획 파일 인수를 제외하고 apply 명령이 수락하는 모든 인수 및 플래그를 승인합니다.
> -auto-approve 가 설정되면 삭제 확인이 표시되지 않습니다.
> "종속성"에 영향을주는 대신 -target 플래그는 지정된 대상에 의존하는 모든 자원도 삭제합니다. 자세한 내용은 terraform plan의 target 문서를 참조하십시오.
> terraform destroy 명령의 동작은 terraform plan -destroy 명령으로 언제든지 미리 볼 수 있습니다.

---

### [이전 페이지](<https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/02_Apply/README.md>)

### [다음 페이지](<https://github.com/YGCHO-repo/Terraform/blob/main/DOCS/02_Commands(CLI)/04_FMT/README.md>)

### [HOME](https://github.com/YGCHO-repo/Terraform/blob/main/README.md)
