import main from './main'
import  classification from './classification'
import shoppingcart from '../components/shoppingcart'
import user from '../pages/user'

import {goodsObj} from '../type/type'


@Entry
@Component

struct Index {
  @State list:Array<any> = []
  @State keyword:string = ""
  @State page:number = 1
  @State pageSize:number = 20

  @State goods:goodsObj[] = [
    {
      ids:0,
      name:"披萨0",
      price:100,
      url:"image/selected_01.jpg",
    },
    {
      ids:1,
      name:"披萨2",
      price:100,
      url:"image/selected_02.jpg"
    },
    {
      ids:2,
      name:"披萨3",
      price:100,
      url:"image/selected_03.jpg"
    },
    {
      ids:3,
      name:"披萨5",
      price:100,
      url:"image/selected_01.jpg"
    },
    {
      ids:4,
      name:"披萨6",
      price:100,
      url:"image/selected_02.jpg"
    },
    {
      ids:5,
      name:"披萨7",
      price:100,
      url:"image/selected_03.jpg"
    },
    {
      ids:6,
      name:"披萨8",
      price:100,
      url:"image/selected_01.jpg"
    },
    {
      ids:7,
      name:"披萨9",
      price:100,
      url:"image/selected_02.jpg"
    },
    {
      ids:8,
      name:"披萨10",
      price:100,
      url:"image/selected_03.jpg"
    },
    {
      ids:9,
      name:"披萨11",
      price:100,
      url:"image/selected_01.jpg"
    },
  ]
  @Provide shoppingCart:goodsObj[] = [];

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        main({goods:$goods})
      }
      .tabBar('首页')

      TabContent() {
        classification({goods:$goods})
      }.align(Alignment.Top)
      .tabBar('分类')

      TabContent() {
        shoppingcart()
      }.align(Alignment.TopStart)
      .tabBar('购物车')

      TabContent() {
        user()
      }
      .tabBar("我的")
      .align(Alignment.TopStart)
    }.barMode(BarMode.Fixed)
  }
}