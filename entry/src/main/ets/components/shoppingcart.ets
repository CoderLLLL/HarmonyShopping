import {goodsData} from '../type/type'
import myStore from '../store/mystore'
import shoppingitem from '../components/shoppingitem'
import promptAction from '@ohos.promptAction'

import router from '@ohos.router'

@Component

export default struct shoppingcart{

  @State myShoppingCart:goodsData[] = []
  @State sumPrice:number = 0
  @State sumIsTrue:boolean = true

  private videoController: VideoController = new VideoController()

  getDependency(myThis:shoppingcart,shoppingCart:goodsData[]){
    myThis.myShoppingCart = shoppingCart
    myThis.sumPrice = 0
    let flag = true
    for(const item of myThis.myShoppingCart){
      myThis.sumPrice = item.isTrue ? myThis.sumPrice + item.price * item.sum : myThis.sumPrice
      if(item.isTrue == false){
        flag = false
      }
    }
    myThis.sumIsTrue = flag
    console.log(`总价格为:${myThis.sumIsTrue}`)
  }

  aboutToAppear(){
    myStore.getShoppingCart(this,this.getDependency)
  }

  build(){
    Column(){
      Video({
        src: $rawfile("audio.mp3"),
        previewUri: "https://www.arkui.club/img/test.png",
        controller: this.videoController
      }).height(0)
      Row(){
        Text(`购物车(${this.myShoppingCart.length})`)
          .align(Alignment.Center)
          .width("100%")
          .height(50)
      }
      .height(50)
      .padding({left:20})
      Divider()

      List(){
        if (this.myShoppingCart.length > 0){
          ForEach(this.myShoppingCart,$=>{
            ListItem(){
              shoppingitem({ids:$.ids,name:$.name,price:$.price,url:$.url,isTrue:$.isTrue,sum:$.sum})
            }
          })
        } else{
          ListItem(){
            Column(){
              Row(){
                Image("/image/null.jpg")
              }
              Row(){
                Text("购物车为空")
              }
            }.alignItems(HorizontalAlign.Center);
          }
        }
      }

      Row(){
        Grid(){
          GridItem(){
            Toggle({ type: ToggleType.Checkbox, isOn: this.sumIsTrue })
              .margin({top:10})
              .onClick(e=>{
                this.sumIsTrue = !this.sumIsTrue
                myStore.changeIsTrue(this.sumIsTrue)
              })
          }
          GridItem(){
            Text(`总价格为${this.sumPrice}`)
          }.margin({top:10})
          
          GridItem(){
            Button("结算").onClick((event: ClickEvent) => {
              if(this.sumPrice > 0){
                router.pushUrl({
                  url:'pages/settlement'
                })
              } else{
                promptAction.showToast({
                  message: '购物车为空',
                })
              }
            }).width('100%').margin({top:5})
          }
        }.columnsTemplate('1fr 2fr 2fr')
      }.width('100%').height(50).position({y:'93%'}).backgroundColor(Color.Gray)
    }
  }
}