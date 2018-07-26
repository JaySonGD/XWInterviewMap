
# 面试题们

## 2018.7.10 掘金面试
#### 1.在OC中，NSNumber对象 是用什么方式来存储的

#### 2.怎样使用 `performSeletctor` 传入三个以上参数，其中一个为结构体

#### 3.发现程序崩溃在一个 `objc_msgSend` 函数里面，这时候可以看到当前正在调用哪个对象的哪个selector吗？

#### 4.自旋锁和互斥锁的区别

#### 5.内存泄漏可能出现的几种原因？列举其中4种

#### 6.iOS 系统是如何找到最合适的控件来处理事件的

#### 7.http 和 https 区别

#### 8.MVVM 的使用，特点

#### 9.UI 卡顿的原因？

#### 10.GCD 的用法列举

#### 11.组件化的使用，部分命令

#### 12.CAAnimation 动画

#### 13.程序的编译过程

#### 14.优化网络异国通讯方法

#### 15.DCP/UDP 区别？


## 2018.7 月 iOS面试题汇总（网易/拼多多/爱奇艺）
#### 面试题源自 [掘金博文-iOS面试题汇总（网易/拼多多/爱奇艺）](https://juejin.im/post/5b43031c6fb9a04fcb5b4650)

### 编程语言及iOS的特性
#### 1. 内存泄漏和野指针的区别
> 用动态存储分配函数动态开辟的空间，在使用完毕后未释放，结果导致一直占据该内存单元。直到程序结束。即所谓内存（堆内存）泄漏。（循环引用- __weak __typeof(self) weakSelf = self ）
> 指向一个已删除的对象或未申请访问受限内存区域的指针。（delegate 置nil 后访问）

#### 2.property后的关键字相关，注意copy
> atomic/nonatomic/readOnly/readWrite/assign/strong/weak/copy/
> copy - 传入不可变类型同strong，引用计数+1、传入可变类型会进行一次拷贝，指向新内存地址。

#### 3.block用什么修饰
> MRC: 必须使用 copy 将 block 由栈区转移到堆区。
> ARC: copy 和 strong 相同

#### 4.NSString 和 NSArray 用strong修饰会有什么问题
> 他们有相应的可变类型，若将 NSMutableString 和 NSMutableArray 赋值给原 NSString 和 NSArray，并且使用 strong 修饰，那原NSString 和 NSArray 将会可变类型的内容。

#### 5.iOS的内存管理机制
> 引用计数规则。谁创建，谁释放。被强引用一次，引用计数加1，引用计数为 0 时，对象被释放。

#### 6.什么时候会出现循环引用，__weak、__strong、__block分别是什么作用
> 两个及以上对象之间相互强引用（持有）。
> __weak 弱引用对象，避免循环引用
> __strong 强引用对象，通常在block内部使用，在block内部不会被释放
> __block 使用__block 修饰的对象，若block内部使用这个对象，在block内部会在堆区生成一个新对象，指向原对象。

#### 7.说一下 Autoreleasepool
> 自动释放池，在池内创建的对象会在结束后立即被释放。

