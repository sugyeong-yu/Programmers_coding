import numpy
def solution(N, stages):
    stages.sort()
    staging=[]
    fail=[]
    answer = []
    for i in range(1,N+2):
        staging.append(stages.count(i))
    print(staging) 
    for i in range(N):
        if sum(staging[i:])==0:
            fail.append(0)
        else:
            fail.append(staging[i]/sum(staging[i:]))
    fail_set=sorted(fail)
    fail_set.reverse()

    for i in range(len(fail_set)):
        answer.append(fail.index(fail_set[i])+1)
        fail[fail.index(fail_set[i])]=-1
    return answer
  
  ##다른사람풀이
def solution(N, stages):
    fail = {}
    for i in range(1,N+1):
        try:
            fail_ = len([a for a in stages if a==i])/len([a for a in stages if a>=i])
        except:
            fail_ = 0
        fail[i]=fail_
    answer = sorted(fail, key=fail.get, reverse=True)
    return answer
