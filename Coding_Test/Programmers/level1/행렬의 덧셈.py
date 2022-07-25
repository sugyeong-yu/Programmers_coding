#내풀이
def solution(arr1, arr2):
    answer = []
    for a,b in zip(arr1,arr2):
        e=[]
        for c,d in zip(a,b):
            e.append(c+d)
        answer.append(e)
    return answer
  
  # 다른사람풀이
  def sumMatrix(A,B):
    answer = [[c + d for c, d in zip(a, b)] for a, b in zip(A,B)]
    return answer
