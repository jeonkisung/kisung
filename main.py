print('kisung')
print(3 * "kisung")
print("Jeonkisung"[0:4])
print("Jeonkisung"[4:6])
print("Jeonkisung"[6:10])
print("이름\t나이\t취미")
print("전기성\t26\t여행")

def print_n_times(*values, n=2):
    for i in range(n):
        for value in values:
            print(value)
            print()
print_n_times("안녕하세요","여행 좋아하는","전기성 입니다", n=3)

print("\t트리")
for i in range(7):
    print(' '*(6-i) + '*'*(i*2-1))

for i in range(4):
    print((' '*4+'*'*3))

import turtle as t
import time
#꼬북꼬북
t.shape('turtle')
t.fd(200)
t.rt(90)
t.fd(200)
t.lt(90)
t.bk(200)
t.lt(90)
t.fd(400)
t.lt(90)
t.fd(200)
t.lt(90)
t.fd(200)
t.lt(90)
t.fd(200)
time.sleep(1)

### 묵찌묵찌
import random

sel = ['가위', '바위', '보']
result = {0: '승리했습니다.', 1: '패배했습니다.', 2: '비겼습니다.'}

def checkWin(user, com):

    if not user in sel:
       print('잘못입력하였습니다. 다시 입력하세요')
       return False

    print(f'사용자 ( {user} vs {com} ) 컴퓨터')
    if user == com:
        state = 2
    elif user == '가위' and com == '바위':
        state = 1
    elif user == '바위' and com == '보':
        state = 1
    elif user == '보' and com == '가위':
        state = 1
    else:
        state = 0
    print(result[state])
    return True

def continueComfirm():
    while True:
        user = input("다시하시겠습까? : 예, 아니요")
        if user == '예':
            return True
        elif user == '아니요':
            return False
        else:
            print("예 또는 아니요를 입력하세요.")

print('\n-------------------------------------------')
while True:
    user = input("가위, 바위, 보 : ")
    com = sel[random.randint(0, 2)]
    if checkWin(user, com):
        if continueComfirm():
            continue
        else:
            break
print('-------------------------------------------\n')




