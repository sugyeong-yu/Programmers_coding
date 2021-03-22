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
