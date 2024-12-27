import relationalStore from '@ohos.data.relationalStore'; // 导入模块
import {EntryAbility} from './myDB'

import {UserValueBucket} from '../type/sqlType'

export default class SQLStore {
  private instance:EntryAbility
  private windowThis:Object
  private mStore:relationalStore.RdbStore

  constructor(windowThis) {
    this.instance = new EntryAbility()
    this.windowThis = windowThis

  }
  public async init(){
    this.mStore = await this.instance.onWindowStageCreate(this.windowThis)
    await this.SQLInsert({ID:1,USERNAME:'lll',PASSWORD:'111'}) //添加默认账号
    // console.log(`init---${this.store.insert}`)
  }

  public async SQLInsert(data:UserValueBucket){
    const valueBucket = {
      USERNAME:data.USERNAME,
      PASSWORD:data.PASSWORD
    }

    if(typeof this.mStore != 'boolean' || 'undefined'){
      this.mStore.insert('USERLISTS',valueBucket,(err,rowId)=>{
        if (err) {
          console.error(`Failed to insert data. Code:${err.code}, message:${err.message}`);
          console.log("插入失败")
          return;
        }
        console.info(`Succeeded in inserting data. rowId:${rowId}`);
        console.log(`插入成功. rowId:${rowId}`)
      })
    } else{
      console.log("实例化失败！")
    }
  }

  public SQLQuery(username:string,myThis:Object,fn?:Function):Promise<UserValueBucket[]>{
    return new Promise((resolve,reject)=>{
      if(typeof this.mStore != 'boolean' || 'undefined'){
        let predicates = new relationalStore.RdbPredicates('USERLISTS');
        predicates.equalTo('USERNAME', username);
         this.mStore.query(predicates, ['ID', 'USERNAME', 'PASSWORD'], (err, resultSet) => {
          resultSet.goToFirstRow();
          if (err) {
            return;
            console.error(`Failed to query data. Code:${err.code}, message:${err.message}`);
            reject(err.message)
          }
          console.info(`ResultSet column names: ${resultSet.columnNames}`);
          console.info(`ResultSet row count: ${resultSet.rowCount}`);
          console.log(`结果集：${resultSet.getColumnIndex("USERNAME")}`)
          // const resData:UserValueBucket[] = []
           resultSet.goToFirstRow()
          if (resultSet.rowCount > 0) {
            console.log(`aaaddd:${resultSet.isEnded}`)
            let resData: any[] = []; // 初始化一个数组来存储结果
            while (!resultSet.isEnded) { // 遍历结果集中的每一行
              resData.push({ // 为每一行创建一个对象
                ID: resultSet.getLong(resultSet.getColumnIndex("ID")), // 假设ID是长整数
                USERNAME: resultSet.getString(resultSet.getColumnIndex("USERNAME")), // 获取用户名
                PASSWORD: resultSet.getString(resultSet.getColumnIndex("PASSWORD")) // 获取密码
              });
              resultSet.goToNextRow()
            }
            console.log(`数组长度:${resData.length}`)
            fn(resData,myThis)
            resolve(resData)
          } else{
            fn([],myThis)
          }

          resultSet.close()
        })
      }
    })
  }
}
