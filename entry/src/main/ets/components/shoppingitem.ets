import myStore from '../store/mystore'

@Component
export default struct shoppingitem{
  @Prop ids:number
  @Prop name:string
  @Prop price:number
  @Prop url:string
  @Prop isTrue:boolean
  @Prop sum:number

  build(){
    Flex({ direction: FlexDirection.RowReverse }){
      Button("x").onClick((event: ClickEvent) => {
        myStore.deleteItemById(this.ids)
      }).width(40).height(30).fontSize(20).padding(0).margin({top:30,left:5}).backgroundColor(Color.Red)
      Button("+").onClick((event: ClickEvent) =>{
        myStore.changeItemSum({
          ids:this.ids,
          name:this.name,
          price:this.price,
          url:this.url,
          isTrue:this.isTrue,
          sum:this.sum
        },"+")
      }).width(40).height(30).fontSize(20).padding(0).margin({top:30})
      Text(`${this.sum}`).width(40).margin({top:35}).align(Alignment.Center)
      Button("-").onClick((event: ClickEvent) => {
        myStore.changeItemSum({
          ids:this.ids,
          name:this.name,
          price:this.price,
          url:this.url,
          isTrue:this.isTrue,
          sum:this.sum
        },"-")
      }).width(40).height(30).fontSize(20).padding(0).margin({top:30})
      // Text(`数量${this.sum}`).width('20%').height(100)
      Text(this.name).width('45%').height(100)
      Text(`￥${this.price}`).width('25%').height(100).fontColor(Color.Red)
      Image(this.url).height(100)
      Column(){
        Toggle({ type: ToggleType.Checkbox, isOn: this.isTrue })
          .onChange(isOn=>{
            myStore.changeCartItem({
              ids:this.ids,
              name:this.name,
              price:this.price,
              url:this.url,
              isTrue:isOn,
              sum:this.sum
            })
          })
      }
      .width('15%')
      .height(100)
      .padding({top:35})
      .alignItems(HorizontalAlign.Center)

    }.padding(10).margin(10).borderRadius(20)
    .shadow({ radius: 10, color: Color.Gray })
  }
}