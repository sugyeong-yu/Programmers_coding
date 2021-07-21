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

# 다른사람풀이
def solution(dartResult):
    answer = []
    dartResult = dartResult.replace('10','k')
    point = ['10' if i == 'k' else i for i in dartResult]
    print(point)

    i = -1
    sdt = ['S', 'D', 'T']
    for j in point:
        if j in sdt :
            answer[i] = answer[i] ** (sdt.index(j)+1)
        elif j == '*':
            answer[i] = answer[i] * 2
            if i != 0 :
                answer[i - 1] = answer[i - 1] * 2
        elif j == '#':
            answer[i] = answer[i] * (-1)
        else:
            answer.append(int(j))
            i += 1
    return sum(answer)
