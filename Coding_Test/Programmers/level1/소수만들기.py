from itertools import combinations

def isprime(num):
    if num%2 ==0:
        return False
    for i in range(2,num):
        if num%i==0:
            return False
    return True

def solution(nums):
    # 짝수가 아닐것
    # 에라토스 테네스의 체
    threeNum=list(combinations(nums,3))
    s=list(map(lambda x:sum(x),threeNum))
    
    answer=0 
    for i in s:
        if isprime(i)==True:
            answer+=1

    return answer
