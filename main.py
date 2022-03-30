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



