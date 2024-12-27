import {goodsData} from '../type/type'
import router from '@ohos.router';
import myStore from '../store/mystore'

import settlementItem from '../components/settlementItem'

@CustomDialog
struct CustomDialogExample {
  controller: CustomDialogController
  videoController: VideoController

  build() {
    Column() {
      Text('选择支付方式').fontSize(20).margin({ top: 30, bottom: 30 })

      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        Column({ space: 10 }) {
          Image('/image/wechat1.png').width(50).height(50)
          Text('微信')
          Radio({ value: 'Radio1', group: 'radioGroup' })
        }.width("50%")

        Column({ space: 10 }) {
          Image('/image/Alipay1.png').width(50).height(50)
          Text('支付宝')
          Radio({ value: 'Radio1', group: 'radioGroup' })
        }.width("50%")
      }.margin({ bottom: 10 })

      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('返回')
          .onClick(() => {
            this.controller.close()
          }).fontColor(Color.White).width("40%").margin({left:"5%",right:"5%"})
        Button('选择支付')
          .onClick(() => {
            this.controller.close()
            const res = myStore.deleteCartItem()
            if(res) this.videoController.start()
            router.back();
          }).fontColor(Color.White).width("40%").margin({left:"5%",right:"5%"})
      }.margin({ bottom: 10 })
    }
  }
}

@Entry
@Component
struct settlement {
  @State myShoppingCart:goodsData[] = []
  @State sumPrice:number = 0
  private videoController: VideoController = new VideoController()

  getDependency(myThis:settlement,shoppingCart:goodsData[]){
    myThis.myShoppingCart = []
    myThis.sumPrice = 0
    for (const element of shoppingCart) {
      if(element.isTrue){
        myThis.myShoppingCart.push(element)
        myThis.sumPrice += element.price * element.sum
      }
    }
  }

  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      videoController:this.videoController
    }),
    alignment: DialogAlignment.Bottom,
  })
  onCancel() {
    console.info('Callback when the first button is clicked')
  }
  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  aboutToAppear(){
    myStore.getShoppingCart(this,this.getDependency)
  }

  build() {
    Column() {
      Video({
        src: $rawfile("audio.mp3"),
        previewUri: "https://www.arkui.club/img/test.png",
        controller: this.videoController
      }).height(0)


      Row(){
        Column(){
          Button("<").onClick((event: ClickEvent) => {
            router.back()
          }).backgroundColor(Color.White).fontColor(Color.Black)
        }
        Column(){
          Text("结算")
        }
      }.padding(10).width("100%")
      Divider()

      Row(){
        Column(){
          Row(){
            Text("需要支付:")
          }.width("100%")
          Row(){
            Text(`${this.sumPrice}￥`).fontSize(50).fontColor(Color.Red)
          }.width("100%")
          Row(){
            Text("配送地址：广东省东莞市广东科技学院松山湖校区西门").fontColor(Color.Gray)
          }.margin({top:10})
        }
      }.width("100%").height(180).backgroundColor(Color.Orange).padding(30)

      //红蓝条
      Row() {
        Divider().strokeWidth(3).color(Color.Red).width("5%")
        Divider().strokeWidth(3).color(Color.Blue).width("5%")
        Divider().strokeWidth(3).color(Color.Red).width("5%")
        Divider().strokeWidth(3).color(Color.Blue).width("5%")
        Divider().strokeWidth(3).color(Color.Red).width("5%")
        Divider().strokeWidth(3).color(Color.Blue).width("5%")
        Divider().strokeWidth(3).color(Color.Red).width("5%")
        Divider().strokeWidth(3).color(Color.Blue).width("5%")
        Divider().strokeWidth(3).color(Color.Red).width("5%")
        Divider().strokeWidth(3).color(Color.Blue).width("5%")
        Divider().strokeWidth(3).color(Color.Red).width("5%")
        Divider().strokeWidth(3).color(Color.Blue).width("5%")
        Divider().strokeWidth(3).color(Color.Red).width("5%")
        Divider().strokeWidth(3).color(Color.Blue).width("5%")
        Divider().strokeWidth(3).color(Color.Red).width("5%")
        Divider().strokeWidth(3).color(Color.Blue).width("5%")
        Divider().strokeWidth(3).color(Color.Red).width("5%")
        Divider().strokeWidth(3).color(Color.Blue).width("5%")
        Divider().strokeWidth(3).color(Color.Red).width("5%")
        Divider().strokeWidth(3).color(Color.Blue).width("5%")
      }.width("100%")

      Row(){
        Text("商品")
      }.width("100%").padding(30)

      List(){
        ForEach(this.myShoppingCart,$=>{
          ListItem(){
            Row(){
              settlementItem({ids:$.ids,name:$.name,price:$.price,url:$.url,isTrue:$.isTrue,sum:$.sum})
              // Text(`${$.name}`)
            }.width("100%")
          }
        })
      }

      Row(){
        Button("提交订单").onClick((event: ClickEvent) => {
          this.dialogController.open()
          // const res = myStore.deleteCartItem()
          // if(res) this.videoController.start()
          // router.back();
        }).width("100%")
      }.width('100%').height(50).position({y:'93%'}).padding({left:30,right:30})
    }
  }
}