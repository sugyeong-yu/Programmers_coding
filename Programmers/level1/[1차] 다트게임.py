import re
def event(i,e):
    if e=="S":
        return i
    elif e=='D':
        return i**2
    else:
        return i**3

def solution(dartResult):
    answer=[]
    numbers = re.findall("\d+", dartResult)
    
    for n in numbers:
        if n in numbers:
            n_idx=dartResult.find(n) if len(n)==1 else dartResult.find(n)+len(n)-1
        if dartResult[n_idx+1] in ['S','D','T']:
            print(int(n),dartResult[n_idx+1])
            answer.append(event(int(n),dartResult[n_idx+1]))
            print(answer)
        if n_idx+2 < len(dartResult) and dartResult[n_idx+2]=='*':
            print(answer)
            if len(answer)==1:
                answer[0]=answer[0]*2
                continue
            else:
                answer[-2]=answer[-2]*2
                answer[-1]=answer[-1]*2
        elif n_idx+2 < len(dartResult) and dartResult[n_idx+2]=='#':
            answer[-1]=answer[-1]*(-1)
    answer=sum(answer)
    return answer
