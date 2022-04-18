
# 주석문
# 모듈(함수 + 변수)
# library

# 기본출력구문 - print()
print('Python Starting...')
print()
print('''우리는 파이썬 기본 문법을 배우고 있습니다.
추후에 진행될 데이터 사이언스 및 인공지능을 위한 과정이고
전, 파이썬을 사랑합니다.....''')
print()
print("Seop's Python~~~")
print('Speak Out. "Student" ')
print()
print("오늘은" , "혈맥강사를" , "만나서" , "파이썬을" , "배웁니다~~~")

print()
# separator option
print('P', 'Y', 'T', 'H', 'O', 'N' , sep='-')
print('010', '4603', '2283', sep='-')
print('jslim9413' , 'naver.com' , sep='@')

print()
# end option( println() - print() )
print('Welcome To' , end=' ')
print('Seop World~~')

# format 사용(%d, %s, %f)
print('섭섭해님의 나이는 : {} 이고 성별 : {} 입니다.'.format(50, '남자') )
print('섭섭해님의 나이는 : {1} 이고 성별 : {0} 입니다.'.format('남자' , 50) )

# %s
print('섭섭해님의 나이는 : %d 이고 성별 : %s 입니다.' % (50, '남자') )
# 자릿수 지정 가능!!
print('%10s' % ('nice' , ))
print('%-10s' % ('nice' , ))

print('%5s' % ('pythonstudy' , ) )
print('%.5s' % ('pythonstudy' , ) )

# %d
print('%d %d' % (1 , 2))
print('%4d' % (42,))
print('%-4d' % (42,))

# %f
print('%f' % (3.1415925, ) )
print('%1.2f' % (3.1415924, ) )


# 변수 ?
'''
Python Built-In types
- Numeric
- Sequence
- Text Sequence
- Set
- Mapping
- Bool
- 파이썬에는 배열이 존재하지 않고 추후 배울 numpy에서 ndarray 타입이 파이썬의 배열이다....
'''
'''
변수를 선언하는 다양한 방법
- Camel  Case : numberOfCollegeGraduates (변수)
- Pascal Case : NumberOfCollegeGraduates (클래스)
- Snake  Case : number_of_college_graduates (변수)

주의) 
숫자로시작할 수 없고 , 특수문자 _,$ 허용된다.
대소문자 구별한다.
예약어는 변수로 사용할 수 없다.
'''
print('변수 - ')
age = 10
Age = 20
print(age, Age , type(age) , type(Age) )

# keyword.py
# keyword.함수() , keyword.변수
import keyword
kw = keyword.kwlist
print('type - ' , type(kw))
print('data - ' , kw)

# 변수 바인딩( = 연산자를 이용해서 할당)
year  = 2022
month = 1
day   = 25
print(year, month, day , type(year) , type(month) , type(day) )
print('오늘은 {}년 {}월 {}일 입니다.'.format(year, month, day))

intValue   = 123
floatValue = 3.14
boolValue  = True
strValue   = 'jslim'
print('type - ' , type(intValue) , type(floatValue) , type(boolValue) , type(strValue))

# 형변환
print( str(intValue) + strValue )
name = ''
print( int(bool(name))  , type(int(bool(name))) )

# list type
list = ['이지희', '강진성', '장성원']
print('type - ' , type(list))
print('data - ' , list)

# dict(key, value) type
dict = {
    "name" : "machine Learning" ,
    "version" : 2.0
}
print('type - ' , type(dict))
print('data - ' , dict)

# tuple type
tuple = (3,)
print('type - ' , type(tuple))
print('data - ' , tuple)

# set type
set = {3,5,7}
print('type - ' , type(set))
print('data - ' , set)

# str type(중요)
str01 = "I am Python"
str02 = 'I am Python'
str03 = '''
this is a 
multi line comment
'''
str04 = """this is a 
           multi line comment"""
print( type(str01) , type(str02) , type(str03) , type(str04))
print(str03)

































