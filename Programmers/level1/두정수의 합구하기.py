def solution(a, b):
    n=a-b
    if n==0 :
        answer=a
    elif n>0 :
        # a가 더 큼
        answer=a+b
        for i in range(1,n):
            answer+=(a-i)
    else :
        # b가 더큼
        answer=a+b
        for i in range(1,abs(n)):
            answer+=(b-i)
    return answer

# 다른사람풀이
def adder(a, b):
    # 함수를 완성하세요
    if a > b: a, b = b, a

    return sum(range(a,b+1))

# 아래는 테스트로 출력해 보기 위한 코드입니다.
print( adder(3, 5))
