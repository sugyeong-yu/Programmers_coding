def solution(array, commands):
    answer = []
    for i in range(len(commands)):
        c=commands[i]
        cut=array[c[0]-1:c[1]]
        cut.sort(reverse=False)
        answer.append(cut[c[2]-1])
            
    return answer
