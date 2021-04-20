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
