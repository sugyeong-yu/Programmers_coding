import numpy as np
def solution(answers):
    answer=[]
    a1=0
    a2=0
    a3=0
    p1=[1,2,3,4,5]
    p2=[2,1,2,3,2,4,2,5]
    p3=[3,3,1,1,2,2,4,4,5,5]
    for i in range(0,len(answers)):
        if p1[i%len(p1)] == answers[i]:
            a1+=1
        if p2[i%len(p2)] == answers[i]:
            a2+=1
        if p3[i%len(p3)] == answers[i]:
            a3+=1
    a=[a1,a2,a3]
    if np.max(a) == a[0]:
        answer.append(1)
    if np.max(a) == a[1]:
        answer.append(2)
    if np.max(a) == a[2]:
        answer.append(3)
    return answer
