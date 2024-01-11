# Spring

- VS code에서 Spring Boot Extension Pack 플러그인을 설치해서 더 쉽게 스프링 부트 프로젝트를 생성할 수 있다.

- Lombok, JPA 같은 라이브러리 뿐만 아니라 MariaDB, MySQL의 JDBC 드라이버도 한번에 포함해서 gradle 스프링 부트 프로젝트를 생성할 수 있다.

- ctrl + shift + p 하고 spring initializer 선택

- `SETX PATH C:\Program Files\MariaDB 10.11\bin;%PATH$" /M` 명령어로 설치한 MariaDB 경로 변수 등록하면 셸에서 `mysql -u root -p`로 접속 가능

- **_이거 이렇게 하면 큰일난다. %PATH는 아마 사용자 변수 담고 있는 것 같고 시스템 변수에 PATH에는 MariaDB 경로랑 위 PATH만 남고 System32 경로 같은 환경 변수도 사라진다. 복구할 수 있지만 하면 안된다._**
