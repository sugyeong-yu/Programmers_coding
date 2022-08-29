# .strip(): 좌우 공백만 제거
# .replace(' ',''): 모든 공백 제가

def solution(s, n):
    answer=[]
    for w in s: 
        if w==' ':
            answer.append(w)
            continue
        if w.isupper():
            next_ascii=ord(w)+n
            if next_ascii>90:
                next_ascii-=26
        else:
            next_ascii=ord(w)+n
            if next_ascii>122:
                next_ascii-=26
        answer.append(chr(next_ascii))
    return ''.join(answer)

#다른사람풀이
def solution(s, n):
    s = list(s)
    
    for i in range(len(s)):
        if s[i].isupper():
            s[i]=chr((ord(s[i])-ord('A')+ n)%26+ord('A'))
        elif s[i].islower():
            s[i]=chr((ord(s[i])-ord('a')+ n)%26+ord('a'))

    return "".join(s)
