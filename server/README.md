# Spring

- VS code에서 Spring Boot Extension Pack 플러그인을 설치해서 더 쉽게 스프링 부트 프로젝트를 생성할 수 있다.

- Lombok, JPA 같은 라이브러리 뿐만 아니라 MariaDB, MySQL의 JDBC 드라이버도 한번에 포함해서 gradle 스프링 부트 프로젝트를 생성할 수 있다.

- ctrl + shift + p 하고 spring initializer 선택

- `SETX PATH C:\Program Files\MariaDB 10.11\bin;%PATH$" /M` 명령어로 설치한 MariaDB 경로 변수 등록하면 셸에서 `mysql -u root -p`로 접속 가능

- **_이거 이렇게 하면 큰일난다. %PATH는 아마 사용자 변수 담고 있는 것 같고 시스템 변수에 PATH에는 MariaDB 경로랑 위 PATH만 남고 System32 경로 같은 환경 변수도 사라진다. 복구할 수 있지만 하면 안된다._**

- Mac에서의 자바 버전 확인과 경로 확인과 버전 변경

- `/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/bin`

- `export JAVA_HOME=$(/usr/libexec/java_home -v 17.0.7)`

- `source ~/.zshrc`

- 스프링 프로젝트를 열었을 때 오류가 난다면 .gradle, .idea 디렉토리를 삭제하고 다시 IDE를 실행해보자.

- intelliJ plugin 단축키 command + ,

- 스프링 부트 어플리케이션은 시작할 때 DB 커넥션 풀을 생성하는데 DB와 통신을 한차례 하기 위해 연결이 필요하고 그 연결을 미리 생성해두는 것이다.

- 기본적으로 Hikari CP를 사용한다.

- 이부분도 반드시 장점은 아닌게 AWS RDS 같은 서비스를 사용하는 인프라에서 배포하면 커넥션풀의 숫자가 많을수록 이미 형성될때 부터 서로 트래픽이 많이 오고가는 것이며 비용이 많이 발생할 수 있다.

- 또다른 Hikari CP에 대한 내용으로는 현재 커넥션풀이 10개인데 응답이 오래걸리는 SQL문 하나가 있다면 그게 해결되는 동안 가용 커넥션풀은 9개이고 아까 그 오래걸리던 SQL문이 또 실행된다면 가용 커넥션풀은 계속 줄어들고 0에 수렴할 수도 있다.

- 그렇기 때문에 타임아웃의 설정이 필요하다고 한다.

- 타임아웃 같은 내용은 application.properties에 설정할 수 있으며 spring.jpa.properties. 하위 목록 중에 설정 항목이 있다고 한다.

- 강의에서 할거니까 말한거겠지?

- `spring.jpa.hibernate.ddl-auto=update` - DDL 쿼리문을 자동으로 해주는 JPA hibernate 기능이라고 한다.

- `spring.jpa.properties.hibernate.format_sql=true` - SQL문을 포맷팅해서 보여준다. 그냥 보기에 편하게?

- `spring.jpa.show-sql=true` 실행되는 쿼리문 보이게 하는 설정

- 오늘 교직원이 졸업 문제로 말도 안되는 소리로 힘들게 해서 교육 수업 제대로 못들어서 억지로 강의들어야 되는 상황에 빌드 안되는거 고치고 gradle, java 깔고 고생해서 강의 중요 포인트 잘 찝었는지 모르겠다 그냥 들리는 대로 막 썼네 