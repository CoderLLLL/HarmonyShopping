import relationalStore from '@ohos.data.relationalStore'; // 导入模块
import UIAbility from '@ohos.app.ability.UIAbility';

class EntryAbility extends UIAbility {
  public RStore:relationalStore.RdbStore | boolean
  onWindowStageCreate(windowStage):Promise<relationalStore.RdbStore> {
    return new Promise((resolve,reject)=>{
      const STORE_CONFIG = {
        name: 'myUser.db', // 数据库文件名
        securityLevel: relationalStore.SecurityLevel.S1 // 数据库安全级别
      };

      const SQL_CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS USERLISTS (' +
      'ID INTEGER PRIMARY KEY AUTOINCREMENT, ' +
      'USERNAME TEXT NOT NULL, ' +
      'PASSWORD TEXT NOT NULL' +
      ')'; // 建表Sql语句

      relationalStore.getRdbStore(getContext(this), STORE_CONFIG, (err, store)=>{
        console.log("await")
        if (err) {
          console.error(`Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
          this.RStore = false
          reject(false)
          return ;
        }
        console.info(`Succeeded in getting RdbStore.`);
        console.log('Succeeded in getting RdbStore.')
        store.executeSql(SQL_CREATE_TABLE); // 创建数据
        // 这里执行数据库的增、删、改、查等操作
        this.RStore = store
        resolve(store)
      })
    })
  }
}

export {
  EntryAbility
}