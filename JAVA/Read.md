## 목차
1. [JAVA시작하기](https://github.com/sugyeong-yu/TIL/blob/main/JAVA/Read.md#1-java-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0)
2. [변수, 자료형, 주석]()
3. 계산을위한 연산자
4. 조건문과 반복문
5. 배열과 문자열
6. 메소드
7. 클래스와 객체
8. 상속
9. 패키지와 접근제어
10. 추상클래스와 인터페이스
11. 유용한 패키지와 클래스들
12. 예외처리
13. 자바입출력
14. 제네릭스와 컬렉션 프레임워크
15. 스레드
16. 람다,열거형,어노테이션
## 1. JAVA 시작하기
- JAVA (소스코드, 문서) -> JAVAC(컴파일) -> 클래스파일생성 -> 자바인터프리터 -> 실행결과
- 자바설치하기 
  1. 자바컴파일러인 JDK를 다운받아야함. [https://www.oracle.com/java/technologies/javase-downloads.html]
      - 자바 컴파일러 설치 경로 [C:\Program Files\JAVA\jdk-16.0.1\ ]
      - 환경변수 추가\
      ![image](https://user-images.githubusercontent.com/70633080/125251883-bfc28b80-e332-11eb-9bdf-bd83c610a076.png)
  2. 코드를 작성하고 수행할 수 있는 환경 -> 이클립스 다운 [eclipse.org/downloads/]
- 자바 시작하기
  - project -> package -> class 순으로 생성해야함
  - project 생성 후 src 왼쪽 클릭 -> new -> package -> 이름 설정 후 생성( **패키지 이름은 모두 소문자로**)
  - package 왼쪽 클릭 -> new -> class -> 이름 설정 후 생성(**class이름의 첫글자는 무조건 대문자**)
  - **항상 클래스의 이름이 파일명이 된다.** 
  - RUN = Ctrl+F11
## 2. 변수, 자료형, 주석
- 변수 선언시 어떤자료형이 저장되는지 명시해야함
- 기본 자료형 : boolean, char, byte, short, int, long, float, double
- 변수명 규칙
  - 길이제한 없음
  - 영어 대소문자, 숫자, _ , $ 로만 구성가능
  - 숫자로 시작 안됨
  - 키워드를 변수명으로 사용할 수 없음
 - 키워드 : 프로그래밍 언어에서 코드에 직접 사용되는 특별한 단어들
- 변수값 출력 ``` System.out.println(변수명) ``` 또는 ``` System.out.print(변수명) ```
- 
- 
