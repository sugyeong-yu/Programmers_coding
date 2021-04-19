import numpy as np
def solution(nums):
    num=int(len(nums)/2)
    n=len(list(set(nums)))
    if num>=n:
        answer=n
    else:
        answer=num
    return answer
## 다른사람답안
def solution(ls):
    return min(len(ls)/2, len(set(ls)))
