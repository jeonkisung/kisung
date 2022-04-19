
# 문자열이 제공하는 함수
# 파이썬의 모든 변수의 타입은 객체(instance)로 취급된다.

str01 = ''
str02 = str() # 인스턴스 생성 구문
print('type - ' , type(str01))

phoneNumber = "010-4603-2283"
str03 = phoneNumber.split("-")
print('type - ' , type(str03) )
print('data - ' , str03)

seqTxt = "Talk is cheap. Show me the code!!"
print('seqText - type , len' , type(seqTxt) , len(seqTxt) )
print('dir - ' , dir(seqTxt) )

# 시퀀스 데이터는 인덱싱 및 슬라이싱이 가능하다.  __iter__
# [start : end-1 : step]
print('indexing - ' , seqTxt[0])
print('slicing  - ' , seqTxt[0 : 4])
print('slicing  - ' , seqTxt[-6 : -2])

exStr = "홀짝홀짝홀짝홀짝홀짝홀짝홀짝홀짝"
# 만약에 홀만 출력하고 싶다면?
print('exStr 홀 - ' , exStr[0 : len(exStr) : 2])
print('exStr 홀 - ' , exStr[  :  : 2])
print('exStr 짝 - ' , exStr[1 :  : 2])
print('exStr 짝홀~ - ' , exStr[::-1])

# 문자열이 가지고 있는 함수소개
strSlicing = 'nice Python'
print('Capitalize - ' , strSlicing.capitalize())

phoneNumber = "010-4603-2283"
print('replace - ' , phoneNumber.replace('-' , ' '))

url = 'http://www.naver.com'
print('url slicing - ' , url[-3:])
print('url slicing - ' , url[-3:] , url[url.find('com') : ] )
print('url slicing - ' , url[len(url)-3 : ])

urlLst = url.split('.')
print('urlLst type - ' , type(urlLst) , urlLst)

companyName = '   samsong    '
print('len - ' , len(companyName))
print('data - ' , companyName , len(companyName.strip()) , companyName.lstrip() , companyName.rstrip())

# upper() , lower()
print('upper - ' , companyName.upper() )


# 문자열 in 연산자를 이용해서 문자열을 판별할 수 있다.
fruitTxt = 'apple banana fineapple mango grape melon'
print('in operator - ' , 'Apple'.lower() in fruitTxt)

drinking = 'cocacola'
print(len(drinking) , drinking.count('c') , drinking.find('l') , drinking.index('a'))

# 확장자가 xls , xlsx 파일인지 여부를 확인하고 싶다면?
fileName = 'report.xls'
print('xls , xlsx 파일인지 여부 - ' , fileName.endswith(('xls' , 'xlsx')))

# 파일이름이 report 인지를 판단하고 싶다면?
print('report 파일인지 여부 - ' , fileName.startswith('report'))

'''
list (중요)
- array X
- 순서 0 , 중복 0 , 수정 , 삭제 가능
- index 0 ~
- 선언 [] , list()
- [{key : value}, {}]
'''
lst = [1,2,3,4]
print('type - ' , type(lst) , lst)
print('dir  - ' , dir(lst))
print('indexing - ' , lst[0] )
print('slicing  - ' , lst[0 : 2])

lst = [1,2,3,4, 'jslim' , ['show', 'me', 'the', 'code']]
print('me - ' , lst[-1][1:3] , type(lst[-1]))

# 연산가능
x = [1,2,3,4]
y = [4,5]
z = x + y
print('type - ' , type(z) , z )
z[0] = 0
print('type - ' , type(z) , z )

# list 가지고 있는 함수
z.append(7)
print('append - ' , z)
z.insert(0,6)
print('insert - ' , z)
z.sort()
print('sort - ' , z)
z.reverse()
print('reverse - ' , z)
z.pop(0)
# z[0]
print('pop - ' , z)
del z[0]
print('del - ' , z)
z.remove(4)
print('remove - ' , z)

# append() & extend()
lst01 = [1,2,3]
lst02 = [4,5]

# lst01.append(lst02)
lst01.extend(lst02)
print('append - extend - ' , lst01)

# inner list
# [ [] , [] ]
inner_lst = ['a', 'b', 'c']
outer_lst = [ 10, 3.14, True, 'string' , inner_lst]
print('type - ' , type(outer_lst) )
print('inner lst - ' , type(outer_lst[-1]) , outer_lst[-1][0])

# range() : 숫자를 순차적으로 생성해주는 객체
tmpRange = range(10)
print('range - ' , type(tmpRange) , tmpRange)
print('indexing - ' , tmpRange[-1])
# in
print('in  - ' , 11 in tmpRange)

# 제어구문, 반복구문
# for ~ in : (반복)
# if  ~ in : (조건제어)
for idx in tmpRange :
    print(idx , end='\t')
print()

import random as r
tmpLst = []
for idx in range(5) :
    tmpLst.append(r.randint(1, 5))
print('data - ' , tmpLst)

if 4 in tmpLst :
    print('in ok')
else :
    print('not in')

'''
list comprehension
- list 안에 for 구문을 포함
- 변수 = [ 실행문 for 변수 in sequence형 객체 ]
- **
'''
x = [2,4,1,5,3]
# for idx in range(len(x)) :
#     print(x[idx])
result = []
for value in x :
    sqrt = value ** 2
    result.append(sqrt)
print('x      - ' , x)
print('result - ' , result)
result = [ value**2 for value in x]
print('comprehension - ' , result)

'''
튜플(tuple)
- 선언 : () , tuple()
- 순서 O , 중복 O , 수정 X , 삭제 X - 불변(immutable)
- 읽기 전용
- indexing , slicing 
'''
# tpl = (3,)
tpl = 1,2,3,4,5,6
print('type - ' , type(tpl) , tpl)
print('indexing slicing - ' , tpl[0], type(tpl[0]) , tpl[0:2] , type(tpl[0:2]))
# tpl[0] = 10 - error
# 캐스팅(형변환)을 통한 데이터 조작은 가능하다.
lst = list(tpl)
print('lst type - ' , type(lst) , lst)
lst[0] = 10
tpl = tuple(lst)
print('tpl type - ' , type(tpl) , tpl)

# 1 ~ 99까지의 정수 중 짝수만 튜플에 저장한다면?
even_data = tuple(range(2, 100, 2) )
print('type - ' , type(even_data) , even_data)

# packing & unpacking
packing = ('이지희', '변윤섭', '장성원', '정남선', '노희명')
x1, x2, *x3, x4 = packing
print('type - ' , type(x1), type(x2), type(x3), type(x4))
print('data - ' , x1, x2, x3, x4)



















