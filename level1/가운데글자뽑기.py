def solution(s):
    if len(s)%2 != 0 :
        print(len(s)//2)
        answer=s[(len(s)//2)]
        print(answer)
    else :
        answer=s[(len(s)//2)-1:(len(s)//2)+1]
        print(answer)
    return answer
