def solution(n):
    answer = [i for i in str(n)]
    answer.sort(reverse=True)
    answer=''.join(answer)
    return int(answer)
  
 
#다른사람풀이
def solution(n):
    ls = list(str(n))
    ls.sort(reverse = True)
    return int("".join(ls))
