import string
def remove_dot(re_id):
    re_id=list(re_id)
    #print(re_id[0],re_id[-1])
    if re_id[0]=='.':
        del re_id[0]
    if re_id!=[] and re_id[-1]=='.':
        del re_id[-1]
    return re_id
def solution(new_id):
    alphabet=list(string.ascii_lowercase)
    num=list(map(str, list(range(0,10))))
    s=["-","_","."]
    ok=alphabet+num+s
    
    origin=new_id.lower()
    new_id=list(new_id.lower()) # 1단계
    
    #2단계
    for i in origin:
        if i not in ok :
            #print("remove str", i)
            new_id.remove(i)

    #3단계
    re_id=''.join(new_id)
    count=0
    length=len(new_id)
    for i in range(len(new_id)):
        if new_id[i] =='.':
            count+=1
        else :
            if count>=2:
                rm='.'*count
                re_id=re_id.replace(rm,".")
            count=0    
        if i==len(new_id)-1 and count>=2:
            rm='.'*count
            re_id=re_id.replace(rm,".")
    #4단계 & 5단계
    re_id=remove_dot(re_id)
    
    if re_id==[]:
        re_id=['a']
    
    # 6단계
    if len(re_id)>=16:
        del re_id[15:]
        if re_id!=[] and re_id[-1]=='.':
            del re_id[-1]
    
    #7단계
    while(True):
        if len(re_id)<=2:
            re_id.append(re_id[-1])
        else:
            break

    answer=''.join(re_id)
    return answer
