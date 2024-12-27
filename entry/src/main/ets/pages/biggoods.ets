import router from '@ohos.router'


@Component
export default struct biggoods{
  @Prop ids:number
  @Prop name:string
  @Prop price:number
  @Prop url:string

  build(){
    Grid(){
      GridItem(){
        Image(this.url).width(80).height(80)
      }
      GridItem(){
        Column(){
          Row(){
            Text(this.name).fontSize(25)
            Text(`￥${this.price}`).fontSize(10).fontColor(Color.Red)
          }
          Row(){

            Button("查看详情").onClick((event: ClickEvent) => {
             router.pushUrl({
               url:'pages/detail',
               params:{
                 ids:this.ids,
                 name:this.name,
                 price:this.price,
                 url:this.url,
               }
             })
            }).height(25)
          }
        }
      }
    }.rowsTemplate('1fr')
    .columnsTemplate('1fr 2fr')
  }
}