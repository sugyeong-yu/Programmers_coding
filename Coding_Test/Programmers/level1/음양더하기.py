import numpy as np
def solution(absolutes, signs):
    signs=list(map(lambda x: 1 if x==True else -1,signs))
    answer = sum(list(map(lambda x,y:x*y,absolutes,signs)))
    return answer
  
  #다른사람의 풀이
  def solution(absolutes, signs): return sum(absolutes[i] * (1 if signs[i] else -1) for i in range(len(signs)))
