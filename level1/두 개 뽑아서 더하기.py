def solution(numbers):
    answer = []
    for i in range(len(numbers)):
        for j in range(i+1,len(numbers)):
            res=numbers[i]+numbers[j]
            is_exited=0
            for n in range(len(answer)):
                if answer[n] == res:
                    is_exited=is_exited+1
            if is_exited >=1 :
                continue
            else :
                print(numbers[i],"+",numbers[j],"= ",res,"입니다.")
                answer.append(res)
            
    answer.sort(reverse=False)
        
    return answer
