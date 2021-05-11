def solution(numbers, hand):
    answer=''
    dial={ '1':[0,0], '2':[0,1],'3':[0,2],
           '4':[1,0], '5':[1,1],'6':[1,2],
           '7':[2,0], '8':[2,1],'9':[2,2],
           '10':[3,0],'0':[3,1],'12':[3,2]}
    
    l=dial['10']
    r=dial['12']
    print(l)
    for i in numbers:   
        if i in [1,4,7]:
            l=dial[str(i)]
            answer+='L'
        elif i in [3,6,9]:
            r=dial[str(i)]
            answer+='R'
        else:
            target= dial[str(i)] 
            #왼쪽거리계산
            l_dist=abs(l[0]-target[0])+abs(l[1]-target[1])
            #오른쪽거리계산
            r_dist=abs(r[0]-target[0])+abs(r[1]-target[1])
            
            if l_dist==r_dist:
                if hand=='left':
                    l=target
                    answer+='L'
                else :
                    r=target
                    answer+='R'
            elif l_dist<r_dist:
                l=target
                answer+='L'
            else :
                r=target
                answer+='R'

    return answer
