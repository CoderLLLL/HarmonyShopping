@Component

export default struct goods{
  @Prop ids:number
  @Prop name:string
  @Prop price:number
  @Prop url:string

  build(){
    Column(){
      Row(){
        Image(this.url).width("100%").height(200).backgroundImageSize(ImageSize.Cover)
      }
      Row(){
        Text(this.name).fontSize(30)
      }.margin(15)
      Row({space:20}) {
        Column(){
          Text(`￥${this.price}`).fontColor(Color.Red)
        }.alignItems(HorizontalAlign.Start)
        Column(){
          Button("选择规格").width(100).height(25)
        }.alignItems(HorizontalAlign.Start)
      }
    }
    .border({
      radius:5
    })
    .shadow({
      radius:5,
    })
    .width("100%")
    .height(300)
    .margin({
      right:5
    })
  }
}