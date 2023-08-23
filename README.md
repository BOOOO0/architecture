# Architecture

- Terraform을 사용해서 VPC 환경에서의 클라우드 인프라를 프로비저닝하고 Jenkins와 Ansible로 서로 데이터를 주고 받는 React앱과 Spring Boot앱의 CI/CD 파이프라인을 구축합니다.

- ![image](./img/architecture.PNG)

## 사용 기술

- Terraform v1.4.4
- Jenkins v2.401.3
- Ansible v2.9.27
- React v18.2.15
- Vite v4.4.5
- Node.js 16
- Spring Boot v3.1.2
- JPA
- Lombok
- Java 17
- MySQL v8.0.21

## Infrastructure

- 지급받은 크레딧을 활용해 네이버 클라우드 플랫폼에 유료 서비스를 포함한 인프라를 구축했습니다.

- 각 서버의 사양은 동일하게 2xCPU, RAM 8GB, SSD 50GB 운영체제는 CentOS 7.3으로 구성했습니다.

- VPC 환경에서 바스티온 호스트 겸 WS를 퍼블릭 서브넷에 생성하고 같은 서브넷에 CI/CD를 담당할 Jenkins 서버를 생성합니다.

- WAS와 DB를 숨기기 위해 프라이빗 서브넷에 서버를 생성하고 또다른 퍼블릭 서브넷에 생성한 NAT Gateway를 통해 패키지의 설치 등 인터넷이 필요한 경우 인터넷을 사용합니다.

- NAT Gateway는 전용 서브넷을 별도로 생성해야 하기 때문에 퍼블릭 서브넷을 하나 더 생성했습니다.

### ACL Rule, ACG

- 네이버 클라우드 플랫폼은 VPC 환경으로 인프라를 구축할 경우 ACL Rule을 각 서브넷에 반드시 적용해야 합니다.

#### 퍼블릭 서브넷

- 퍼블릭 서브넷은 인터넷을 통한 http, https 접속을 허용하고 로컬 ip로 부터 SSH 접속을 허용합니다. 그리고 인터넷을 통한 젠킨스 접속을 위해 젠킨스의 8080 포트도 접속을 허용합니다.

- 프라이빗 서브넷과의 통신을 위해 아웃바운드 룰은 http, https, SSH 뿐만 아니라 WAS가 실행 될 프라이빗 서브넷의 8080 포트도 허용합니다.

#### 프라이빗 서브넷

- 퍼블릭 서브넷으로부터 SSH를 허용하고 클라이언트와 통신하기 위한 8080 포트도 접속을 허용합니다.

- 아웃바운드 룰은 모든 호스트를 대상으로 모든 포트를 허용해두었습니다.

#### ACG

- 각 서브넷에 ACL Rule을 적용한 이후에도 각 서버에 ACG를 맵핑해줘야 합니다. 맵핑된 ACG는 http, https, SSH, 8080 포트를 허용합니다.

## Frontend

- 리액트 라이브러리를 사용해서 구현했습니다.

- 입력받은 텍스트는 state로 저장되고 제출 시 값은 JSON 포맷으로 서버에 전달되어 DB에 저장됩니다.

- 조회 기능은 DB에서 모든 텍스트를 axios를 사용해 배열로 호출한 다음 map 함수를 사용해서 li 태그로 렌더링합니다.

## Backend

- 스프링 부트 프레임워크를 사용해서 구현했습니다.

- JPA를 사용해서 Content 객체와 content 테이블을 맵핑해서 객체를 Entity로서의 역할을 하게 했습니다. 클라이언트로부터 입력받은 텍스트는 JSON 포맷으로 넘어오기 때문에 RequestBody 어노테이션을 사용해서 전달받은 후 DB에 저장합니다.

- 조회 기능은 text 열의 모든 항목을 조회해서 리스트로 만든 후 응답으로 반환합니다.

## CI/CD

- Jenkins에서 파이프라인을 생성하고 레포지토리에 업로드된 Jenkinsfile에 명시된 작업을 수행합니다.

- 이 과정에서 배포 자동화를 위해 Ansible 스크립트를 사용해서 퍼블릭 서버와 프라이빗 서버에 명령을 내립니다.

- 빌드된 아티팩트를 서버에 전달하기 위해 네이버 클라우드 플랫폼의 오브젝트 스토리지에 업로드하고 Ansible 스크립트를 통해 다운로드 받습니다.

