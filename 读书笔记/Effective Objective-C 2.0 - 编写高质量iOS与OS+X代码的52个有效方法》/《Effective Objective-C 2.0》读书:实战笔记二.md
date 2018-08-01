<p align='center'>
<img src='http://p95ytk0ix.bkt.clouddn.com/2018-07-31-8726ab1532ca52746711381b07cc9971.jpg'>
</p>


##《Effective Objective-C 2.0》读书/实战笔记 二

### 第3章：接口与API设计
#### 🇪🇪 第15条：用前缀避免命名空间冲突
* 选择与你的公司，应用程序或两者皆有关联之名称作为类名的前缀，并在所有代码中均使用这一前缀
* 若自己所开发的程序库中用到了第三方库，则应为其中的名称加上前缀

顾名思义就是说在自己开发的类需要加前缀，iOS~~程序员~~开发工程师普遍使用双字母的前缀，就像我在开发时习惯加前缀 `XW`,其实，这是不科学的，因为苹果爸爸公司保留使用所有“两字母前缀”的权利，所以自己的前缀应该是三个字母的，不仅仅是类名，还有分类、全局变量...


#### 🇦🇩 第16条：提供“全能初始化方法”
* 在类中提供一个全能初始化方法，并于文档里指明。其他初始化方法均应调用此方法。
* 若全能初始化方法与超类不同，则需覆写超类中对应的方法
* 如果超类的初始化方法不适应于子类，那么应该覆写这个超类方法，并在其中抛出异常

举一个生动形象的例子：
Chinese 类

```objective-c
//.h
//  中国人
#import <Foundation/Foundation.h>
@interface Chinese : NSObject
@property (nonatomic, copy, readonly) NSString *firstName;
@property (nonatomic, copy, readonly) NSString *lastName;
@property (nonatomic, assign, readonly) NSUInteger age;
/// 全能初始化对象方法
- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSUInteger)age;
/// 全能初始化类方法
+ (instancetype)chineseWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSUInteger)age;
/// 其他初始化对象方法
+ (instancetype)chineseWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;
@end

//.m
#import "Chinese.h"
@interface Chinese()
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, assign) NSUInteger age;
@end
@implementation Chinese
/// 全能初始化函数-只有全能初始化函数才能进行赋值操作
- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSUInteger)age {
    if (self = [super init]) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.age = age;
    }
    return self;
}
+ (instancetype)chineseWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSUInteger)age {
    Chinese *people = [[self alloc] initWithFirstName:firstName lastName:lastName age:age];
    return people;
}
- (instancetype)init {
    return [self initWithFirstName:@"龙的" lastName:@"传人" age:1]; // 调用指定初始化函数赋予其默认值
}
+ (instancetype)chineseWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    return [self chineseWithFirstName:firstName lastName:lastName age:1];
}
@end
```

Student 类继承自 Chinese

```objective-c
//.h
//  中国学生
#import "Chinese.h"
@interface Student : Chinese
@property (nonatomic, strong, readonly) NSArray *homework;
/// 指定初始化函数-需直接调用父类初始化函数
- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSUInteger)age homework:(NSArray *)homework;
/// 指定初始化类方法
+ (instancetype)studentWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSUInteger)age homework:(NSArray *)homework;
/// 其他初始化方法
+ (instancetype)studentWithHomework:(NSArray *)homework;
@end

//.m
#import "Chinese.h"
@implementation Student {
    NSMutableArray *p_homework;
}
/// 子类重写父类全能初始化函数-更改默认值!
- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSUInteger)age {
    return [self initWithFirstName:firstName lastName:lastName age:age homework:@[]];
}
/// 指定初始化函数-需直接调用父类初始化函数
- (instancetype)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSUInteger)age homework:(NSArray *)homework {
    if (self = [super initWithFirstName:firstName lastName:lastName age:age]) {
        p_homework = homework.mutableCopy;
    }
    return self;
}
/// 指定初始化类方法
+ (instancetype)studentWithFirstName:(NSString *)firstName lastName:(NSString *)lastName age:(NSUInteger)age homework:(NSArray *)homework {
    return [[self alloc] initWithFirstName:firstName lastName:lastName age:age homework:homework];
}
/// 重写系统初始化方法
- (instancetype)init {
    return [self initWithFirstName:@"祖国的" lastName:@"花朵" age:6 homework:@[]];
}
/// 其他初始化方法
+ (instancetype)studentWithHomework:(NSArray *)homework {
    return [self studentWithHomework:homework];
}
@end
```

#### 🇦🇴 第17条：实现 `description` 方法
* 实现 `description` 方法返回一个有意义的字符串，用以描述该实例
* 若想在调试时打印出更详尽的对象描述信息。则应实现 `debugDescription` 方法

若直接打印自定义对象，控制台仅仅是显示该对象的地址，不会显示对象的具体细节，在程序开发中对象指针的地址或许有用，但大多数情况下，我们需要得知对象内部的具体细节，所以OC提供了 `description` 方法可以实现。

