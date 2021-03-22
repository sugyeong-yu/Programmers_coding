def solution(board, moves):
    basket=[]
    answer = 0
    for i in range(len(moves)):
        for j in range(len(board)):
            if board[j][moves[i]-1] != 0:
                if len(basket)==0:
                     basket.append(board[j][moves[i]-1])
                else :
                    if  board[j][moves[i]-1] == basket[-1]:
                        basket.pop(-1)
                        answer=answer+2
                    else :
                        basket.append(board[j][moves[i]-1])
                board[j][moves[i]-1]=0
                print("basket: ",basket)
                break 
        
    return answer

## 다른사람 풀이
def solution(board, moves):
    stacklist = []
    answer = 0

    for i in moves:
        for j in range(len(board)):
            if board[j][i-1] != 0:
                stacklist.append(board[j][i-1])
                board[j][i-1] = 0

                if len(stacklist) > 1:
                    if stacklist[-1] == stacklist[-2]:
                        stacklist.pop(-1)
                        stacklist.pop(-1)
                        answer += 2     
                break

    return answer
