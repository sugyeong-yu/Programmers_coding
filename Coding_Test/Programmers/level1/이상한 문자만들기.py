def solution(s):
    s=s.split(" ")
    answer=[]
    for w in s:
        answer.append(''.join([c.upper() if i%2==0 else c.lower() for i,c in enumerate(w)]))           
    answer =' '.join(answer)
    return answer
  
#다른사람풀이
def toWeirdCase(s):
    return " ".join(map(lambda x: "".join([a.lower() if i % 2 else a.upper() for i, a in enumerate(x)]), s.split(" ")))
