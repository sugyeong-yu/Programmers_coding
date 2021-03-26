def solution(s):
    if len(s)%2 != 0 :
        print(len(s)//2)
        answer=s[(len(s)//2)]
        print(answer)
    else :
        answer=s[(len(s)//2)-1:(len(s)//2)+1]
        print(answer)
    return answer

#다른사람
def string_middle(str):
    # 함수를 완성하세요

    return str[(len(str)-1)//2:len(str)//2+1]
