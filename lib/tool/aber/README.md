## Features

Aber 是 Flutter 中的一个代码非常简洁、性能非常高效的状态管理包。

- 代码简洁：
    - 使用易上手、只需非常简单及少量的代码即可管理状态。
    - 源码只有不到 200 行，非常便于深入理解源码。
    - 没有依赖任何其他包。
- 性能高效：
    - 采用了一种特殊绑定方式，只有改变了状态的widget才会被重建，并且是自动重建所有改变了状态的 widget。
    - 没有使用任何 ChangeNotifier、StreamSubscription，大大提高了性能。

借鉴了 [Get](https://pub.flutter-io.cn/packages/get) 包的思想：

- 利用 dart 的扩展函数特性。

- 借鉴了其 put/find/GetBuilder 等的想法。

- 和 Get 类似，Aber 不是其他状态管理器的敌人，它的状态管理功能既可以单独使用，也可以与其他状态管理器结合使用。

## Getting started

1. 创建一个 controller:
    ```
   import 'package:aaa/test/Aber.dart';
   class Controller extends AbController {}
   ```
2. 只需对想要实现的属性后加上 `.ab`:
   ```
   final count = 0.ab;
   ```
3. 构建一个 `AbWidget`:
    ```
    import 'package:aaa/test/Aber.dart';
    class A extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: AbWidget(
            ...
          ),
        );
      }
    }
    ```
4. 使用 `AbWidget` 包裹:
    ```
    AbWidget(
        controller: Controller(),
        builder: (TestNbController controller, Abw<TestNbController> abw) {
          return Text(controller.count.ab(abw).toString());
        },
    )
    ```
   没错，就是这么简单，使用变量时，只需在变量后面添加 `.ab(abw)`。
5. 在任意地方都可以修改变量：
   ```
   Get.find<Controller>().count.updateTo((oldValue) => oldValue+1);
   ```
   没了，对，就是这么简单，只需这一行，便可把所有引用该`count`变量的`AbWidget`进行重建！

总结：与使用 [Get](https://pub.flutter-io.cn/packages/get) 的 `.obs` 区别并不大，只是在使用变量时需要加上 `.ab`。
