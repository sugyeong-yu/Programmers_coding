def solution(array, commands):
    answer = []
    for i in range(len(commands)):
        c=commands[i]
        cut=array[c[0]-1:c[1]]
        cut.sort(reverse=False)
        answer.append(cut[c[2]-1])
            
    return answer


#다른사람 정답
def solution(array, commands):
    return list(map(lambda x:sorted(array[x[0]-1:x[1]])[x[2]-1], commands))
