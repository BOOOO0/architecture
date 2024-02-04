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

- Entity - Entity Class / Entity 객체 - 서로 다르다

- Entity Class는 테이블 스키마 자체이기 때문에 Key도 명시해야 한다.

- PK를 의미하는 어노테이션은 @Id이다. 

- @GenerateValue 어노테이션은 자동할당으로 strategy 파라미터를 받는데 값으로 GenerationType.[전략 이름]으로 전달한다.

- GenerationType 종류

- TABLE - 시퀀스 테이블을 생성해서 데이터베이스 시퀀스와 같은 역할을 할 ID를 할당한다? DBMS 종류에 상관없이 사용할 수 있다.

- IDENTITY MySQL의 AUTO INCREMENT처럼 데이터베이스의 자동 ID 할당 및 증가 기능을 사용한다. DBMS 종류가 한정된다.

- @Builder - 생성자 관련 어노테이션 AllArgsConstructor, NoArgsConstructor 등과 함께 쓰여서 파라미터 있이 없이 생성자 호출 되도록 

-  @Column(Length = 500, nullable = false) - 테이블 컬럼의 길이, NOTNULL 설정 가능

- 강사 said 솔직히 테이블 스키마 하나하나 짜면 그것만 해야 하지 않냐 그냥 객체 만들고 JPA 쓰자

- 데이터베이스 자체를 공부를 많이 하면 더 나은 데이터베이스를 설계할 수 있지 않을까라는 생각도 있고 그래서 책도 새로 사서 보는거긴 한데 일단 지금은 그냥 스프링으로 백엔드 프로덕트를 어떻게 만드는지에 집중을 하고 있으니까 일단 이렇게 하자

- 지금 순서가 스프링 3계층에 맞게 상향식으로 나아가는 것 같다. 

- 그리고 레포지토리는 런타임에 내용이 자동으로 생긴다고 한다.

- build.gradle 변경했으면 sync를 다시 해줘야 한다.

- 로그 찍는 프로퍼티 그 속성들마다 레벨이 다르다. 로우 레벨의 로그, 하이 레벨의 로그가 있다.

- 레포지토리부터 바로바로 테스트를 돌리자. @log4j2로 빌드해서 실행할때 로그처럼 테스트에서도 로그를 찍을 수 있다.

- 테스트로 넣은 값도 DB에 저장된다.

- CRUD 전체 테스트를 위해 Todo Model에 change라는 이름으로 setter 생성

- Paging 테스트는 Pageable 객체 선언해서 그 객체를 레포지토리에서 findAll한다.

- 동적인 처리를 위해 querydsl을 사용한다.

- queryDsl을 설정하고 컴파일하면 build -> generated-> main에 생성한 모델의 queryDsl관련 파일이 생성된다.

- 이부분이 스프링 부트 3버전부터 문제가 있을 수 있다고 compileJava.dependsOn('clean')를 build.gradle에 추가한다.

- Lombok 관련 어노테이션이랑 JPA, queryDsl 정리

- DTO, DAO 정리

- Serivce 테스트 작성 완료되면 Repository 테스트는 제외해도 괜찮다.

- Service 구현에서 Todo랑 TodoDTO를 서로 바꾸는 부분을 ModelMapper 라이브러리를 사용할 수 있지만 TodoService Interface에서 직접 구현

- CRUD에서 C를 할때 반환값을 무엇으로 할까 그냥 C한 내용 전부다 반환하거나 PK 번호만 반환하거나 AUTO INCREMENT 될때는 PK를 반환하는 걸로

- PageResponse 로직 - Ceil(현 페이지 넘버 / 10)이 끝번호이고 -9가 시작번호 하면 1~10, 11~20 이렇게 된다.

- PathVariable vs queryString - 항상성을 가지는 불변 파라미터는 PathVariable 데이터의 ID처럼 상황에 따라 변하지 않고 고유한 정보, queryString은 글의 총 수에 따라 페이지의 값은 달라질 수 있고 이러한 가변성을 가지는 파라미터는 queryString으로 처리

- Validation과 같은 역할과 동시에 에러 코드와 메세지를 반환하는 데에 RestControllerAdvice를 사용한다.

- Exception 상황에 맞는 Exception을 파라미터로 받고 메소드에 어떤 상태 코드를 반환할 것인지 쓰고 body를 JSON으로 보내기 위해 Map이나 List로 에러 메세지를 명시한다.

- LocalDateFormatter와 CustomServletConfig

- LocalDateFormatter는 사용자에게 문자열로 입력 받는 날짜 데이터를 LocalDate 형식으로 변환하고 그 반대의 변환도 수행한다.

- 생성한 포매터를 Configuration에 추가하기 위해 CustomServletConfig에서 WebMvcConfigurer의 addFormatter를 Override하여 FormatterRegistry에 포매터를 등록한다.

- CrossOrigin을 Controller에 추가해서 설정했지만 이미 전체에 적용되는 Config 클래스를 사용하고 있기 때문에 거기서 설정을 한다. 

- addCorsMapping에 모든 경로가 모든 출처에 대해 CORS 이슈가 발생하지 않도록 설정하고 허용할 HTTP 메소드를 명시한다.