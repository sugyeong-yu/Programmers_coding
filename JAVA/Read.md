## 목차
1. [JAVA시작하기](https://github.com/sugyeong-yu/TIL/blob/main/JAVA/Read.md#1-java-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0)
2. [변수, 자료형, 주석](https://github.com/sugyeong-yu/TIL/blob/main/JAVA/Read.md#2-%EB%B3%80%EC%88%98-%EC%9E%90%EB%A3%8C%ED%98%95-%EC%A3%BC%EC%84%9D)
3. [계산을위한 연산자](https://github.com/sugyeong-yu/TIL/blob/main/JAVA/Read.md#3-%EC%97%B0%EC%82%B0%EC%9E%90)
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
- 기본 자료형과 참조 자료형
  - 기본 자료형 : 자바에서 기본적으로 제공하는 자료형 , 데이터 자체를 저장하는 자료형
  - 참조 자료형 : 데이터가 저장된 메모리주소를 저장하는 자료형 , 배열, 클래스가 만든 객체가 참조자료형
- 논리 자료형 : 참 또는 거짓 , boolean 
- 문자 자료형 : 하나의 문자를 저장하는 자료형, char , (int)c1 > 아스키코드 출력
  - 아스키 코드 
    - A : 65, a : 97  > 알파벳 증가함에 따라서 1씩 증가 
- 정수 자료형 
  - 10진수, 2진수, 8진수, 16진수
    - 16진수는 10 ~ 16까지의 수는 알파벳 A ~ F 를 사용 > 0x 가 붙으면 16진수임
    - 0x1f3b = 1 * 16^3 + f * 16^2 + 3 * 16+ b * 1 = 1 * 4096 + 15 * 256 + 3 * 16 + 11 = 7995
- byte 자료형 
  - 1바이트 = 8비트 : 1바이트는 부호비트 , 7비트를 숫자로 표현 
  - 저장할 수 있는 가장 큰 수는 2^7-1 인 127
  - -128~127 까지 표현가능  
- float 자료형
  - 반드시 F 또는 f 를 숫자뒤에 붙여야함 ``` float f1=5.3F ```
- 리터럴 상수 : 코드에 숫자가 직접 적혀있는 것들
  - 2진수를 리터럴 상수로 : 숫자 앞에 0b 또는 0B를 붙여야함 ``` int b = 0b1010; ```
  - 8진수를 리터럴 상수로 : 숫자 앞에 0을 붙여야함
  - 16진수를 리터럴 상수로 : 숫자 앞에 0x를 붙여야함
  - 문자열 리터럴 : 반드시 String으로 선언, 큰 따옴표를 사용
## 3. 연산자
- JAVA, C 에서 int끼리 연산 시 / 는 몫
- 비트연산자: &, |, ^(XOR)
- 시프트연산자
  - ">>" : 이진수 x를 a비트만큼 오른쪽으로 이동, 왼쪽 비는 공간은 부호로 채움 ( 양수 :0, 음수 : 1)
  - ">>>" : 이진수 x를 a비트만큼 오른쪽으로 이동 , 왼쪽 비는 공간은 0으로 채움
  - "<<" : 이진수 x를 a비트만큼 왼쪽으로 이동, 오른쪽 비는 공간은 0으로 채움
- 논리연산자 : &&(and),||(or),!A(not A)
- 연산자 우선순위 : 산술연산자(!,++, -- , * , / ,%,+,-) > 관계연산자 > 논리연산자 > 할당연산자
- 자동형변환 : 우변의 자료형이 좌변자료형보다 더 작을경우 자동형변환이 일어난다.
- 크기가 큰 자료형을 작은자료형에 저장할 수 없다 > 에러발생
- cast변환 : 크기가 큰자료형의 데이터를 작은 자료형변수에 저장하려고할때 cast연산자를 사용하면 에러를 발생시키지 않고 데이터를 저장할 수 있다.
  - (자료형)변수명
## 4. 조건문과 반복문
- 조건문 
  - if block이 한줄이면 중괄호 생략가능, 이외는 중괄호 필수
```
if (조건1) {
  block
}
else if(조건2) {
  block
}
else {
  block
}
```
- 키보드 입력받은 정수 검사
  - 정수입력 : nextInt()
  - 실수입력 : nextDouble()
  - 문자열입력 : next() 
```
import java.utils.Scanner;
public class A{
  public static void main(String[] args){
    Scanner scin = new Scanner(System.in);
    System.out.print("정수를 입력하시오")
    int x = scin.nextInt();
    if문
    scin.close()
   }
}
```
- Switch문
- 삼항연산자 : (조건)? 참일때:거짓일때
- 반복문 : while, do-while, for
- break, continue 
## 5. 배열과 문자열

