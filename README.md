# Sheeter
A DropDownSheet view &amp; ActionSheet view with Swift.

### 要求
- Xcode 8.3+
- Swift 3.2+
- iOS 9.0+

### 介绍
##### SheeterDropDown
- 这个控件有点类似于UIKit里的UIPopoverController(已被废弃)，它可以实现基于一个sourceView的任意位置的显示，是基于UIViewController的。
- `SheeterDropDown`采用了类似的设计方式，但实现和使用比较简单。
- 用法：
> 1. 默认的列表样式

![DropDown Default](https://upload-images.jianshu.io/upload_images/1334681-f17fc4447ed9c0ab.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

```
Sheeter.dropDown(from: sender, items: [
	"Drop Down Item1",
	"Drop Down Item2",
	"Drop Down Item3"
]) 
// 这里是点击回调
{ (selected) in
	print(selected)
}
```
> 2. 自定义view（viewController）样式

![DropDown Custom](https://upload-images.jianshu.io/upload_images/1334681-4d834419ae68bd08.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

```
Sheeter.dropDown(from: sender, customView: xxx)
```

##### SheeterActionSheet
- 显而易见的，这个控件和UIKit里的UIAlertController设置style为.actionSheet后是一模一样的。
> 1. 默认的列表样式

![ActionSheet Default](https://upload-images.jianshu.io/upload_images/1334681-494ecc6c794c5156.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

```
Sheeter.actionSheet(items: [
	"Action Sheet Item1",
	"Action Sheet Item2"
])
// 回调
{ (selected) in
	print(selected)
}
```
> 2. 自定义view（viewController）样式

![ActionSheet Custom](https://upload-images.jianshu.io/upload_images/1334681-da7468ebbf564a61.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

```
// 使用
Sheeter.dropDown(from: sender, customView: actionCollectionVC.view)

// 自定义view的controller
fileprivate var actionCollectionVC: ActionCollectionVC{
	let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActionCollectionVC") as! ActionCollectionVC
	vc.view.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 100))
	vc.collectionView?.delegate = self
	return vc
}

// 代理方法
extension ViewController: UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("You clicked Action Item \(indexPath.item)")
	}
}
```

### Carthage
- 目前该控件库已上传到github上，支持Carthage编译
- 用法
>1.在你的Cartfile中加入
`github "BackWorld/Sheeter" "master"`

>2.在终端执行`carthage update`

> 3.将`Carthage/Build/iOS`目录下的`Sheeter.framework`拖到你的项目中

> 4.在使用的swift文件中`import Sheeter`即可

### 简书
https://www.jianshu.com/p/5e47cefb01f3

### iPhoneX
![iPhoneX适配](https://upload-images.jianshu.io/upload_images/1334681-6668947b1b7c8cad.gif?imageMogr2/auto-orient/strip)

> 如果对你有帮助，别忘了点个赞和关注~
