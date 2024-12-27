import goods from './goods'
import {goodsObj} from '../type/type'

import router from '@ohos.router'
@Component

export default struct main{
  @Link goods:goodsObj[]
  @State shoppingCart:goodsObj[] = [];

  build(){
    List(){
      ListItem(){
        Column(){
          Row(){
            Swiper() {
              Image("/image/l1 (1).jpg").width("100%").height("100%")
              Image("/image/l1 (2).jpg").width("100%").height("100%")
              Image("/image/l1 (3).jpg").width("100%").height("100%")
            }
            .loop(true)
            .height(200)
            .width('100%')
            .autoPlay(true)
          }
        }
      }

      ListItem(){
        Text("推荐").fontSize(30).margin(10).width('100%').textAlign(TextAlign.Center)
      }

      ForEach(this.goods,(item,index)=>{
        ListItem(){
          Row({space:10}){
            Column(){
              goods({
                name:this.goods[index].name as string,
                price:this.goods[index].price as number,
                url:this.goods[index].url as string,
                ids:this.goods[index].ids as number
              }).onClick(e=>{
                router.pushUrl({
                  url:'pages/detail',
                  params:{
                    ids:this.goods[index].ids as number,
                    name:this.goods[index].name as string,
                    price:this.goods[index].price as number,
                    url:this.goods[index].url as string,
                  }
                })
              })
            }.width("50%")
            Column(){
              goods({
                name:this.goods[index + 1 == this.goods.length ? index : index + 1].name ?? "披萨0" as string,
                price:this.goods[index + 1 == this.goods.length ? index : index + 1].price ?? 100 as number,
                url:this.goods[index + 1 == this.goods.length ? index : index + 1].url ?? "image/selected_01.jpg" as string,
                ids:this.goods[index + 1 == this.goods.length ? index : index + 1].ids ?? 0 as number
              }).margin({right:5}).onClick(e=>{
                router.pushUrl({
                  url:'pages/detail',
                  params:{
                    ids:this.goods[index + 1 == this.goods.length ? index : index + 1].ids ?? 0 as number,
                    name:this.goods[index + 1 == this.goods.length ? index : index + 1].name ?? "披萨0" as string,
                    price:this.goods[index + 1 == this.goods.length ? index : index + 1].price ?? 100 as number,
                    url:this.goods[index + 1 == this.goods.length ? index : index + 1].url ?? "image/selected_01.jpg" as string,
                  }
                })
              })
            }.width("50%")
          }.width("100%").padding(2).margin({top:2})
        }.padding(5)
      })
    }
  }
}