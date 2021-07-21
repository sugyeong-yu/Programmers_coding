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

#2차
import re

def solution(new_id):
    answer = ''
    # 1단계 & 2단계 : 소문자 치환
    answer = re.sub('[^a-z\d\-\_\.]', '', new_id.lower())
    # 3단계 : 마침표 2번 이상 > 하나로
    answer = re.sub('\.\.+', '.', answer)
    # 4단계 : 양 끝 마침표 제거
    answer = re.sub('^\.|\.$', '', answer)
    # 5단계 : 빈 문자열이면 a 대입
    if answer == '':
        answer = 'a'
    # 6단계 : 길이가 16자 이상이면 1~15자만 남기기 & 맨 끝 마침표 제거
    answer = re.sub('\.$', '', answer[0:15])
    # 7단계 : 길이가 3이 될 때까지 반복해서 끝에 붙이기
    while len(answer) < 3:
        answer += answer[-1:]
    return answer

#다른사람풀이
import re

def solution(new_id):
    st = new_id
    st = st.lower()
    st = re.sub('[^a-z0-9\-_.]', '', st)
    st = re.sub('\.+', '.', st)
    st = re.sub('^[.]|[.]$', '', st)
    st = 'a' if len(st) == 0 else st[:15]
    st = re.sub('^[.]|[.]$', '', st)
    st = st if len(st) > 2 else st + "".join([st[-1] for i in range(3-len(st))])
    return st
