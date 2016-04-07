一、为什么要自定义UITabBarController
1.想把UITabBarController内部的子控制器细节屏蔽起来，不让外界了解
2.另外一个目的：每一段代码都应该放在最合适的地方

二、重复代码的抽取
1.相同的代码放到一个方法中
2.不同的东西变成参数
3.在需要用到这段代码的地方传递参数、调用方法

三、统一所有控制器导航栏左上角和右上角的内容
1.让所有push进来的控制器，它导航栏左上角和右上角的内容都一样
2."拦截"所有push进来的控制器
3.方案：自定义导航控制器，重写push方法，就可以得到传进来的控制器参数
// 90%的"拦截"都是通过自定义类，重写自带的方法实现的

四、"duplicate symbol _OBJC_METACLASS_$_类名 in:"错误
1.90%都是因为#import了.m文件
2.其他可能是因为项目中存在了2个一样的.m文件

五、创建UIBarButtonItem的代码为什么放在UIBarButtonItem分类中最合适？
/*
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    btn.size = btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}*/
1.项目中有多处地方用到这段代码
2.每一段代码都应该放在最合适的地方：这段代码明显在创建一个UIBarButtonItem，所以跟UIBarButtonItem相关
3.从命名习惯和规范的角度看：[UIBarButtonItem itemWith....]这种形式创建item比较规范