#### 8. Autoreleasepool怎么做到释放对象的
> 系统在每个runloop迭代中都加入了自动释放池Push和Pop
> [sunnyxx - 黑幕背后的Autorelease](https://blog.sunnyxx.com/2014/10/15/behind-autorelease/)

#### 9.nil Nil NULL NSNull的区别
> nil : 对象为空
> Nil : 类为空
> NULL ： 基本数据对象指针为空
> NSNull: 集合对象无法包含 nil 作为其具体值，如NSArray、NSSet和NSDictionary。相应地，nil 值用一个特定的对象 NSNull 来表示。NSNull 提供了一个单一实例用于表示对象属性中的的nil值。

#### 10.oc中调用nil的方法会返回nil或0，但有些时候有特殊情况，不是真正意义上的空/0，举例
> OC 调用方法实际是发消息：objc_msgSend 

#### 11.返回struct的方法并没有走send message，走的什么
> 没懂

#### 12.列举修饰符中，内存管理相关关键字及其作用
> assign： assign用于非指针变量，一般用于基础类型和C数据类型，这些类型不是对象，统一由系统栈进行内存管理。
> weak：对对象的弱引用，不增加对象的引用计数，也不持有对象，当对象消失后指针自动指向nil，所以这里也就防止了野指针的存在。
> strong：对对象的强引用，会增加对象的引用计数，如果指向了一个空对象，会造成野指针，平常我们用得最多的应该也是strong了。
> copy：建立一个引用计数为1的新对象，赋值时对传入值进行一份拷贝，所以使用copy关键字的时候，你将一个对象复制给该属性，该属性并不会持有那个对象，而是会创建一个新对象，并将那个对象的值拷贝给它。而使用copy关键字的对象必须要实现NSCopying协议。

#### 13.Category中使用@property方式添加的属性，实质是什么？支持KVO吗？
> 只会生成 setter 和 getter 方法声明
> 不支持。

#### 14.isa指针是什么
> isa 实质是一个 objc_class 结构体
> 任何对象都有 isa 指针，用于存储对象的成员变量，属性，方法列表，协议列表等信息

#### 15.meta-class是什么
> 元类，每一个类的isa都会指向他的元类，元类中存储类方法

#### 16.NSDictionary的实现
> NSDictionary（字典）是使用 hash表来实现key和value之间的映射和存储的， hash函数设计的好坏影响着数据的查找访问效率。数据在hash表中分布的越均匀，其访问效率越高。而在Objective-C中，通常都是利用NSString 来作为键值，其内部使用的hash函数也是通过使用 NSString对象作为键值来保证数据的各个节点在hash表中均匀分布。

#### 17.OC调用C++ 的方式有哪些
> 项目里导入：libstdC++
> 创建 .h .cpp 编写 c++
> 创建 .mm 混编
> [混编经验](https://awhisper.github.io/2016/05/01/%E6%B7%B7%E7%BC%96ObjectiveC/)

#### 18.runloop的理解，几种模式优先级排序
> 保证程序能持续处理用户的所有交互，程序产生的所有事件等。保证程序持续运行，
>1. kCFRunLoopDefaultMode：App的默认Mode，通常主线程是在这个Mode下运行
>2. UITrackingRunLoopMode：界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响
>3. UIInitializationRunLoopMode: 在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用
>4. GSEventReceiveRunLoopMode: 接受系统事件的内部 Mode，通常用不到
>5. kCFRunLoopCommonModes: 这是一个占位用的Mode，作为标记kCFRunLoopDefaultMode和UITrackingRunLoopMode用，并不是一种真正的Mode
>  [runloop 详解](https://blog.csdn.net/qxuewei/article/details/80257001)

#### 19.runloop是怎么实现的
> while (1){}

#### 20. iOS中有哪些方法创建线程
> `NSThread* myThread = [[NSThread alloc] initWithTarget:self
selector:@selector(myThreadMainMethod:)
object:nil];`
> GCD
> NSOperationQueue

#### 21.gcd once怎么保证once
> 加锁，单例对象
> [GCD源码分析2 —— dispatch_once篇](http://lingyuncxb.com/2018/02/01/GCD%E6%BA%90%E7%A0%81%E5%88%86%E6%9E%902%20%E2%80%94%E2%80%94%20dispatch-once%E7%AF%87/)

#### 22.GCD串行/并行队列以及sync/async的问题
> 如下：

#### 23. NSOprationQueue 与 GCD 的区别与选用
> [NSOprationQueue 与 GCD 的区别与选用](https://www.jianshu.com/p/d09e2638eb27)

#### 24.OC中提供哪些可扩展的方式
> 分类，扩展，继承，协议

#### 25.动态库和静态库的区别有哪些
> 动态库形式：.dylib 和 .framework
> 静态库形式：.a 和 .framework
> 系统的.framework是动态库，我们自己建立的.framework是静态库。
> 静态库：链接时，静态库会被完整地复制到可执行文件中，被多次使用就有多份冗余拷贝
> 系统动态库：链接时不复制，程序运行时由系统动态加载到内存，供程序调用，系统只加载一次，多个程序共用，节省内存
> 
> [动态库和静态库的区别](https://www.jianshu.com/p/42891fb90304)  [iOS 动态库和静态库简介](https://juejin.im/post/5a323c035188257dd239abc2)

#### 26.displaylink和timer的区别
> displaylink : 屏幕刷新时调用 60次/秒
> timer ： 自己控制

#### 27.如何自己实现timer


#### 28.不用runtime中的exchange，还有什么方法能达到hook的效果

#### 29.用runtime交换方法，有些情况下，可能会出问题，怎么解决的

#### 30.iOS的响应链（详细过程），可以用什么方法影响到响应链

#### 31.iOS的锁有哪些？介绍一下自旋锁
> [](https://bestswifter.com/ios-lock/)

#### 31.OC的编译过程

##2018年1月iOS招人心得（附面试题）- 答案整理
本文源自对这篇博客 '2018年1月iOS招人心得（附面试题）<https://www.jianshu.com/p/c362446183ee>' 面试内容的整理, 博主对招聘初中级iOS开发颇有一番研究, 所整理的面试题也很具有代表性. 下面结合互联网和自身理解, 对本文所列面试题答案进行整理.

###1.技术基础
####1、为什么说Objective-C是一门动态的语言？
> 这里的动态和静态是相对的,动态的意思是不需要在编译时确定所有的东西,在运行时也可以动态添加变量,属性,方法和类. Objective-C 可以通过Runtime这个运行时机制,在运行时动态的添加变量,方法和类等,所以说Objective-C是一门动态的语言. 
> Objective-C的动态性，让程序在运行时判断其该有的行为，而不是像c等静态语言在编译构建时就确定下来。它的动态性主要体现在3个方面：
	1.动态类型：如id类型。实际上静态类型因为其固定性和可预知性而使用的特别广泛。静态类型是强类型，动态类型是弱类型，运行时决定接收者。
	2.动态绑定：让代码在运行时判断需要调用什么方法，而不是在编译时。与其他面向对象语言一样，方法调用和代码并没有在编译时连接在一起，而是在消息发送时才进行连接。运行时决定调用哪个方法。
	3.动态载入。让程序在运行时添加代码模块以及其他资源。用户可以根据需要执行一些可执行代码和资源，而不是在启动时就加载所有组件。可执行代码中可以含有和程序运行时整合的新类。

####2、讲一下MVC和MVVM，MVP？
> 	•	Models（模型） — 数据层，或者负责处理数据的 数据接口层。比如 Person 和 PersonDataProvider 类
	•	Views（视图） - 展示层(GUI)。对于 iOS 来说所有以 UI 开头的类基本都属于这层。
	•	Controller/Presenter/ViewModel（控制器/展示器/视图模型） - 它是 Model 和 View 之间的胶水或者说是中间人。一般来说，当用户对 View 有操作时它负责去修改相应 Model；当 Model 的值发生变化时它负责去更新对应 View。
#####MVC
> ![MVC](https://dn-coding-net-production-pp.qbox.me/8d779f6a-265b-43c3-90be-dc9997b9963d.png)
	Controller： 控制器层，它是 Model 和 View 之间的胶水或者说是中间人。一般来说，当用户对 View 有操作时它负责去修改相应 Model；当 Model 的值发生变化时它负责去更新对应 View。
#####MVVM
> ![MVVM](https://dn-coding-net-production-pp.qbox.me/1b8ff549-4fa4-489a-adf3-e8ba52e6bb96.png)
	在MVVM 中，view 和 view controller正式联系在一起，我们把它们视为一个组件
view 和 view controller 都不能直接引用model，而是引用视图模型（viewModel）
viewModel 是一个放置用户输入验证逻辑，视图显示逻辑，发起网络请求和其他代码的地方
#####MVP
> ![MVP](https://dn-coding-net-production-pp.qbox.me/d8ad72b3-f150-4988-af6f-0db785c40793.png)
	MVP 是从经典的模式MVC演变而来，它们的基本思想有相通的地方：Controller/Presenter负责逻辑的处理，Model提供数据，View负责显示。作为一种新的模式，MVP与MVC有着一个重大的区别：在MVP中View并不直接使用Model，它们之间的通信是通过Presenter (MVC中的Controller)来进行的，所有的交互都发生在Presenter内部，而在MVC中View会从直接Model中读取数据而不是通过 Controller。

参考资料:
* <https://blog.coding.net/blog/ios-architecture-patterns>
* <https://www.jianshu.com/p/eedbc820d40a>
* <http://blog.csdn.net/li_shuang_ls/article/details/50176891>
* <https://www.jianshu.com/p/33c7e2f3a613>

####3、为什么代理要用weak？代理的delegate和dataSource有什么区别？block和代理的区别?
>1.为什么代理要用weak？
   防止循环引用。例如View有一个协议，需要一个代理实现回调。一个Controller添加这个View，并且遵守协议，成为View的代理。如果不用week，用strong，Controller ->View -> delegate -> Controller，就循环引用了。

>2.代理的delegate和dataSource有什么区别？
   delegate偏重于与用户交互的回调，有那些方法可以供我使用，例如UITableviewDelegate；dataSource偏重于数据的回调，view里面有什么东西，属性都是什么，例如UITableviewDatasource；

>3.block和代理的区别?
> 1.block简介
    在 iOS中， block一共分三种。
  (1)全局静态 block，不会访问任何外部变量，执行完就销毁。

```
    ^{
        NSLog(@"Hello World!");
    }();
```
 
  (2)保存在栈中的 block，当函数返回时会被销毁，和第一种的区别就是调用了外部变量。

```
    [UIView animateWithDuration:3 animations:^{
       
        self.view.backgroundColor = [UIColor redColor];
    }];
``` 
 (3)保存在堆中的 block，当引用计数为 0 时会被销毁。例如按钮的点击事件，一直存在，即使执行过，也不销毁，因为按钮还可能被点击，持有按钮的View被销毁，它才会被销毁。

>2.block优点
    block的代码可读性更好。因为应用block和实现block的地方在一起。代理的声明和实现就分开来了，在两个类中。代理使用起来也更麻烦，因为要声明协议、声明代理、遵守协议、实现协议里的方法。block不需要声明，也不需要遵守，只需要声明和实现就可以了。
  block是一种轻量级的回调，可以直接访问上下文，由于block的代码是内联的，运行效率更高。block就是一个对象，实现了匿名函数的功能。所以我们可以把block当做一个成员变量、属性、参数使用，使用起来非常灵活。像用AFNetworking请求数据和GCD实现多线程，都使用了block回调。

>3.block缺点
    blcok的运行成本高。block出栈需要将使用的数据从栈内存拷贝到堆内存，当然对象的话就是引用计数加1，使用完或者block置nil后才销毁。delegate只是保存了一个对象指针(一定要用week修饰delegate，不然也会循环引用)，直接回调，没有额外消耗。就像C的函数指针，只多做了一个查表动作。
    block容易造成循环引用，而且不易察觉。因为为了blcok不被系统回收，所以我们都用copy关键字修饰，实行强引用。block对捕获的变量也都是强引用，所以就会造成循环引用。

> 4.如何使用
优先使用block。
  如果回调函数很多，多余三个使用代理。
  如果回调的很频繁，次数很多，像UITableview，每次初始化、滑动、点击都会回调，使用代理。
  
>5. 代理和Block的区别
相同点：代理和Block大多是我们都可以用来做倒序传值的。我们都得注意避免循环引用。不然我们去使用代理还是Block的时候，都需要判断它们是否实现
不同点：代理使用weak修饰，代理必须先声明方法。当我们调用代理的时候要判断是否已经实现。
block：使用的是copy来修饰，block保存的是一段代码，其实也就是一个函数。并且可以自动捕捉自动变量，如果想修改此自动变量，还必须使用__block修饰。
  
参考资料:
* <https://www.jianshu.com/p/6bba9b4a25d5>

####4、属性的实质是什么？包括哪几个部分？属性默认的关键字都有哪些？@dynamic关键字和@synthesize关键字是用来做什么的？
> 属性是一个类中用来描述对象的抽象概念。
> 属性包括的部分有setter和getter方法
> 
```
atomic: 
nonatomic:
@synthesize
@dynamic
getter=getterName
setter=setterName
readwrite
readonly
assign
retain
copy
```
>@synthesize
如果没有实现setter和getter方法，编译器将会自动在生产setter和getter方法。

>@dynamic
表示变量对应的属性访问器方法 , 是动态实 现的 , 你需要在 NSObject 中继承而来的 +(BOOL) resolveInstanceMethod:(SEL) sel 方法中指定 动态实现的方法或者函数。
属性修饰其他关键字：

参考
*<http://www.wimhe.com/archives/46>
*<http://www.wimhe.com/archives/47>

####5、属性的默认关键字是什么？
>默认关键字，基本数据： atomic,readwrite,assign
>普通的 OC 对象: atomic,readwrite,strong

####6、NSString为什么要用copy关键字，如果用strong会有什么问题？（注意：这里没有说用strong就一定不行。使用copy和strong是看情况而定的）
>
```
// 深复制
Person *xiaoMing = [[Person alloc] init];
NSMutableString * name = [[NSMutableStringalloc] initWithString:@"xiaoming"];
//name.string = @"xiaoming";
xiaoMing.name = name;
NSLog(@"%@", xiaoMing.name);
[name appendString:@"hah"];

//此时名字这个属性被修改了
NSLog(@"%@", xiaoMing.name);
```
如果用Copy来修饰name这个属性不会改变，
如果使用Strong，当name这个字符串改变的时候，name这个属性也会随着改变。
补充：这其实也是看需求，看被赋值的字符串是否需要随着赋值字符串的变化而变化，而大多数情况下我们不希望被赋值的字符串如某个对象的某个字符串类型的属性会随着赋值字符串的变化而变化。 反之，如果我们希望被赋值的字符串随着赋值字符串的变化而变化，那么我们也可以使用strong来修饰字符串

参考:
*<https://www.jianshu.com/p/499f2927717c>

####7、如何令自己所写的对象具有拷贝功能?
>需实现 NSCopying 协议。如果自定义的对象分为可变版本与不可变版本，那么就要同时实现 NSCopying与 NSMutableCopying协议。
>具体步骤：
需声明该类遵从 NSCopying 协议
实现 NSCopying 协议。该协议只有一个方法:
`- (id)copyWithZone:(NSZone *)zone;`
注意：一提到让自己的类用 copy 修饰符，我们总是想覆写copy方法，其实真正需要实现的却是 “copyWithZone” 方法。
至于如何重写带 copy 关键字的 setter这个问题，
如果抛开本例来回答的话，如下：

```
- (void)setName:(NSString *)name {
    //[_name release];
    _name = [name copy];
}
```
 参考:
 *<https://dayon.gitbooks.io/-ios/content/chapter5.html>
 
####8、可变集合类 和 不可变集合类的 copy 和 mutablecopy有什么区别？如果是集合是内容复制的话，集合里面的元素也是内容复制么？
>使用copy时 可变集合的指针地址以及内存地址都不相同  深复制  不可变集合的指针地址不一样但是内存地址一样 属于浅复制
>使用mutableCopy的时候无论是可变集合还是不可变集合的指针地址和内存地址都不同 都属于深复制
>
```
- (void)testCopy {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithObject:@"mutableArray"];
    NSArray *array = [NSArray arrayWithObject:@"array"];
    id copy_mutableArray = mutableArray.copy;
    id copy_array = array.copy;
    id mutableCopy_mutableArray = mutableArray.mutableCopy;
    id mutableCopy_array = array.mutableCopy;
    NSLog(@"mutableArray:%@ ,内存地址%p -- 指针地址%p",mutableArray,mutableArray,&mutableArray);
    NSLog(@"array:%@ ,内存地址%p -- 指针地址%p",array,array,&array);
    NSLog(@"copy_mutableArray:%@ ,内存地址%p -- 指针地址%p",copy_mutableArray,copy_mutableArray,&copy_mutableArray);
    NSLog(@"copy_array:%@ ,内存地址%p -- 指针地址%p",copy_array,copy_array,&copy_array);
    NSLog(@"mutableCopy_mutableArray:%@ ,内存地址%p -- 指针地址%p",mutableCopy_mutableArray,mutableCopy_mutableArray,&mutableCopy_mutableArray);
    NSLog(@"mutableCopy_array:%@ ,内存地址%p -- 指针地址%p",mutableCopy_array,mutableCopy_array,&mutableCopy_array);
    
}
```
>打印输出:

```
2018-02-28 08:12:02.322754+0800 XWBlogsDemos[6646:275862] mutableArray:(
    mutableArray
) ,内存地址0x60400025ec90 -- 指针地址0x7ffee2eb0b48
2018-02-28 08:12:02.322913+0800 XWBlogsDemos[6646:275862] array:(
    array
) ,内存地址0x604000019010 -- 指针地址0x7ffee2eb0b40
2018-02-28 08:12:02.323038+0800 XWBlogsDemos[6646:275862] copy_mutableArray:(
    mutableArray
) ,内存地址0x604000019090 -- 指针地址0x7ffee2eb0b38
2018-02-28 08:12:02.323140+0800 XWBlogsDemos[6646:275862] copy_array:(
    array
) ,内存地址0x604000019010 -- 指针地址0x7ffee2eb0b30
2018-02-28 08:12:02.323236+0800 XWBlogsDemos[6646:275862] mutableCopy_mutableArray:(
    mutableArray
) ,内存地址0x60400025ef90 -- 指针地址0x7ffee2eb0b28
2018-02-28 08:12:02.323333+0800 XWBlogsDemos[6646:275862] mutableCopy_array:(
    array
) ,内存地址0x60400025ee70 -- 指针地址0x7ffee2eb0b20

```
####9、为什么IBOutlet修饰的UIView也适用weak关键字？
>在xib或者Sb拖控件时，其实控件就加载到了父控件的subviews数组里面，进行了强引用，使用weak，避免循环引用

####10、nonatomic和atomic的区别？atomic是绝对的线程安全么？为什么？如果不是，那应该如何实现？
>nonatomic:表示非原子，不安全，但是效率高。
>atomic：表示原子行，安全，但是效率定。
>atomic,不能绝对保证线程的安全，当多线程同时访问的时候，会造成线程不安全。可以使用线程锁来保证线程的安全。

####11、UICollectionView自定义layout如何实现？
>实现一个自定义layout的常规做法是继承UICollectionViewLayout类，然后重载下列方法：

```
-(CGSize)collectionViewContentSize
返回collectionView的内容的尺寸
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
返回rect中的所有的元素的布局属性
返回的是包含UICollectionViewLayoutAttributes的NSArray
UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视    图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
   layoutAttributesForCellWithIndexPath:
   layoutAttributesForSupplementaryViewOfKind:withIndexPath:
layoutAttributesForDecorationViewOfKind:withIndexPath:
  -(UICollectionViewLayoutAttributes )layoutAttributesForItemAtIndexPath:(NSIndexPath )indexPath
返回对应于indexPath的位置的cell的布局属性
-(UICollectionViewLayoutAttributes )layoutAttributesForSupplementaryViewOfKind:(NSString )kind atIndexPath:(NSIndexPath *)indexPath
返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载
-(UICollectionViewLayoutAttributes * )layoutAttributesForDecorationViewOfKind:(NSString)decorationViewKind atIndexPath:(NSIndexPath )indexPath
返回对应于indexPath的位置的装饰视图的布局属性，如果没有装饰视图可不重载
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。

```
####12、用StoryBoard开发界面有什么弊端？如何避免？
>使用简单逻辑页面的跳转是可以使用sb的，开发比较块。
但是SB对于逻辑项目比较复杂的时候，开发起来比较慢。不适合多人合作开发；也不利于版本的梗系和后期的维护。使用sb在项目变异编译的时候，也都会直接加载到内存中，造成内存的浪费。
>可以使用xib来代替，编辑复杂逻辑界面时候可以使用纯码编写。

####13、进程和线程的区别？同步异步的区别？并行和并发的区别？
>进程：是具有一定独立功能的程序关于某个数据集合上的一次运行活动,进程是系统进行资源分配和调度的一个独立单位.
>线程：是进程的一个实体,是CPU调度和分派的基本单位,它是比进程更小的能独立运行的基本单位.线程自己基本上不拥有系统资源,只拥有一点在运行中必不可少的资源(如程序计数器,一组寄存器和栈),但是它可与同属一个进程的其他的线程共享进程所拥有的全部资源.
>同步：阻塞当前线程操作，不能开辟线程。
>异步：不阻碍线程继续操作，可以开辟线程来执行任务。
>并发：当有多个线程在操作时,如果系统只有一个CPU,则它根本不可能真正同时进行一个以上的线程，它只能把CPU运行时间划分成若干个时间段,再将时间 段分配给各个线程执行，在一个时间段的线程代码运行时，其它线程处于挂起状。.这种方式我们称之为并发(Concurrent)。
>并行：当系统有一个以上CPU时,则线程的操作有可能非并发。当一个CPU执行一个线程时，另一个CPU可以执行另一个线程，两个线程互不抢占CPU资源，可以同时进行，这种方式我们称之为并行(Parallel)。
>区别：并发和并行是即相似又有区别的两个概念，并行是指两个或者多个事件在同一时刻发生；而并发是指两个或多个事件在同一时间间隔内发生。在多道程序环境下，并发性是指在一段时间内宏观上有多个程序在同时运行，但在单处理机系统中，每一时刻却仅能有一道程序执行，故微观上这些程序只能是分时地交替执行。倘若在计算机系统中有多个处理机，则这些可以并发执行的程序便可被分配到多个处理机上，实现并行执行，即利用每个处理机来处理一个可并发执行的程序，这样，多个程序便可以同时执行。

####14、线程间通信？
>当使用dispath-async函数开辟线程执行任务的完成时，我们需要使用dispatch_async(dispatch_get_main_queue(), ^{ });函数会到主线程内刷新UI。并完成通信

####15、GCD的一些常用的函数？（group，barrier，信号量，线程同步）
>
#####group:
 我们使用队列组来开辟线程时，队列组中的队列任务是并发，当所有的队列组中的所有任务完成时候，才可以调用队列组完成任务。

```
/**创建自己的队列*/
dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next", DISPATCH_QUEUE_CONCURRENT);
/**创建一个队列组*/
dispatch_group_t dispatchGroup = dispatch_group_create();
/**将队列任务添加到队列组中*/
dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
    NSLog(@"dispatch-1");
});
   /**将队列任务添加到队列组中*/
dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
    NSLog(@"dspatch-2");
});
  /**队列组完成调用函数*/
dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
    NSLog(@"end");
})

``` 
>
#####barrier:
表示栅栏，当在并发队列里面使用栅栏时候，栅栏之前的并发任务开始并发执行，执行完毕后，执行栅栏内的任务，等栅栏任务执行完毕后，再并发执行栅栏后的任务。

```
dispatch_queue_t concurrentQueue = dispatch_queue_create("my.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
dispatch_async(concurrentQueue, ^(){
    NSLog(@"dispatch-1");
});
dispatch_async(concurrentQueue, ^(){
    NSLog(@"dispatch-2");
});
dispatch_barrier_async(concurrentQueue, ^(){
    NSLog(@"dispatch-barrier"); 
});
dispatch_async(concurrentQueue, ^(){
    NSLog(@"dispatch-3");
});
dispatch_async(concurrentQueue, ^(){
    NSLog(@"dispatch-4");
});

```
>
#####信号量：
Semaphore是通过‘计数’的方式来标识线程是否是等待或继续执行的。[信号量](https://www.jianshu.com/p/04ca5470f212)

```
dispatch_semaphore_create(int) // 创建一个信号，并初始化信号的计数大小
/* 等待信号，并且判断信号量，如果信号量计数大于等于你创建时候的信号量的计数，就可以通过，继续执行，并且将你传入的信号计数减1，
 * 如果传入的信号计数小于你创建的计数，就表示等待，等待信号计数的变化
 *  如果等待的时间超过你传入的时间，也会继续下面操作
 *   第一个参数：semaphore 表示信号量
 *   第二个参数：表示等待的时间
 *    返回int 如果传入的信号计数大于等于你创建信号的计数时候，返回0.  反之，返回的不等于0
 */
 int result = dispatch_semaphore_wait(dispatch_semaphore_t  semaphore,time outTime);// 表示等待，也是阻碍线程  
// 表示将信号技术+1
dispatch_semaphore_signl(dispatch_semaphore_t semaphore);

```

```

- (void)semaphoreDemo1 {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    for (int i = 0; i < 100; i++) {
        //// 由于是异步执行的，所以每次循环Block里面的dispatch_semaphore_signal根本还没有执行就会执行dispatch_semaphore_wait，从而semaphore-1.当循环10此后，semaphore等于0，则会阻塞线程，直到执行了Block的dispatch_semaphore_signal 才会继续执行
        NSLog(@"i %zd",i);
        /// 执行十次之后阻塞当前线程
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
}

- (void)semaphoreDemo2 {
    dispatch_semaphore_t goOnSemaphore = dispatch_semaphore_create(0);
    NSLog(@"ready");
    [self network:^(id result) {
        NSLog(@"net return:%@",result);
        dispatch_semaphore_signal(goOnSemaphore);
    }];
    dispatch_semaphore_wait(goOnSemaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"go on");
}
- (void)network:(void(^)(id result))block {
    sleep(2.0);
    block(@(arc4random_uniform(2)));
}
```
#####实现线程的同步的方法：
串行队列，分组，信号量。也是可以使用并发队列。

```
//加入队列
dispatch_async(concurrentQueue, ^{
    //1.先去网上下载图片
    dispatch_sync(concurrentQueue, ^{
       
    });
    //2.在主线程展示到界面里
    dispatch_sync(dispatch_get_main_queue(), ^{

    });
});

```

####16、如何使用队列来避免资源抢夺？
>使用线程锁。也是可以使用串行队列来完成。如：fmdb就是使用FMDatabaseQueue，来解决多线程抢夺资源。

####17、数据持久化的几个方案（fmdb用没用过）
>持久化方案：
>plist,存储字典，数组比较好用
>preference：偏好设置，实质也是plist
>NSKeyedArchiver：归档，可以存储对象
>sqlite：数据库，经常使用第三方来操作，也就是fmdb
>coreData:也是数据库储存，苹果官方的

####18、说一下AppDelegate的几个方法？从后台到前台调用了哪些方法？第一次启动调用了哪些方法？从前台到后台调用了哪些方法？
>![启动流程图](https://upload-images.jianshu.io/upload_images/1773988-ab883455881116d0.gif)

####19、NSCache优于NSDictionary的几点？
>1.nscache 是可以自动释放内存的。
>2.nscache是线程安全的，我们可以在不同的线程中添加，删除和查询缓存中的对象。
>3.一个缓存对象不会拷贝key对象。

####20、知不知道Designated Initializer？使用它的时候有什么需要注意的问题？
> 初始化器. 创建子类时需要调用父类的的初始化器,并且需要重写父类的Designated Initializer，将其指向子类新的初始化器

```
//Designated Initializer
- (instancetype)initWithFrame:(CGRect)frame andName:(NSString *)name{
    //incorrect
    if (self = [super initWithFrame:frame]){
        self.name=name;
    }
    return self;
}    
//super override
- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame andName:@""];
}

```
参考:
* <https://www.jianshu.com/p/57db46f013d7>
* <http://www.cnblogs.com/smileEvday/p/designated_initializer.html>

####21、实现description方法能取到什么效果？
>description是nsobject的一个实例的方法，返回的是一个nsstring。当我们使用nslog打印的时候，打印出来的一般都是对象的内存地址，如果我们实现description方法时，我们就可以使用nslog打印对象的时候，我们可以把它里面的属性值和内存地址一起打印出来.打印什么，就是看你写什么了。

####22、objc使用什么机制管理对象内存？
>引用计数. 当内存管理计数器为0的时候,对象会被释放

###中级Block
####1、block的实质是什么？一共有几种block？都是什么情况下生成的？
>
#####block的实质是什么？
Block实质上就是Objective-C对象;
#####一共有几种block？
block一共有3种类型的block

>_NSConcreteGlobalBlock 全局静态
>_NSConcreteStackBlock 保存在栈中，出函数作用域就销毁
>_NSConcreteMallocBlock 保存在堆中，retainCount == 0销毁而ARC和MRC中，还略有不同;

参考:
* <https://www.jianshu.com/p/bb163c433f7c>
* <https://www.jianshu.com/p/dfdb1b379ea2>

####2、为什么在默认情况下无法修改被block捕获的变量？ __block都做了什么？
>Block只捕获Block中会用到的变量。由于只捕获了自动变量(自动变量是以值传递方式传递到Block的构造函数里面)的值，并非内存地址，所以Block内部不能改变自动变量的值。Block捕获的外部变量可以改变值的是静态变量，静态全局变量，全局变量

>参考:
*<https://halfrost.com/ios_block/?utm_source=tuicool&utm_medium=referral>

####3、模拟一下循环引用的一个情况？blok实现界面反向传值如何实现？
>
#####模拟一下循环引用的一个情况？
```
#import "ViewController.h"
#import "Student.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Student *student = [[Student alloc]init];
    student.name = @"Hello World";

    student.study = ^{
        NSLog(@"my name is = %@",student.name);
    };
}
```
>[循环引用问题集合](http://blog.csdn.net/u011146511/article/details/51273794)
#####blok实现界面反向传值如何实现？
1,定义一个block属性 2,一级界面实现block需要执行的操作 3,在需要回调的时候调用block

参考
*<http://blog.csdn.net/x32sky/article/details/73826662>

###Runtime
####1、objc在向一个对象发送消息时，发生了什么？
>objc是动态语言，每个方法在运行时会被动态转为消息发送，即：objc_msgSend(receiver, selector)。
>根据对象的isa指针找到类对象id，在查询类对象里面的methodLists方法函数列表，如果没有找到，在沿着superClass,寻找父类，再在父类methodLists方法列表里面查询，最终找到SEL,根据id和SEL确认IMP（指针函数）,在发送消息；

####2、什么时候会报unrecognized selector错误？iOS有哪些机制来避免走到这一步？

>简单来说：

>当调用该对象上某个方法,而该对象上没有实现这个方法的时候， 可以通过“消息转发”进行解决。

>简单的流程如下，在上一题中也提到过：

>objc是动态语言，每个方法在运行时会被动态转为消息发送，即：objc_msgSend(receiver, selector)。

>objc在向一个对象发送消息时，runtime库会根据对象的isa指针找到该对象实际所属的类，然后在该类中的方法列表以及其父类方法列表中寻找方法运行，如果，在最顶层的父类中依然找不到相应的方法时，程序在运行时会挂掉并抛出异常unrecognized selector sent to XXX 。但是在这之前，objc的运行时会给出三次拯救程序崩溃的机会：

#####1. Method resolution
>objc运行时会调用+resolveInstanceMethod:或者 +resolveClassMethod:，让你有机会提供一个函数实现。如果你添加了函数，那运行时系统就会重新启动一次消息发送的过程，否则 ，运行时就会移到下一步，消息转发（Message Forwarding）。

#####2. Fast forwarding
>如果目标对象实现了-forwardingTargetForSelector:，Runtime 这时就会调用这个方法，给你把这个消息转发给其他对象的机会。 只要这个方法返回的不是nil和self，整个消息发送的过程就会被重启，当然发送的对象会变成你返回的那个对象。否则，就会继续Normal Fowarding。 这里叫Fast，只是为了区别下一步的转发机制。因为这一步不会创建任何新的对象，但下一步转发会创建一个NSInvocation对象，所以相对更快点。 
#####3. Normal forwarding
>这一步是Runtime最后一次给你挽救的机会。首先它会发送-methodSignatureForSelector:消息获得函数的参数和返回值类型。如果-methodSignatureForSelector:返回nil，Runtime则会发出-doesNotRecognizeSelector:消息，程序这时也就挂掉了。如果返回了一个函数签名，Runtime就会创建一个NSInvocation对象并发送-forwardInvocation:消息给目标对象。

```

#import "XWTest.h"
#import <objc/runtime.h>

@interface XWTest2 : NSObject
- (void)unrecognized;
@end
@implementation XWTest2
- (void)unrecognized {
    NSLog(@"unrecognized");
}
@end

@implementation XWTest
void myMethod(id self, SEL _cmd) {
    NSLog(@"myMethod 被调用!");
}
/// 第一次
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@" %s",__func__);
    if ([NSStringFromSelector(sel) isEqualToString:@"unrecognized"]) {
        class_addMethod([self class], sel, (IMP)myMethod,"v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

/// 第二次
-(id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *selectorName = NSStringFromSelector(aSelector);
    if ([selectorName isEqualToString:@"unrecognized"]) {
        XWTest2 *myobject = [[XWTest2 alloc] init];
        return myobject;
    }
    return [super forwardingTargetForSelector:aSelector];
}

/// 第三次
-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        if([XWTest2 instancesRespondToSelector:aSelector])
        {
            signature = [XWTest2 instanceMethodSignatureForSelector:aSelector];
        }
    }
    return signature;
}

-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([XWTest2 instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:[[XWTest2 alloc] init]];
    }
}

@end
```
>参考:
* <https://www.jianshu.com/p/1c8f708653c0>

####3、能否向编译后得到的类中增加实例变量？能否向运行时创建的类中添加实例变量？为什么？
>不能向编译后得到的类中增加实例变量；
>能向运行时创建的类中添加实例变量；
解释下：
>因为编译后的类已经注册在 runtime 中，类结构体中的 objc_ivar_list 实例变量的链表 和 instance_size 实例变量的内存大小已经确定，同时runtime 会调用 class_setIvarLayout 或 class_setWeakIvarLayout 来处理 strong weak 引用。所以不能向存在的类中添加实例变量；
>运行时创建的类是可以添加实例变量，调用 class_addIvar 函数。但是得在调用 objc_allocateClassPair 之后，objc_registerClassPair 之前，原因同上。

####4、runtime如何实现weak变量的自动置nil？
>runtime 对注册的类， 会进行布局，对于 weak 对象会放入一个 hash 表中。 用 weak 指向的对象内存地址作为 key，当此对象的引用计数为0的时候会 dealloc， 在这个 weak 表中搜索，找到所有以a为键的 weak 对象，从而设置为 nil。
>weak 修饰的指针默认值是 nil （在Objective-C中向nil发送消息是安全的）

####5、给类添加一个属性后，在类结构体里哪些元素会发生变化？
>instance_size ：实例的内存大小
>objc_ivar_list *ivars:属性列表

###RunLoop
####1.runloop是来做什么的？runloop和线程有什么关系？主线程默认开启了runloop么？子线程呢？
>runloop:字面意思就是跑圈，其实也就是一个循环跑圈，用来处理线程里面的事件和消息。
>runloop和线程的关系：每个线程如果想继续运行，不被释放，就必须有一个runloop来不停的跑圈，以来处理线程里面的各个事件和消息。
>主线程默认是开启一个runloop。也就是这个runloop才能保证我们程序正常的运行。子线程是默认没有开始runloop的

####2.runloop的mode是用来做什么的？有几种mode？
>model:是runloop里面的模式，不同的模式下的runloop处理的事件和消息有一定的差别。
系统默认注册了5个Mode:
（1）kCFRunLoopDefaultMode: App的默认 Mode，通常主线程是在这个 Mode 下运行的。
（2）UITrackingRunLoopMode: 界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响。
（3）UIInitializationRunLoopMode: 在刚启动 App 时第进入的第一个 Mode，启动完成后就不再使用。
（4）GSEventReceiveRunLoopMode: 接受系统事件的内部 Mode，通常用不到。
（5）kCFRunLoopCommonModes: 这是一个占位的 Mode，没有实际作用。
>注意iOS 对以上5中model进行了封装
>NSDefaultRunLoopMode;
>NSRunLoopCommonModes

####3.为什么把NSTimer对象以NSDefaultRunLoopMode（kCFRunLoopDefaultMode）添加到主运行循环以后，滑动scrollview的时候NSTimer却不动了？
>nstime对象是在 NSDefaultRunLoopMode下面调用消息的，但是当我们滑动scrollview的时候，NSDefaultRunLoopMode模式就自动切换到UITrackingRunLoopMode模式下面，却不可以继续响应nstime发送的消息。所以如果想在滑动scrollview的情况下面还调用nstime的消息，我们可以把nsrunloop的模式更改为NSRunLoopCommonModes

####4.苹果是如何实现Autorelease Pool的？
>Autorelease Pool作用：缓存池，可以避免我们经常写relase的一种方式。其实就是延迟release，将创建的对象，添加到最近的autoreleasePool中，等到autoreleasePool作用域结束的时候，会将里面所有的对象的引用计数器-1.
autorelease

参考:
* <https://www.jianshu.com/p/74bb8e1f7036>

###类结构
####1、isa指针？（对象的isa，类对象的isa，元类的isa都要说）
> 对象的isa指针指向所属的类
类的isa指针指向了所属的元类
元类的isa指向了根元类，根元类指向了自己。

>![实例、类对象、元类关系](https://upload-images.jianshu.io/upload_images/1773988-f3b90f8a4d90e32b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/550)

参考:
*<http://www.zhimengzhe.com/IOSkaifa/253119.html>

####2、类方法和实例方法有什么区别？
>调用的方式不同，类方法必须使用类调用，在方法里面不能调用属性，类方法里面也必须调用类方法。存储在元类结构体里面的methodLists里面
>实例方法必须使用实例对象调用，可以在实例方法里面使用属性，实例方法也必须调用实例方法。存储在类结构体里面的methodLists里面

参考:
* <http://blog.csdn.net/youshaoduo/article/details/55253041>

####3、介绍一下分类，能用分类做什么？内部是如何实现的？它为什么会覆盖掉原来的方法？
>类别(Category)主要有3个作用：
>将类的实现分散到多个不同文件或多个不同框架中。
创建对私有方法的前向引用。
向对象添加非正式协议。
声明：@interface 类名(分类名称) @end
实现：@implementation 类名(分类名称) @end
>注意:
(1)在分类只能增加方法,不能增加成员变量，如果要增加成员变量的话该考虑用继承去实现
(2)在分类实现方法中可以访问类中的成员变量但是不能访问类中的属性@property
(3)在分类中可以重新实现原类中的方法，但会将原类中的方法覆盖而失效。
(4)如果一个类有多个分类，而且分类中有同名的方法那么最后编译的分类会将前面编译的分类覆盖而执行输出

>因为在执行对象成员方法的时候会优先去分类中查找，然后再去原类中去查找，最后去父类中去查找

```
// 另外一份解释来自《招聘一个靠谱的 iOS》—参考答案（上）---24
// 类方法：
   - 类方法是属于类对象的
   - 类方法只能通过类对象调用
   - 类方法中的self是类对象
   - 类方法可以调用其他的类方法
   - 类方法中不能访问成员变量
   - 类方法中不能直接调用对象方法

//  实例方法：
   -  实例方法是属于实例对象的
   -  实例方法只能通过实例对象调用
   -  实例方法中的self是实例对象
   -  实例方法中可以访问成员变量
   -  实例方法中直接调用实例方法
   -  实例方法中也可以调用类方法(通过类名)
```

参考:
* <https://tech.meituan.com/DiveIntoCategory.html>


####4、运行时能增加成员变量么？能增加属性么？如果能，如何增加？如果不能，为什么？
>Category中不能动态添加成员变量;
在Objective-C提供的runtime函数中，确实有一个class_addIvar()函数用于给类添加成员变量，但是阅读过苹果的官方文档的人应该会看到：
>This function may only be called after objc_allocateClassPair and before objc_registerClassPair. Adding an instance variable to an existing class is not supported.
>大概的意思说，这个函数只能在“构建一个类的过程中”调用。一旦完成类定义，就不能再添加成员变量了。经过编译的类在程序启动后就被runtime加载，没有机会调用addIvar。程序在运行时动态构建的类需要在调用objc_registerClassPair之后才可以被使用，同样没有机会再添加成员变量。
>因为方法和属性并不“属于”类实例，而成员变量“属于”类实例。我们所说的“类实例”概念，指的是一块内存区域，包含了isa指针和所有的成员变量。所以假如允许动态修改类成员变量布局，已经创建出的类实例就不符合类定义了，变成了无效对象。但方法定义是在objc_class中管理的，不管如何增删类方法，都不影响类实例的内存布局，已经创建出的类实例仍然可正常使用。
>然而如果在运行时动态生成一个类，就可以为其添加成员变量和方法, 如下图所示:
>添加的方法必须是已经实现的，所以先手写这个方法

####5、objc中向一个nil对象发送消息将会发生什么？（返回值是对象，是标量，结构体）
>[objc中向一个nil对象发送消息将会发生什么？](https://github.com/ChenYilong/iOSInterviewQuestions/blob/master/01%E3%80%8A%E6%8B%9B%E8%81%98%E4%B8%80%E4%B8%AA%E9%9D%A0%E8%B0%B1%E7%9A%84iOS%E3%80%8B%E9%9D%A2%E8%AF%95%E9%A2%98%E5%8F%82%E8%80%83%E7%AD%94%E6%A1%88/%E3%80%8A%E6%8B%9B%E8%81%98%E4%B8%80%E4%B8%AA%E9%9D%A0%E8%B0%B1%E7%9A%84iOS%E3%80%8B%E9%9D%A2%E8%AF%95%E9%A2%98%E5%8F%82%E8%80%83%E7%AD%94%E6%A1%88%EF%BC%88%E4%B8%8A%EF%BC%89.md#16-objc%E4%B8%AD%E5%90%91%E4%B8%80%E4%B8%AAnil%E5%AF%B9%E8%B1%A1%E5%8F%91%E9%80%81%E6%B6%88%E6%81%AF%E5%B0%86%E4%BC%9A%E5%8F%91%E7%94%9F%E4%BB%80%E4%B9%88)

参考:
* <http://blog.csdn.net/x32sky/article/details/73826662>
* <https://www.jianshu.com/p/19f280afcb24>
###高级
####1、UITableview的优化方法（缓存高度，异步绘制，减少层级，hide，避免离屏渲染）
>缓存高度：当我们创建frame模型的时候，计算出来cell的高度的时候，我们可以将cell的高度缓存到字典里面，以cell的indexpath和Identifier作为为key。

```
NSString *key = [[HeightCache shareHeightCache] makeKeyWithIdentifier:@"YwywProductGradeCell" indexPath:indexPath];
if ([[HeightCache shareHeightCache] existInCacheByKey:key]) {
    return [[HeightCache shareHeightCache] heightFromCacheWithKey:key];
}else{
    YwywProductGradeModelFrame *modelFrame = self.gradeArray[indexPath.row];
    [[HeightCache shareHeightCache] cacheHieght:modelFrame.cellHight key:key];
    return modelFrame.cellHight;
}
```
参考:
* <https://www.jianshu.com/p/93085c0de4c9>

####2、有没有用过运行时，用它都能做什么？（交换方法，创建类，给新创建的类增加方法，改变isa指针）
>
#####交换方式：一般写在类的+(void)load方法里面

```
    Method originalM = class_getInstanceMethod([self class], @selector(originMethod));
    Method exchangeM = class_getInstanceMethod([self class], @selector(exChangeMethod));
    method_exchangeImplementations(originalM, exchangeM); 
```
>
#####创建类：

```
/// 创建类
- (void)creatClassMethod {

    Class Person = objc_allocateClassPair([NSObject class], "Person", 0);
    //添加属性
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "C", "" }; // C = copy
    objc_property_attribute_t backingivar  = { "V", "_privateName" };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    class_addProperty(Person, "name", attrs, 3);
    //添加方法
    class_addMethod(Person, @selector(name), (IMP)nameGetter, "@@:");
    class_addMethod(Person, @selector(setName:), (IMP)nameSetter, "v@:@");
    //注册该类
    objc_registerClassPair(Person);
    
    //获取实例
    id instance = [[Person alloc] init];
    NSLog(@"%@", instance);
    [instance setName:@"hxn"];
    NSLog(@"%@", [instance name]);
}
//get方法
NSString *nameGetter(id self, SEL _cmd) {
    Ivar ivar = class_getInstanceVariable([self class], "_privateName");
    return object_getIvar(self, ivar);
}
//set方法
void nameSetter(id self, SEL _cmd, NSString *newName) {
    Ivar ivar = class_getInstanceVariable([self class], "_privateName");
    id oldName = object_getIvar(self, ivar);
    if (oldName != newName) object_setIvar(self, ivar, [newName copy]);
}
```
>
#####添加方法

```
/**参数一、类名参数
   二、SEL 添加的方法名字参数
    三、IMP指针 (IMP就是Implementation的缩写，它是指向一个方法实现的指针，每一个方法都有一个对应的IMP)
  参数四、其中types参数为"i@:@“，按顺序分别表示：具体类型可参照[官方文档](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html)i 返回值类型int，若是v则表示void@ 参数id(self): SEL(_cmd)@ id(str)
  V@:表示返回值是void 带有SEL参数 （An object (whether statically typed or typed id)）
  */
class_addMethod(Person, @selector(addMethodForMyClass:), (IMP)addMethodForMyClass, "V@:");

```
>
#####添加实例变量

```
/**参数一、类名参数
  二、属性名称参数
  三、开辟字节长度参数
  四、对其方式参数
  五、参数类型 “@” 官方解释 An object (whether statically typed or typed id) （对象 静态类型或者id类型） 具体类型可参照[官方文档](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html)return: BOOL 是否添加成功
  */
BOOL isSuccess = class_addIvar(Person, "name", sizeof(NSString *), 0, "@");
isSuccess?NSLog(@"添加变量成功"):NSLog(@"添加变量失败");
```

####3、看过哪些第三方框架的源码？都是如何实现的？（如果没有，问一下多图下载的设计）
 > [iOS常用开源框架、技术博客、软件、插件等](https://www.jianshu.com/p/812d868ea821)
 >***
##### ** SDWebImage **
> [iOS之SDWebImage的实现原理](https://www.jianshu.com/p/733954fce261)
##### ** AFNetworking**
> [AFNetworking到底做了什么？](http://www.cocoachina.com/ios/20161209/18277.html)
##### ** MBProcessHUD**
> [MBProcessHUD-分析、模仿与学习](https://www.jianshu.com/p/e3643348fd0c)
##### ** Masonry **
> [iOS自动布局框架-Masonry详解](https://www.jianshu.com/p/ea74b230c70d)
##### ** MJRefresh**
> [iOS 李明杰 MJRefresh源码解析](https://www.jianshu.com/p/25d859c4897e)
##### ** YYKit **
> [第三方框架学习—YYKit](https://www.jianshu.com/p/514ffb83868d)
##### ** FMDB**
> [iOS数据库第三方框架FMDB详细讲解](https://www.jianshu.com/p/e2dbd69b6db2)
 
 >[详解 iOS 多图下载的缓存机制](https://www.jianshu.com/p/bf5c0e462119)
 
 
####4、SDWebImage的缓存策略？
> sd加载一张图片的时候，会先在内存里面查找是否有这张图片，如果没有会根据图片的md5(url)后的名称去沙盒里面去寻找，是否有这张图片，如果没有会开辟线程去下载，下载完毕后加载到imageview上面，并md(url)为名称缓存到沙盒里面。
附:(代码解读)
> [SDWebImage缓存机制](http://www.cnblogs.com/sunyanyan/p/5417706.html)

####5、AFN为什么添加一条常驻线程？
>如果没有常住线程的话，就会每次请求网络就去开辟线程，完成之后销毁开辟线程，这样就造成资源的浪费，而开辟一条常驻线程，就可以避免这种浪费，我们可以在每次的网络请求都添加到这条线程。

####6、KVO的使用？实现原理？（为什么要创建子类来实现）
> [iOS开发 -- KVO的实现原理与具体应用](https://www.jianshu.com/p/e59bb8f59302)
>创建子类
每个对象都有isa 指针，指向该对象的类，它告诉 Runtime 系统这个对象的类是什么。所以对象注册为观察者时，isa指针指向新子类，那么这个被观察的对象就神奇地变成新子类的对象（或实例）了。

####7、KVC的使用？实现原理？（KVC拿到key以后，是如何赋值的？知不知道集合操作符，能不能访问私有属性，能不能直接访问_ivar）
>[iOS开发技巧系列---详解KVC(我告诉你KVC的一切)](https://www.jianshu.com/p/45cbd324ea65)

###项目
####1、有已经上线的项目么？
####2、项目里哪个部分是你完成的？（找一个亮点问一下如何实现的）
####3、开发过程中遇到过什么困难，是如何解决的？
###学习
####1、遇到一个问题完全不能理解的时候，是如何帮助自己理解的？举个例子？
####2、有看书的习惯么？最近看的一本是什么书？有什么心得？
####3、有没有使用一些笔记软件？会在多平台同步以及多渠道采集么？（如果没有，问一下是如何复习知识的）
####4、有没有使用清单类，日历类的软件？（如果没有，问一下是如何安排，计划任务的）
####5、平常看博客么？有没有自己写过？（如果写，有哪些收获？如果没有写，问一下不写的原因）
####6、有关技术类的问题可以在评论区留言，我重点说一下这轮面试的心得和体会。



