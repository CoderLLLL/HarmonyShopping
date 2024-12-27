@Component

export default struct settlementItem{
  @Prop ids:number
  @Prop name:string
  @Prop price:number
  @Prop url:string
  @Prop isTrue:boolean
  @Prop sum:number

  showPaymentDialog() {

  }

  build(){
    Row(){
      Column(){
        Image(this.url).width(100).height(100).margin({right:10})
      }.width('30%')
      Column(){
        Text(this.name).width('100%').height(50).fontSize(20).fontColor(Color.Black)
      }.width('40%')
      Column(){
        Text(`x${this.sum}`)
      }.width('10%')
      Column(){
        Text(`${this.price * this.sum}￥`).width('100%').height(50).fontSize(20)
      }.width('30%')
      }.width("100%").height("150")
    }
}