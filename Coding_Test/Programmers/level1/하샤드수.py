#내풀이
def solution(x):
    e=list(map(lambda x:int(x),str(x)))
    if (x%sum(e))==0:
        return True
    else:
        return False
# 다른사람풀이
def Harshad(n):
    # n은 하샤드 수 인가요?
    return n % sum([int(c) for c in str(n)]) == 0
