def solution(n, arr1, arr2):
    answer = []
    arr1=list(map(lambda x: list(format(x,'b')),arr1))
    arr2=list(map(lambda x: list(format(x,'b')),arr2))
    l=0
    max_len1=max(list(map(lambda x : len(x),arr1)))
    max_len2=max(list(map(lambda x : len(x),arr2)))
    max_len= max_len2 if max_len1<max_len2 else max_len1
    

    for i in range(len(arr1)):
        line=""
        if len(arr1[i])!=max_len:
            for n in range(abs(max_len-len(arr1[i]))):
                    arr1[i].insert(0,'0')
        if len(arr2[i])!=max_len:
            for n in range(abs(max_len-len(arr2[i]))):
                    arr2[i].insert(0,'0')            
        for j in range(len(arr1[i])):
            if arr1[i][j]=='0' and arr2[i][j]=='0':
                line+=' '
            else :
                line+='#'
        answer.append(line)
        
    
    
    return answer
  
  ## 다른사람풀이
def solution(n, arr1, arr2):
    answer = []
    for i,j in zip(arr1,arr2):
        a12 = str(bin(i|j)[2:])
        a12=a12.rjust(n,'0')
        a12=a12.replace('1','#')
        a12=a12.replace('0',' ')
        answer.append(a12)
    return answer
