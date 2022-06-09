
# 파이썬 제어문, 반복문
'''
제어구문 - if
if True :
    statement
else :
    statement
True  : 0이 아닌 수, 문자, 데이터가 있는 리스트, 튜플, 집합, 딕셔너리
False : 0 , "" , 데이터가 없는 리스트, 튜플, 집합, 딕셔너리
'''
import random

tmpStr = [1,2,3]
if tmpStr :
    print('true block')
else :
    print('false block')

# score = int( input('점수 입력 ') )
# if score >= 60 :
#     print('pass')
# else :
#     print('fail')

# if ~ in
# area = ['서울', '부산', '대전', '광주', '대구', '울산', '인천']
area = {'서울' : 100, '부산' : 150 , '대전' : 200 }
region = '부산'
if region in area :
    print('키 값이 존재합니다. key - ' , region)
else :
    print('{} 지역은 포함되지 않습니다'.format(region))

'''
윤년의 조건
- 4의 배수이고 100의 배수가 아니거나 400의 배수일 때
'''
year = 2020
if (year%4 == 0 and year%100 != 0) or (year%400 == 0) :
    print('leap year')
else :
    print('year')

'''
input() 함수를 이용해서 연도와 월을 입력받아
해당년도가 윤년일 경우 2월달의 마지막일은 29 , 
평년일경우 2월당의 마지막일은 28
출력 형식 : xxxx년 x월 마지막일은 xx일 입니다.
'''
# year  = int(input('년도 입력 : '))
# month = int(input('달   입력 : '))
# year_month      = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
# leap_year_month = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
# if (year%4 == 0 and year%100 != 0) or (year%400 == 0) :
#     print('{} 년 {} 월 마지막 일은 {} 입니다.'.format(year, month , leap_year_month[month-1]) )
# else :
#     print('{} 년 {} 월 마지막 일은 {} 입니다.'.format(year, month , year_month[month-1]) )

# 중첩구문
# lst31 = [1,3,5,7,8,10,12]
# if month != 2 :
#     if month in lst31 :
#         print('{} 년 {} 월 마지막 일은 31 입니다.'.format(year, month))
#     else :
#         print('{} 년 {} 월 마지막 일은 30 입니다.'.format(year, month))
# else :
#     if (year%4 == 0 and year%100 != 0) or (year%400 == 0) :
#         print('{} 년 {} 월 마지막 일은 29 입니다.'.format(year, month))
#     else :
#         print('{} 년 {} 월 마지막 일은 28 입니다.'.format(year, month))

# 다중 조건문
# 100 ~ 85 : '우수' , 84 ~ 70 : '보통' , 69 이하 : '저조'
# if ~ elif ~ else
score = 90
grade = ''
if    score >= 85 and score <= 100 :
    grade = '우수'
elif  score >= 70 and score <= 84 : # else if
    grade = '보통'
else :
    grade = '저조'

print('당신의 점수는 %d점이고, 등급은 %s 입니다.' % (score, grade))

# 3항 연산자
# 변수 = '참' if (조건식) else '거짓'
num = 9
if num >= 5 :
    result = num * 2
else :
    result = num + 2
print('result - ' , result)

# if -> 3항 연산자
result = num * 2 if num >= 5 else num + 2
print('result - ' , result)

# in, not in
tmpDict = {
    'name'  : 'jslim' ,
    'city'  : 'seoul' ,
    'grade' : 'A'
}
print('in - ' , 'name'  not in tmpDict.keys() )
print('in - ' , 'jslim' in tmpDict.values()  )

'''
관계연산자 
- > , >= , < , <= , == , !=
논리연산자
- and, or, not
산술연산자
- +, -, *, /, %, %% , +=  , -=
산술 > 관계 > 논리 순서로 적용
'''
print('operator priority - ' , 3 + 12 > 7 + 3)
print('operator priority - ' , 5 + 10 > 3 and not 7 + 3 == 10)

id01  = 'vip'
id02  = 'admin'
grade = 'platinum'

if id01 == 'vip' or id02 == 'admin' :
    print('관리자 인증')

if id02 == 'admin' and grade == 'platinum' :
    print('최상위 관리자 인증')

# 시간이 입력되었을 때 입력된 시간이 정각인지 아닌지를 구분하고 싶다면?
# 14:12 , 12:00
time = '14:13'

if time.endswith('00') :
    print('정각입니다.')
