import numpy as np
def solution(left, right):
    nums=np.arange(left,right+1)
    answer=0
    for n in nums:
        count=0
        for i in range(1,n+1):
            if n%i ==0:
                count+=1
        if count%2 ==0:
            answer+=int(n)
        else :
            answer-=int(n)
    return answer
