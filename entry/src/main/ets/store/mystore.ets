import {goodsObj,goodsThis,mStore,goodsData} from '../type/type'
import promptAction from '@ohos.promptAction'
import NotificationManager from '@ohos.notificationManager';

let notificationRequest = {
  id: 1,
  content: {
    contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
    normal: {
      title: "通知",
      text: '产品已下单',
      additionalText: '您的餐品正在备餐中...',
    }
  }
}

class myStore {
  private store:mStore

  constructor() {
    this.store = {
      shoppingCart:{
        data:[],
        dependencyList:[]
      }
    }
  }

  _refresh(dependencyList:goodsThis[]){
    for(const funcItem of dependencyList){
      funcItem.func(funcItem.myThis,this.store.shoppingCart.data)
    }
  }

  getShoppingCart(myThis:Object,func:Function){
    func(myThis,this.store.shoppingCart.data)
    this.store.shoppingCart.dependencyList.push({func:func,myThis:myThis})
  }

  pushCart(item:goodsObj){
    let flag = false
    let thisItem :goodsData;
    for (const element of this.store.shoppingCart.data) {
      if(element.ids == item.ids) {
        flag = true;
        thisItem = element
        break
      }
    }

    !flag ? this.store.shoppingCart.data.push({
      ids:item.ids,
      name:item.name,
      price:item.price,
      url:item.url,
      isTrue:true,
      sum:1
    } as goodsData) : thisItem.sum++
    promptAction.showToast({
      message: '已加入购物车',
    })
    this._refresh(this.store.shoppingCart.dependencyList)
  }

  changeIsTrue(isOn:boolean){
    for(const item of this.store.shoppingCart.data){
      item.isTrue = isOn
    }
    this._refresh(this.store.shoppingCart.dependencyList)
  }

  changeCartItem(item:goodsData){
    for (let element of this.store.shoppingCart.data) {
      if(element.ids == item.ids) {
        element.sum = item.sum
        element.isTrue = item.isTrue
        return this._refresh(this.store.shoppingCart.dependencyList)
      }
    }
  }

  changeItemSum(item:goodsData,option:string){
    for (const element of this.store.shoppingCart.data) {
      if(element.ids == item.ids){
        switch (option){
          case '-':
            if(element.sum > 1){
              element.sum--
            } else{
              promptAction.showToast({
                message: "数量最少为1",
                duration: 3000 //3秒
              })
            }
            break
          case '+':
            if(element.sum <   99){
              element.sum++
            } else{
              promptAction.showToast({
                message: "数量最多为99",
                duration: 3000 //3秒
              })
            }
            break
        }
      }
    }

    this._refresh(this.store.shoppingCart.dependencyList)
  }

  deleteCartItem(){
    const newData:goodsData[] = []
    let sum = 0
    for (const element of this.store.shoppingCart.data) {
      element.isTrue ? sum++ : newData.push(element)
      console.log(`true%%${element.isTrue}`)
    }
    if(sum == 0) {
      promptAction.showToast({
        message: '没有选中任何东西',
      })
      return false
    }
    this.store.shoppingCart.data = newData
    console.log(`购物车的长度为:${this.store.shoppingCart.data.length}`)
    this._refresh(this.store.shoppingCart.dependencyList)
    promptAction.showToast({
      message: '已结算',
    })
    NotificationManager.publish(notificationRequest, (err) => {
      if (err) {
        console.error(`[ANS] failed to publish, error[${err}]`);
        return;
      }
      console.info(`[ANS] publish success`);
    });

    return true
  }

  deleteItemById(id:number){
    for (let index = 0; index < this.store.shoppingCart.data.length; index++) {
      if(this.store.shoppingCart.data[index].ids == id){
        this.store.shoppingCart.data.splice(index,1)
        this._refresh(this.store.shoppingCart.dependencyList)
        return true
      }
    }
    return false
  }
}

export default new myStore()