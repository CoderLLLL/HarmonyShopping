//导入路由模块
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import SQLStore from '../database/index'

@Entry
@Component
struct Register {
  @State message: string = '注册';
  @State username: string = ''
  @State password: string = ''
  @State repassword: string = ''

  @State sqlStore:SQLStore = new SQLStore(this);

  MyToast(text:string){
    promptAction.showToast({
      message: text,
      duration: 3000 //3秒
    })
  }

  MyLog(res,myThis:Register){
     if(res.length > 0){
       myThis.MyToast('账号已经存在')
     } else{
       myThis.sqlStore.SQLInsert({ID:1,USERNAME:myThis.username,PASSWORD:myThis.password})
       myThis.MyToast("注册成功")
       router.pushUrl({
         url:'pages/Login'
       })
     }
  }


  async RegisterFn(){
    console.log("按钮点击")
    await this.sqlStore.SQLQuery(this.username,this,this.MyLog)
  }

  async aboutToAppear(){
    await this.sqlStore.init()
  }

  build() {
    Row() {
      Column() {
        Image($r("app.media.icon"))
          .width('80vp')
          .height('80vp')
          .margin({bottom:'28vp'})
        Text(this.message)
          .fontSize('30vp')
          .fontWeight(FontWeight.Bold)
        TextInput({placeholder:'请输入用户名'})
          .inputStyle()
          .onChange(value=>{//输入值变化时，触发回调
            this.username = value
            // console.log(''+this.username)
          })

        TextInput({placeholder:'请输入密码'})
          .inputStyle()
          .onChange(value=>{//输入值变化时，触发回调
            this.password = value ;
          })
        TextInput({placeholder:'请输入再次密码'})
          .inputStyle()
          .onChange(value=>{//输入值变化时，触发回调
            this.repassword = value ;
          })


        // 注册
        Row(){
          Button('注册')
            .width('85%')
            .onClick(()=>{
              // 判断
              if (this.username=='' || this.password==''){
                // console.info('1')
                promptAction.showToast({
                  message:'用户名或密码不能为空',
                  duration:3000//3秒

                })
                return
              }
              if (this.password!=this.repassword){
                promptAction.showToast({
                  message:'确认密码和密码不一致',
                  duration:3000//3秒
                })
                return
              }
              else{
                this.RegisterFn()
              }

            })
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}
//添加公共装饰器
@Extend(TextInput) function inputStyle(){
  .placeholderColor(0x999999)
  .maxLength(6)//最大输入长度
  .padding('12vp')
  .margin('10vp')
}