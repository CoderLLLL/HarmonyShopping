//导入路由模块
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import SQLStore from '../database/index'

@Entry
@Component
struct Login {
  @State message: string = '欢迎登录'
  @State username:string = "LLLL111"
  @State password:string = ""

  @State sqlStore:SQLStore = new SQLStore(this);

  MyToast(text:string){
    promptAction.showToast({
      message: text,
      duration: 3000 //3秒
    })
  }

  MyLog(res,myThis:Login){
    if(res.length > 0){
      if(myThis.username == res[0].USERNAME) {
        if(myThis.password == res[0].PASSWORD){
          myThis.MyToast('登录成功')
          router.replaceUrl({
            url:'pages/Index',
            params:{
              username:res[0].USERNAME
            }
          })
        } else{
          myThis.MyToast('密码错误')
        }
      }
    }else{
      myThis.MyToast('找不到账号')
    }
  }

  async LoginFn(){
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
            console.log(''+this.username)
          })

        TextInput({placeholder:'请输入密码'})
          .inputStyle()
          .onChange(value=>{//输入值变化时，触发回调
            this.password = value ;
            console.info('password:'+value)
          })
        //登录
        Button('登录',{type:ButtonType.Capsule,stateEffect:true})
          .width('85%')
          .margin('20vp')
          .onClick(()=>{
            if (this.username=='' || this.password==''){
              // console.info('1')
              promptAction.showToast({
                message:'用户名或密码不能为空',
                duration:3000//3秒
              })
              return
            }else {
              this.LoginFn()
            }
          })
        // 注册
        Row(){
          Button('注册')
            .width('85%')
            .onClick(()=>{

              router.pushUrl({
                url:'pages/register'
              })

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
  .maxLength(20)//最大输入长度
  .padding('12vp')
  .margin('10vp')
}