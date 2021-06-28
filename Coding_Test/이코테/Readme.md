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