```objective-c
@interface Chinese()
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, assign) NSUInteger age;
@end
@implementation Chinese
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@ : %p, %@>",[self class],self,
            @{
              @"firstName":_firstName,
              @"lastName" :_lastName,
              @"age": @(_age)
              }];
}
@end
```
这种使用字典输出各属性或成员变量内存的方式比较好，若之后需要增删属性直接修改字典的键值对就可以了。
另外 `debugDescription` 方法是在控制台使用 `po` 命令打印对象信息所调用的方式，若已经实现 `description` 方法, 可不覆写 `debugDescription` 方法,因为系统会默认调用 `description` 方法。

#### 🇦🇮 第18条：尽量使用不可变对象
* 尽量创建不可变对象
* 若某属性尽可用于对象内部修改，则在 “class-continuation分类” 中将其由readonly属性扩展为readwrite属性
* 不要把可变对象的collection作为属性公开，而应提供相关方法，以此修改对象中的可变 collection

 在开发自定义类时，在 .h 里声明的属性尽量设置为不可变，只读的属性，外界只能通过特定的方法更改其内容，这对于一个功能的封装性是至关重要的。例如我们之前所声明的 `Student` 类:
 
```objective-c
// .h
@interface Student : Chinese
@property (nonatomic, copy, readonly) NSString *school;
@property (nonatomic, strong, readonly) NSArray *homework;

- (void)addHomeworkMethod:(NSString *)homework;
- (void)removeHomeworkMethod:(NSString *)homework;
@end

// .m
@interface Student()
@property (nonatomic, copy) NSString *school;
@end
@implementation Student {
    NSMutableArray *p_homework;
}
- (void)addHomeworkMethod:(NSString *)homework {
    [p_homework addObject:homework];
}
- (void)removeHomeworkMethod:(NSString *)homework {
    [p_homework removeObject:homework];
}
- (instancetype)initWithSchool:(NSString *)school homework:(NSArray *)homework {
    if (self = [self init]) {
        self.school = school;
        p_homework = homework.mutableCopy;
    }
    return self;
}
@end
```
如此定义外界只能通过固定的方法对对象内的属性进行更新，便于功能的封装，减少 bug 出现的概率。
另外使用不可变对象也增强程序的执行效率。


#### 🇦🇬 第19条：使用清晰而协调的命名方式
* 起名时应遵从标准的 Objective-C命名规范，这样创建出来的接口更容易为开发者所理解
* 方法名要言简意赅，从左至右读起来要像个日常用语的句子才好
* 方法名里不要使用缩略后的类型名称
* 给方法起名时的第一要务就是确保其风格与你自己的代码或所要集成的框架相符

就是说在为自己创建的属性、成员变量、方法、协议等起名要见名知意。

#### 🇦🇹 第20条：为私有方法名加前缀
* 给私有方法的名称加上前缀，这样可以很容易地将其同公共方法区分开
* 不要单用一个下划线做私有方法的前缀，因为这种做法是预留给苹果公司用的

对于一个写好的类而言，若为公开方法更改名称，则需要在外部调用此类的方法的地方同样做修改，这样比较麻烦，在类内部实现的私有方法不会有这个问题，所以为私有方法加前缀可更好的区分两者。便于后期开发。用何种前缀取决于开发者的开发习惯，不建议使用下划线开头的前缀，因为这是Apple Dad 专属的方式。作者的习惯是私有方法的前缀是 `p_` ,例如：

```objective-c
/// 这是一个私有方法
- (id)p_playAirplaneMethod {
    id xx = @"**";
    return xx;
}
```

#### 🇦🇽 第21条：理解 Objective-C 错误类型
* 只有发生了可使整个应用程序崩溃的严重错误时，才应使用异常
* 在错误不那么严重的情况下，可以指派 “委托方法” 来处理错误，也可以把错误信息放在 `NSError`对象里，经由“输出参数”返回给调用者

在项目中可以自定义一个错误类型模型：

```objective-c
//  .h
//  自定义错误类型
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, XWErrorCode) {
    XWErrorCodeUnknow       = -1, //未知错误
    XWErrorCodeTypeError    = 100,//类型错误
    XWErrorCodeNullString   = 101,//空字符串
    XWErrorCodeBadInput     = 500,//错误的输入
};
extern NSString * const XWErrorDomain;
@interface XWError : NSError
+ (instancetype)errorCode:(XWErrorCode)errorCode userInfo:(NSDictionary *)userInfo;
@end

// .m
#import "XWError.h"
@implementation XWError
NSString * const XWErrorDomain = @"XWErrorDomain";
+ (instancetype)errorCode:(XWErrorCode)errorCode userInfo:(NSDictionary *)userInfo {
    XWError *error = [[XWError alloc] initWithDomain:XWErrorDomain code:errorCode userInfo:userInfo];
    return error;
}
@end
```
在调试程序合适的回调中可传入自定义错误信息。

