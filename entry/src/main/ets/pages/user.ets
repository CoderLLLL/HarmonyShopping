import router from '@ohos.router'
import promptAction from '@ohos.promptAction';
import NotificationManager from '@ohos.notificationManager';

let notificationRequest = {
  id: 1,
  content: {
    contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
    normal: {
      title: "通知",
      text: '新产品奶茶',
      additionalText: '购物车等你加入',
    }
  }
}

@Entry
@Component
export default struct user{

  build(){
    Column(){
      Row(){
        Text("我的").margin({left:10}).fontSize(20)
      }
      .width("100%")
      .height(50)
      Divider()
      Row(){
        Image("image/catSmall.jpg").width(100).height(100).margin({top:10,right:30}).borderRadius(10)
        Text(router.getParams()['username'] ?? "CoderLLL").fontSize(30)
      }.width("90%")
      .height(150)
      .margin({top:"5%"})
      .padding({left:30})
      .borderRadius(20)
      .shadow({ radius: 10, color: Color.Gray })

      Row(){
        Grid(){
          GridItem(){Text("通知").fontColor(Color.Gray)}
          GridItem(){Text("请选择是否常驻通知").width("100%").textAlign(TextAlign.Start)}
          GridItem(){

            Toggle({ type: ToggleType.Switch, isOn: false }).onChange((isChange: boolean) => {
              let tip: string = isChange ? "系统选项打开" : "系统选项关闭"
              promptAction.showToast({
                message: tip,
                duration: 3000
              })
              if (isChange) {
                NotificationManager.publish(notificationRequest, (err) => {
                  if (err) {
                    console.error(`[ANS] failed to publish, error[${err}]`);
                    return;
                  }
                  console.info(`[ANS] publish success`);
                });
              }
            })
          }
          // GridItem(){Text(">")}
        }.columnsTemplate("1fr 3fr 1fr").padding({top:20}).height(80).margin({top:30})
      }
      Divider()
      Row(){
        Grid(){
          GridItem(){Text("订单").fontColor(Color.Gray)}
          GridItem(){Text("查看所有购物记录").width("100%").textAlign(TextAlign.Start)}
          GridItem(){Text(">")}
        }.columnsTemplate("1fr 3fr 1fr").padding({top:20}).height(50)
      }
      Divider()
      Row(){
        Grid(){
          GridItem(){Text("信息").fontColor(Color.Gray)}
          GridItem(){Text("查看个人信息").width("100%").textAlign(TextAlign.Start)}
          GridItem(){Text(">")}
        }.columnsTemplate("1fr 3fr 1fr").padding({top:20}).height(50)
      }
      Divider()
      Row(){
        Grid(){
          GridItem(){Text("游戏").fontColor(Color.Gray)}
          GridItem(){Text("小游戏淘金币").width("100%").textAlign(TextAlign.Start)}
          GridItem(){Text(">")}
        }.columnsTemplate("1fr 3fr 1fr").padding({top:20}).height(50)
      }
      Divider()
      Row(){
        Grid(){
          GridItem(){Text("钱包").fontColor(Color.Gray)}
          GridItem(){Text("进入我的钱包").width("100%").textAlign(TextAlign.Start)}
          GridItem(){Text(">")}
        }.columnsTemplate("1fr 3fr 1fr").padding({top:20}).height(50)
      }
      Divider()
      Row(){
        Grid(){
          GridItem(){Text("领卷").fontColor(Color.Gray)}
          GridItem(){Text("进入领卷中心").width("100%").textAlign(TextAlign.Start)}
          GridItem(){Text(">")}
        }.columnsTemplate("1fr 3fr 1fr").padding({top:20}).height(50)
      }
      Divider()
      Row(){
        Grid(){
          GridItem(){Text("好友").fontColor(Color.Gray)}
          GridItem(){Text("进入你的朋友圈").width("100%").textAlign(TextAlign.Start)}
          GridItem(){Text(">")}
        }.columnsTemplate("1fr 3fr 1fr").padding({top:20}).height(50)
      }
      Divider()
      Row(){
        Grid(){
          GridItem(){Text("广场").fontColor(Color.Gray)}
          GridItem(){Text("进入TA人的圈子").width("100%").textAlign(TextAlign.Start)}
          GridItem(){Text(">")}
        }.columnsTemplate("1fr 3fr 1fr").padding({top:20}).height(50)
      }
      Divider()

      Button("退出账号").onClick((event: ClickEvent) => {
        router.replaceUrl({
          url:'pages/Login'
        })
      }).width("90%")
        .height(40).margin({top:15}).backgroundColor(Color.Red)
    }
  }
}