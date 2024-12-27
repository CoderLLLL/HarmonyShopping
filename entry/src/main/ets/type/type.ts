interface goodsData {
  ids:number
  name:string,
  price:number,
  url:string,
  isTrue:Boolean,
  sum:number
}

interface goodsObj {
  ids:number
  name:string,
  price:number,
  url:string,
}

interface goodsThis{
  myThis:Object
  func:Function
}

interface dependencyObj{
  data:goodsData[],
  dependencyList:goodsThis[]
}


//-----------------------------------

interface mStore{
  shoppingCart:dependencyObj,
}

export {
  mStore,
  goodsThis,
  goodsObj,
  dependencyObj,
  goodsData
}