- 오브젝트 스토리지를 CLI에서 접근하기 위해서는 AWS CLI가 필요합니다. `--endpoint-url=https://kr.object.ncloudstorage.com` 옵션을 사용해 오브젝트 스토리지에 접근합니다.

- 이것을 Jenkins가 수행하기 위해서는 Jenkins에 `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` 환경 변수를 생성해서 Key를 저장해두어야 합니다.

### 프론트엔드

- 프론트엔드는 `npm install`을 통해 필요한 모듈들을 설치한 후 `npm build`로 빌드를 합니다.

- 빌드 후 `dist` 디렉토리에 있는 아티팩트를 압축하여 오브젝트 스토리지에 업로드합니다.

- Ansible 스크립트는 프론트엔드 서버에 아티팩트를 다운로드해서 CentOS에서 Nginx의 홈 디렉토리인 `/usr/share/nginx/html`에 빌드된 아티팩트를 배포합니다.

### 백엔드

- 스프링부트 앱을 빌드하기 위해서 Jenkins 서버에 스프링부트 버전에 대응되는 Java17이 설치되어 있어야 하고 Gradle이 설치되어 있어야 합니다.

- `gradlew`를 실행시키기 위해 권한을 변경하고 `./gradlew build`를 통해 빌드를 합니다.

- 빌드 후 생성된 jar 파일을 오브젝트 스토리지에 업로드합니다.

- Ansible 스크립트를 통해 jar 파일을 다운로드 받고 이전에 스프링부트 앱이 실행될 포트에 실행중인 프로세스가 있다면 다음과 같은 셸 스크립트를 사용해서 프로세스를 종료하고 새로 다운로드 받은 jar 파일을 실행합니다.

- ![image](./img/replaceserver.PNG)

- `lsof -i :8080 | awk '{print $2} | sed -n '2p'`를 통해 8080 포트에서 실행중인 프로세스의 PID를 가져오고 추가 모드 리디렉션을 통해 pid.txt의 마지막 줄에 PID를 추가합니다.

- `tail -1 pid.txt`를 통해 `pid.txt`의 마지막 줄에 저장된 PID를 환경 변수 `SERVER_PID`에 할당합니다.

- `SERVER_PID`를 호출하고 `kill`명령어를 사용해 실행중인 프로세스를 종료합니다.

- 새로운 jar 파일을 `nohup &` 명령어를 사용해 백그라운드로 실행되게 합니다.

- **_여기서 Ansible은 멱등성을 가지기 때문에 실행까지만 한다면 결과가 달라지지 않는다고 판단해서 위 과정을 제대로 수행하지 못합니다. 그렇기 때문에 SERVER_PID를 출력하도록 해서 이전과 다른 결과를 내는 TASK로 인식하게 해서 배포가 원활히 이루어지도록 합니다._**

### Jenkins

- 리액트 앱 빌드를 위해 필요한 NodeJS 플러그인과 깃허브에 PUSH가 되었을 때 파이프라인이 동작할 수 있도록 Github Integration 플러그인을 설치합니다.

- ![image](./img/credential.PNG)

- 깃허브 레포지토리 접근 권한을 얻기 위해 레포지토리 접근 권한을 가진 토큰을 생성해 Jenkins의 Credential에 등록합니다.

- ![image](./img/trigger.PNG)

- 깃허브 레포지토리에 PUSH되는 항목을 자동 빌드할 수 있도록 파이프라인을 생성할 때 빌드 트리거 항목에 `Github hook trigger for GITScm polling` 항목을 체크합니다.

- ![image](./img/webhook.PNG)

-

# 되돌아보며

<details><summary>Architecture</summary>
<div markdown="1">

- asd

<div>
</details>

<details><summary>CI/CD</summary>
<div markdown="1">

- asd

<div>
</details>

<details><summary>IaC</summary>
<div markdown="1">

- asd

<div>
</details>

<details><summary>Automation</summary>
<div markdown="1">

- asd

<div>
</details>

<details><summary>Why Docker?</summary>
<div markdown="1">

- asd

<div>
</details>

<details><summary>Nginx</summary>
<div markdown="1">

- asd

<div>
</details>

<details><summary>버전 관리</summary>
<div markdown="1">

- asd

<div>
</details>

<details><summary>좋았던 점들</summary>
<div markdown="1">

- asd

<div>
</details>

<details><summary>앞으로의 방향</summary>
<div markdown="1">

- asd

<div>
</details>