#### 🇦🇺 第22条：理解 `NSCopying` 协议
* 若想令自己所写的对象具有拷贝功能，则需实现 `NSCopying` 协议
* 如果自定义的对象分为可变版本和不可变版本。那么就要同时实现 `NSCopying` 协议 与 `NSMutableCopying` 协议
* 赋值对象时需决定采用浅拷贝还是深拷贝，一般情况下应该尽量执行浅拷贝
* 如果你写的对象需要深拷贝，那么可考虑新增一个专门执行深拷贝的方法

我想让我创建的 `1Student` 类具备拷贝属性，那我需要实现 `NSCopying` 协议，实现它仅有的一个 `- (id)copyWithZone:(nullable NSZone *)zone` 方法。 如下:

```objective-c
@interface Student() <NSCopying>
@end
@implementation Student {
    NSMutableArray *p_homework;
}
#pragma mark - NSCopying
- (id)copyWithZone:(nullable NSZone *)zone {
    Student *stuCopy = [[Student allocWithZone:zone] initWithFirstName:self.firstName lastName:self.lastName age:self.age homework:p_homework.copy];
    return stuCopy;
}
```
如此在调用 `Student` 的 `copy` 方法便会生成一个内容相同的不同 `Student` 对象

```objective-c
Student *stu = [Student studentWithFirstName:@"小极客" lastName:@"学伟" age:6 homework:@[@"小提琴",@"篮球"]];
Student *stu2 = [stu copy];
```

若希望自定义对象拥有 深拷贝 功能，那需要实现 `NSMutableCopying` 协议，并实现其唯一的方法 
`- (id)mutableCopyWithZone:(nullable NSZone *)zone` 具体实现如下：

```objective-c
#pragma mark - NSMutableCopying
- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    Student *stuMtableCopy = [[Student allocWithZone:zone] initWithFirstName:self.firstName lastName:self.lastName.mutableCopy age:self.age homework:p_homework.copy];
    return stuMtableCopy;
}
```

补充一个 Array 和 Dictionary 分别指向浅复制和深复制之后的类型列表：
##### Array
首先声明两个数组：

```objective-c
NSArray *array = @[@1,@2];
NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
```
对其进行浅拷贝和深拷贝，打印结果如下：

```objective-c
2018-08-01 11:46:32.255187+0800 XWInterviewDemos[80249:5837261] [array copy]:__NSArrayI
2018-08-01 11:46:32.255337+0800 XWInterviewDemos[80249:5837261] [array mutableCopy]:__NSArrayM
2018-08-01 11:46:32.255431+0800 XWInterviewDemos[80249:5837261] [mutableArray copy]:__NSArrayI
2018-08-01 11:46:32.255516+0800 XWInterviewDemos[80249:5837261] [mutableArray mutableCopy]:__NSArrayM
```
其中 `__NSArrayI` 为不可变数组，`__NSArrayM` 为可变数组,结论：

| 原类 | 操作 | 拷贝结果|
|:---|:---|:---|
| NSArray |浅拷贝（copy） | 不可变（__NSArrayI）|
| NSArray | 深拷贝（mutableCopy）| 可变（__NSArrayM）|
| NSMutableArray | 浅拷贝（copy） | 不可变（__NSArrayI）|
| NSMutableArray | 深拷贝（mutableCopy） | 可变（__NSArrayM）|

##### Dictionary
首先声明两个字典：

```objective-c
NSDictionary *dictionary = @{@"key":@"value"};
NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
```
对其进行浅拷贝和深拷贝，打印结果如下：

```objective-c
2018-08-01 11:57:20.810019+0800 XWInterviewDemos[80385:5844478] [dictionary copy]:__NSSingleEntryDictionaryI
2018-08-01 11:57:20.810162+0800 XWInterviewDemos[80385:5844478] [dictionary mutableCopy]:__NSDictionaryM
2018-08-01 11:57:20.810277+0800 XWInterviewDemos[80385:5844478] [mutableDictionary copy]:__NSFrozenDictionaryM
2018-08-01 11:57:20.810374+0800 XWInterviewDemos[80385:5844478] [mutableDictionary mutableCopy]:__NSDictionaryM
```
其中 `__NSSingleEntryDictionaryI` 和 `__NSFrozenDictionaryM` 为不可变字典，`__NSDictionaryM` 为可变字典,结论：

| 原类 | 操作 | 拷贝结果|
|:---|:---|:---|
| NSDictionary |浅拷贝（copy） | 不可变（__NSSingleEntryDictionaryI）|
| NSDictionary | 深拷贝（mutableCopy）| 可变（__NSDictionaryM）|
| NSMutableDictionary | 浅拷贝（copy） | 不可变（__NSFrozenDictionaryM）|
| NSMutableDictionary | 深拷贝（mutableCopy） | 可变（__NSDictionaryM）|


### 第4章：协议与分类
#### 🇦🇩 第23条：通过委托与数据源协议进行对象间通信

