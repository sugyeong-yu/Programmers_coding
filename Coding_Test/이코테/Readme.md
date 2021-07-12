# 이것이 취업을 위한 코딩테스트다 with 파이썬
[Youtube 강의](https://www.youtube.com/watch?v=Mf0pYO8VAZk&list=PLVsNizTWUw7H9_of5YCB0FmsSc-K44y81)

## 1. 코딩테스트 개요
- Coding test 연습

|국내외|이름|URL|
|---|---|---|
|해외|코드포스|http://www.codeforces.com|
|해외|탑코더|https://www.topcoder.com|
|해외|릿코드|https://leetcode.com|
|해외|코드셰프|https://www.codechef.com|
|국내|백준온라인저지|https://www.acmicpc.net|
|국내|코드업|https://codeup.kr|
|국내|프로그래머스|https://programmers.co.kr|
|국내|SW Expert Academy|https://swexpertacademy.com|

- 온라인 추천개발환경
  - 리플릿 [https://repl.it/languages/python3]
    - 소스코드 공유, 바로 결과출력 등 편리함
  - 파이참
  - Dev C++
- 자신이 자주사용하는 알고리즘 코드를 라이브러리화 하면 좋다
  - 팀노트예시 [https://github.com/ndb796/Python-Competitive-Programming-Team-Notes]

- IT기업 코딩테스트 최신 출제경향
 - 2~5시간 가량의 시간
 - 가장 출제 빈도가 높은 알고리즘 유형
   - 그리디
   - 구현
   - DFS/BFS 탐색\
  ![image](https://user-images.githubusercontent.com/70633080/123612405-773ca580-d83d-11eb-877b-fdd205a81174.png)

## 2. 알고리즘 성능
- 복잡도
  - 시간복잡도 : 알고리즘 수행시간 분석
    - 빅오 표기법 : 가장 빠르게 증가하는 항만을 고려하는 표기법\
    ![image](https://user-images.githubusercontent.com/70633080/123613201-309b7b00-d83e-11eb-9252-81e2f3b25c12.png)
  - 공간복잡도 : 알고리즘의 메모리사용량 분석
  - 코딩테스트문제에서 시간제한은 통상 1~5초이다.
    - PyPy의 경우 때로 C언어보다도 빠르게 동작하기도 한다.

  - 시간제한이 1초인 문제를 만났을때
    - N의 범위가 500인 경우 > O(N^3)
    - 2000 > O(N^2)
    - 100000 > O(NlogN)
    - 10000000 > O(N)
- 알고리즘 문제해결 과정
  - 대부분의 문제는 핵심아이디어만 캐치하면 간결하게 작성할 수 있는 형태로 출제한다.
1. 지문읽기 
2. 요구사항분석(복잡도)
3. 문제해결을 위한 아이디어 찾기
4. 소스코드 설계 및 코딩

- 프로그램 수행시간측정
```
import time
start_time=time.time()

end_time=time.time()
print("time", end_time-start_time)
```
## 3. 파이썬 문법: 수 자료형
- 정수형 > 양, 음, 0
- 실수형 > 소숫점 붙이면 자동으로 실수형 변수로 처리
  - 4바이트 혹은 8바이트의 고정된 크기의 메모리를 할당
  - 실수값의 비교가 제대로 이루어 지지않아 원하는 결과를 얻지 못할 수 있음 > round() 사용 (반올림 가능)
- 지수표현법 > 10의 n제곱 > 숫자e^n
  - 실수형데이터로 처리, 임의의 큰수를 표현하기 위해 자주 사용

- 수자료형의 연산
  - / 연산자는 결과를 실수형으로 반환함
  - ** (거듭제곱연산자), // (몫 연산자), % (나머지연산자) 주로사용
  - 
  
## 4. 파이썬 문법: 리스트 자료형
- 리스트 자료형 : 데이터를 연속적으로 담아 처리하기 위해 사용하는 자료형
- 리스트 인덱싱 : 리스트의 특정한 원소에 접근
  - 음의정수 : 거꾸로 탐색 a[-1] => 뒤에서 첫번째 요소 출력
- 리스트 슬라이싱 : 연속적인 위치에 갖는 원소들을 가져와야할때 사용
  - 끝 인덱스는 실제 인덱스보다 1 더 크게 설정
- 리스트 컴프리헨션 : 대괄호안에 조건문과 반복문을 적용해 리스트를 초기화
``` array=[i for i in range(10)] ```
``` array=[i for i in range(20) if i%2 ==1] ```
``` array=[[0]*m for _ in range(n)] ```
- 리스트 관련 기타 메소드
|함수명|사용법|설명|시간복잡도|
|---|---|---|---|
|append()|변수명.append()|리스트에 원소를 하나 삽입할때|O(1)|
|sort()|변수명.sort() or 변수명.sort(reverse=True)|기본:오름차순 , reverse:내림차순|O(NlogN)|
|reverse()|변수명.reverse()|리스트의 원소의 순서를 모두 뒤집어 놓는다|O(N)|
|insert()|insert(삽입할 위치 인덱스, 삽입할 값)|특정 위치에 원소를 삽입할때|O(N)|
|count()|변수명.count(특정 값)|리스트에서 특정값의 데이터 개수를 셀때|O(N)|
|remove()|변수명.remove(특정 값)|특정값을 갖는 원소를 제거 , 여러개면 하나만 제거|
- 
