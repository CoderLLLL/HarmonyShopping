import {goodsObj} from '../type/type'
import biggoods  from './biggoods'
import myStore from '../store/mystore'

@Component

export default struct classification{
  @Link goods:goodsObj[]

  @State myShoppingCart:goodsObj[] = []

  getDependency(myThis:classification,shoppingCart:goodsObj[]){
    myThis.myShoppingCart = shoppingCart
  }

  aboutToAppear(){
    console.log("生命周期初始化")
    myStore.getShoppingCart(this,this.getDependency)
  }

  build(){
    Column(){
      Row(){
        Swiper() {
          Image("/image/1.png").width("100%").height("100%")
          Image("/image/2.png").width("100%").height("100%")
        }
        .loop(true)
        .height(200)
        .width('100%')
        .autoPlay(true)
      }

      Row(){
        Tabs({barPosition:BarPosition.Start}) {
          TabContent() {
            List({ space: 10 }){
              ForEach(this.goods,item=>{
                ListItem(){
                  biggoods({ids:item.ids,name:item.name,price:item.price,url:item.url})
                }.height(100)
              })
            }.divider({
              strokeWidth: 1,
              startMargin: 60,
              endMargin: 10,
              color: '#ffe9f0f0'
            })
          }
          .tabBar('披萨')

          TabContent() {
            List({ space: 10 }){
              ForEach(this.goods,item=>{
                ListItem(){
                  biggoods({ids:item.ids,name:item.name,price:item.price,url:item.url})
                }.height(100)
              })
            }.divider({
              strokeWidth: 1,
              startMargin: 60,
              endMargin: 10,
              color: '#ffe9f0f0'
            })
          }
          .tabBar('日用品')

          TabContent() {
            List({ space: 10 }){
              ForEach(this.goods,item=>{
                ListItem(){
                  biggoods({ids:item.ids,name:item.name,price:item.price,url:item.url})
                }.height(100)
              })
            }.divider({
              strokeWidth: 1,
              startMargin: 60,
              endMargin: 10,
              color: '#ffe9f0f0'
            })
          }
          .tabBar('饮料')

          TabContent() {
            List({ space: 10 }){
              ForEach(this.goods,item=>{
                ListItem(){
                  biggoods({ids:item.ids,name:item.name,price:item.price,url:item.url})
                }.height(100)
              })
            }.divider({
              strokeWidth: 1,
              startMargin: 60,
              endMargin: 10,
              color: '#ffe9f0f0'
            })
          }
          .tabBar("咖啡")
        }.vertical(true)
        .barWidth(100)
        .barHeight(200)
      }
    }

  }
}