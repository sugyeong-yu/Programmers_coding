#내가 푼 풀이
def solution(sizes):
    w,h=0,0
    for size in sizes:
        if size[1]>=size[0]:
            s=size[1]
            size[1]=size[0]
            size[0]=s
        if w<size[0]:
            w=size[0]
        if h<size[1]:
            h=size[1]
    
    return w*h

#다른사람 풀이
def solution(sizes):
    return max(max(x) for x in sizes) * max(min(x) for x in sizes)
