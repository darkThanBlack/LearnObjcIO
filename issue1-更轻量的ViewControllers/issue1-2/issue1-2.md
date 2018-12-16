# Learn:整洁的TableView代码



>原文链接：[整洁的TableView代码](https://objccn.io/issue-1-2/)
>
>本文是对ObjC期刊一系列高质量博文所作的个人学习笔记。
>
>本文约1,800词，可能需要13分钟阅读。



###UITableViewController VS. UIViewController

这里原作者还是耐心地介绍了如`UIRefreshControl`等一些`UITableViewController`的特性，并引申出可以使用`ChildViewController`来控制`UITableViewController`，但我认为在实际项目中基本可以宣告`UITableViewController`的死刑：我不觉得使用类似`[self.view addSubView:self.tableView]`的方式自行实现一些小功能会额外多出多大的开销，下拉刷新也有非常成熟的[MJRefresh](https://github.com/CoderMJLee/MJRefresh)，如果这个特性本身并没有太大的优势同时又会带来诸多限制，那么选型时不被采用也是理所当然。

对于我来说更有意思的是`ChildViewContoller`：平心而论这一系列的容器API应该是比较基本的内容，但我平时项目确实极少用到`addChildViewController:`方法，绝大多数都是Tabbar和Navgation的组合，通过pop，push或是present在各个页面之间跳转。我认为万事皆有因果，而新技术的出现必然有其对应的需求场景，无论最后结果如何，花费时间精力去写新玩意的人一开始的动机肯定是为了解决某个他所遇到的实际问题。对于后来者而言，如果有条件能置身于类似的需求场景中，不失为学习的一种好方式。有一个可能的场景，就是类似今日头条首页的头部菜单：（如图）

![issue1-2-image1](/Users/moonshadow/Documents/LearnObjcIO/issue1-更轻量的ViewControllers/issue1-2/issue1-2-image1.png)

我个人觉得这个横向滑动的菜单粗看比较常见，UI实现也没什么难度，开源框架应该也不少，但如果业务需求庞大的情况下，问题恐怕不是那么好解决，常见的实现思路，也是自行实现很容易采用的方案，就是把整个菜单封装成一个View，通过回调来触发各种事件，由HomeViewController来统一管理。在这种思路下：

* 性能问题，首页做的事情太多必然拖慢启动速度，驻留在内存里的实例太大也会影响应用流畅性
* 如果菜单数量比较多，布局又各有千秋，很难让这些View全部都由一个HomeViewController来管理，不仅破坏了MVC的设计原则，也无法清楚地管理subView的生命周期事件，诸如`ViewWillAppear:`等方法都享受不到
* subView还有各种各样的用户事件，作为View应该向上递交给ViewController来处理，这时如果只有一个HomeViewController来管理势必过于臃肿
* 结合网络请求的情况，诸如上拉下拉的时机都要小心控制，防止出现下拉距离过长等BUG，拿到数据后恐怕还要由HomeViewController来区别分发
* 如果左右滑动有动效，那前后一页应该是要做预加载的，这部分逻辑代码不会太少，不能全由HomeViewController来实现

所以虽然`ChildViewController`由于在通信上和其他问题可能会使得你的工程变得更加复杂，但或许会是在这个场景下比较不错的解决方案之一，起码可以实现View和Controller的对应，保护MVC的设计原则。关于`ChildViewController`网上的资料似乎并不太多，我暂时也没看到有比较好的项目源码实践，我觉得我应该在随后的文章（如[issue1-4]()）里更详细地讨论这个问题。



###分离关注点

这一段总的来说，作者介绍了一些非常实用的将cell彻底作为V层独立出来的思路和技巧，珠玉在前，我只是尽量补充一些例子，有一个比较简便的判断方法：看`delegate`或`datasource`实现方法里面有没有直接操作实例的属性，例如

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LOStyle_2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOStyle_2_Cell"];
	cell.detailLabel.text = @"test detail...";
	return cell;
}
```

很明显对`tableView:cellForRowAtIndexPath:`方法来说，它不应该关注`LOStyle_2_Cell`内部具体的cell，改进一些的方法会使用Model，类似于我在[issue1-1]()中的写法：

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LOStyle_2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOStyle_2_Cell"];
	LOIBaseCellModel *cellInfo = self.cellDataArray[indexPath.row];
	cell.cellInfo = cellInfo;
	return cell;
}
```

这样的写法是我的习惯，它会把赋值代码放到`cell.cellInfo`的`Setter`方法里去，但是这样只是单纯把细节放到了cell内部，cell依然必须`import `相应的view model并持有`cellInfo`实例，还没有做到Model和cell的完全分离：

```objective-c
#import "LOIBaseCellModel.h"
@implementation LOStyle_2_Cell
- (void)setCellInfo:(LOIBaseCellModel *)cellInfo
{
    if (![_cellInfo isEqual:cellInfo]) {
        _cellInfo = cellInfo;
    }
    self.detailLabel.text = _cellInfo.detail;
}
@end
```

原作者通过给cell增加category来解决，这样cell跟具体的Model就真的毫无关系了，还能减少引用：

```objective-c
#import "LOIBaseCellModel.h"
@implementation LOStyle_2_Cell (ConfigHelper)
- (void)configCellInfo:(LOIBaseCellModel *)cellInfo
{
    self.detailLabel.text = cellInfo.detail;
}
@end
```

调用的时候变成：

```objective-c
#import "LOStyle_2_Cell+ConfigHelper.h"
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LOStyle_2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOStyle_2_Cell"];
	LOIBaseCellModel *cellInfo = self.cellDataArray[indexPath.row];
	[cell configCellInfo:cellInfo];
    return cell;
}
```

当然，我觉得对于非常普通的cell来说不必写得如此明确，所以重点是接下来的复用，当这个cell可能也需要被其他tableView使用的时候，由于已经利用category完成了M和V的彻底分离，就可以利用`protocol`来给Model规定具体的格式以便复用。原作者这里没写示例，我再加一点代码方便理解：

```objective-c
@protocol LOIBaseCellModelProtocol <NSObject>
- (NSString *)getDetail;
@end
@interface LOIBaseCellModel : NSObject <LOIBaseCellModelProtocol>
//do sth...
@end
    
@interface LOStyle_2_Cell : UITableViewCell
- (void)configCellInfo:(id<LOIBaseCellModelProtocol>)cellInfo;
@end
```

像这样，数据源只要实现了`LOIBaseCellModelProtocol`协议，`configCellInfo:`就能传不同的Model：

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<LOIBaseCellModelProtocol> cellInfo = self.cellDataArray[indexPath.row];
    LOStyle_2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOStyle_2_Cell"];
	[cell configCellInfo:cellInfo];
    return cell;
}
```

如果`datasource`里有多种类型的cell呢？一般简单地使用`if `来判断，但如果这几种cell样式相似，那么可以考虑用继承来做，基类是`LOStyle_2_Cell`，子类内部对`configCellInfo`方法进行实现，这样`datasource`只需要直接传值：

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<LOIBaseCellModelProtocol> cellInfo = self.cellDataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInfo.cellName];
    [(LOStyle_2_Cell *)cell configCellInfo:cellInfo];
    return cell;
}
```

有没有具体的应用场景？有的，IM项目的聊天页面就是很好的例子，聊天气泡cell功能相似，展示不同，数量众多，这里还是推荐可以看一下美洽客服（真不是广告！）的源码实现，思路非常的类似，他们在Model和Cell的基类中有额外做不少东西，然后把cell的方法也做成了协议，这样无论开发者要自定义cell还是Model都可以满足。