else :
    print('정각이 아닙니다.')

result = '정각' if time[-2:] == '00' else '정각이 아님'
print('time - ' , result)

result = '정각' if time.split(':')[1] == '00' else '정각이 아님'
print('time - ' , result)

# 011 SK , 016 KTF , 019 LGU
# 011-1234-1234
# 통신사 번호를 식별하고 싶다면?
phoneNumber = '017-1234-1234'
brand = phoneNumber.split('-')[0]
if   brand =='011' :
    print('SK - ')
elif brand =='016' :
    print('KTF - ')
elif brand =='019':
    print('LGU - ')
else :
    print('통신사의 식별번호를 확인할 수 없습니다.')

#   '참' if (조건) else '거짓' if (조건) else '거짓'

# 주민번호 >> 성별 >> xxxxxx-1xxxxxx 1,3-남 2,4-여
# 지역코드 00~08 : 서울지역
ssn = 'xxxxxx-212xxxx'
gender = ssn.split('-')[1]
print('type - ' , type(gender) , gender)
result   = '남자' if gender[0]=='1' or gender[0] == 3 else '여자'
location = 'seoul' if int(gender[1:3]) in range(0,9) else 'not seoul'
print('gender - location ' , result, location)

# from random import randint
# answer = randint(1, 100)
# print('answer - ' , answer)
# guess  = int(input('1 ~ 100 사이의 값을 입력하세요 : '))
# if   answer == guess :
#     print('정답 - ')
# elif guess > answer :
#     print('작은 숫자를 넣어주세요')
# else :
#     print('큰 숫자를 넣어주세요')

'''
파이썬 반복문 : for ~, while ~ 
- break , continue 
- for 변수 in <열거형> :
    <loop body>
- for ~
  else :    
- for(초기식 : 조건식 : 증감식 ) {
    <loop body>
  }
  초기식선언
- while(조건식) {
    <loop body>
    초기식 증감
  }
'''
for value in range(1, 11, 2) :
    print('value  - ', value)

scores = [100, 90, 56, 67, 78]
# for i in range(5) :
#     scores.append( int( input('성적을 입력하세요 : ') ) )
print('type - ' , type(scores) , len(scores))
print('data - ' , scores)

# for el in scores :
#     print('el - ' , el)

for idx in range( len(scores) ) :
    # print('idx - ' , idx)
    print(scores[idx] , '\t' , end = " ")

# 총합, 평균을 알고싶다
print()
sum = 0
for el in scores :
    sum += el
print('sum - ' , sum )
print('avg - ' , sum / len(scores) )

# dogNames = []
# flag = True
# while flag :
#     name = input('반려견의 이름을 입력하세요 : ')
#     if name == 'exit' :
#         flag = False
#     else :
#         dogNames.append(name)
#
# print('while - ' , dogNames)

# 올림픽은 4년 개최
# 2020 ~ 2050년 사이의 올림픽이 개최되는 년도를 출력
# 한 줄에 5개의 년도씩 출력
# print(end=)
cnt = 0
for year in range(2000, 2051, 4) :
    cnt += 1
    if cnt%5 == 0 :
        print(year , end='\n')
    else :
        print(year , end='\t')

print()

tmpLst = [1, 2, 3, 4, 5, 6, 7, 8, 9]
lst = []
for data in tmpLst :
    if data%2 == 0 :
        lst.append( data ** 2 )
print('sqrt lst  - ' , lst )
lst = [ data**2 for data in tmpLst if data%2 == 0 ]
print('sqrt com~ - ' , lst )

# 세 글자 이상인 문자만 출력?
tmpLst = ['I', 'am', 'studying', 'PYTHON', 'language', '!!']
# lst = [ data for data in tmpLst if len(data) >= 3 ]
lst = []
for data in tmpLst :
    if len(data) >= 3 :
        lst.append(data)
print('3 over - ' , lst)

# 대문자만 출력을 한다면?
# isupper()
lst = []
for data in tmpLst :
    if data.isupper() :
        lst.append(data)
print('upper - ' , lst)


# 확장자를 제외하고 파일 이름만 출력한다면?
# split()
tmpLst = ['greeting.py',
          'ex01.py',
          'intro.hwp',
          'bigdata.doc',
          'machine_learning.jupyter']

for idx in range( len(tmpLst) ) :
    print( tmpLst[idx].split(".")[0] )

