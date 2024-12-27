import router from '@ohos.router'
import myStore from '../store/mystore'

@Entry
@Component
export default struct detail{

  build(){
    Column(){
      Row(){
        Column(){
          Button("<").onClick((event: ClickEvent) => {
            router.back()
          }).backgroundColor(Color.White).fontColor(Color.Black)
        }
        Column(){
          Text("详情")
        }
      }.padding(10).width("100%")
      Divider()
      Row(){
        Image(`${router.getParams()['url']}`)
          .width("100%")
          .height(400)
          // .objectFit(ImageFit.Contain)
          .backgroundImageSize(ImageSize.Cover)
      }
      Row(){
        Text(`￥  ${router.getParams()['price'] ?? 100}`).margin(30).fontSize(30).fontColor(Color.White)
      }.width("100%").backgroundColor(Color.Blue)
      Column(){
        Text(router.getParams()['name'] ?? "康师傅红烧牛肉面140g x 5包")
          .width("100%")
          .fontSize(20)
          .textAlign(TextAlign.Start)

        Text("支持货到付款，限时必到，正版实惠!")
          .padding({top:5})
          .fontSize(12)
          .width("100%")
          .textAlign(TextAlign.Start)
          .fontColor(Color.Red)
      }.width("100%").padding(25)
      Divider()
      Row(){
        Grid(){
          GridItem(){Text("选择").fontColor(Color.Gray)}
          GridItem(){Text("请选择商品规格").width("100%").textAlign(TextAlign.Start)}
          GridItem(){Text(">")}
        }.columnsTemplate("1fr 3fr 1fr").padding({top:20}).height(50)
      }
      Divider()
      Row(){
        Grid(){
          GridItem(){Text("送至").fontColor(Color.Gray)}
          GridItem(){Text("请选择收货地址").width("100%").textAlign(TextAlign.Start)}
          GridItem(){Text(">")}
        }.columnsTemplate("1fr 3fr 1fr").padding({top:20}).height(50)
      }
      Row(){
        Grid(){
          GridItem(){Text("服务").fontColor(Color.Gray)}
          GridItem(){Text("准时宝 不外漏 餐品完整").width("100%").textAlign(TextAlign.Start)}
        }.columnsTemplate("1fr 3fr 1fr").padding({top:20}).height(50)
      }
      Divider()
      Stack({alignContent : Alignment.Bottom}){
        Row(){
          Grid(){
            GridItem(){Text("收藏")}
            GridItem(){Text("客服")}
            GridItem(){Text("购物车")}
            GridItem(){
              Button("加入购物车").onClick(e=>{
                myStore.pushCart({
                  ids:router.getParams()['ids'],
                  name:router.getParams()['name'],
                  price:router.getParams()['price'],
                  url:router.getParams()['url']
                })
              })
            }
            GridItem(){
              Button("立即购买")
            }
          }.columnsTemplate("1fr 1fr 1fr 2fr 2fr").padding({top:5}).height(50)
        }.border({width:1,style:BorderStyle.Solid,color:Color.Black}).backgroundColor(Color.White)

      }
      .width("100%")
      .height("7%")
      .position({x:0,y:"93%"})
    }

  }
}