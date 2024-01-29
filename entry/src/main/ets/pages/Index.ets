import Constants from '../constants/Constants'
import Utils from '../constants/Utlis'
import { ClItem } from '../view/ClItem'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  // @State Number: String[] = ['0', '1', '2']
  @State Number: String[] = ['c', '÷', '×','7','8','9','4','5','6','1','2','3','%','0','.']
  @State Number2: String[] = ['del', '+', '-','=']

  @State isEnd:boolean = false

  @State calArr: Array<string> = []
  @State calString: string = ''
  @State  num:string = '0'
  @State numArr : Array<string> = []

  numClick(num:string){
    if(this.isEnd){
      this.clearClick()
      this.isEnd = false
    }
    if(this.numArr.length == 1 && this.numArr[0] == "0" && num == "0"){
      return;
    }
    if( num == "." && this.numArr.indexOf('.') > -1){
      return;
    }
    this.numArr.push(num.toString())
    this.montageNumArr()
  }

  equalClick(){
    if(!this.isEnd){
      this.calString = this.calString + " " + this.num
    }

    let arr1 = this.calString.split(" ")
    while (arr1.indexOf('×')>-1 || arr1.indexOf('÷')>-1|| arr1.indexOf('%')>-1){
      for (let i = 0; i < arr1.length; i++) {
        let value = arr1[i].toString();
        if(value === '×' || value === '÷'  || value ==='%'){
          Utils.calculatorNumber(value,arr1,i)
        }
      }
    }
    while (arr1.indexOf("+") > -1 || arr1.indexOf('-') > -1){
      console.log("parseFloat(i3):",arr1);
      for(let i = 0;i<arr1.length;i++){
        let value = arr1[i].toString();
        if(value === '+' || value === '-'){
          Utils.calculatorNumber(value,arr1,i)
        }

      }
    }
    console.log("data",this.num.length)
    if (arr1.length>0) {
      let arrCon
      arr1.forEach(value=>{
        if (arrCon!=undefined) {
          arrCon = arrCon+value
        }else{
          arrCon = value
        }
      })
      this.num = arrCon
      console.log("data",this.num)
    }else{
      this.num = '0'
    }
    this.isEnd = true
  }

  calClick(cType){

    if(this.numArr.length == 0){
      this.numArr.push(this.num.toString())
      this.montageNumArr()
    }

    if(this.calString == ''){
      this.calString = this.num + " " + cType
    }else {
      this.calString = this.calString + " " + this.num + " " + cType

    }

    this.numArr = []
    this.montageNumArr()

  }

  clearClick(){
    this.numArr = []
    this.calString = ""
    this.calArr = []
    this.num = '0'
  }
  deleteClick(){
    if(this.numArr.length > 0){
      this.numArr.splice(this.numArr.length - 1,1)
    }
    this.montageNumArr()
  }
  montageNumArr(){
    if (this.numArr.length>0) {
      let tempString = ""
      this.numArr.forEach(element => {
        tempString = tempString + element
      });
      this.num = tempString
    }else {
      this.num = '0'
    }

  }
  build() {
    Flex({direction:FlexDirection.Column}){
      Flex({direction:FlexDirection.Column,justifyContent:FlexAlign.End}){
        Text(this.calString)
          .fontSize($r('app.float.textSize20'))
          .width(Constants.WIDTH_100)
          .textAlign(TextAlign.End)
          .padding({right:Constants.PADDING_20})
          .margin({bottom:Constants.MARGIN_15})
        Text(this.num.toString())
          .fontSize($r('app.float.textSize50'))
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .width(Constants.WIDTH_100)
          .textAlign(TextAlign.End)
          .padding({right:Constants.PADDING_20})
          .margin({bottom:Constants.MARGIN_30})
      }.width(Constants.WIDTH_100)
      .height(Constants.WIDTH_40)

      Flex({direction:FlexDirection.Row}){
        Grid(){
          ForEach(this.Number,(data:string,index:number)=>{
            GridItem(){
              if (index == 0) {
                ClItem({content:data,
                  font_size:Constants.TEXT_SIZE_60,
                  font_color:$r('app.color.white'),
                  border_radio:{topLeft:Constants.RADIO_30},
                  background_color:$r('app.color.363746')})
                  .onClick(()=>{
                    this.clearClick()
                  })
              }else if (index ==1 || index==2){
                ClItem({content:data,
                  font_size:Constants.TEXT_SIZE_60,
                  font_color:$r('app.color.FFBB00'),
                  border_radio:{},
                  background_color:$r('app.color.363746')})
                  .onClick(()=>{
                    this.calClick(data)
                  })
              }else{
                if(data == '%'){
                  ClItem({content:data,
                    font_size:Constants.TEXT_SIZE_20,
                    font_color:$r('app.color.white'),
                    border_radio:{},
                    background_color:$r('app.color.2E2F3E')})
                    .onClick(()=>{
                      this.calClick(data)
                    })
                }else if (data == "."){
                  ClItem({content:data,font_size:Constants.TEXT_SIZE_20,font_color:$r('app.color.white'),
                    background_color:$r('app.color.2E2F3E'),border_radio:{}})
                    .onClick(()=>{
                      this.numClick(data)
                    })
                }else{
                  ClItem({content:data,font_size:Constants.TEXT_SIZE_20,font_color:$r('app.color.white'),
                    background_color:$r('app.color.2E2F3E'),border_radio:{}})
                    .onClick(()=>{
                      this.numClick(data)
                    })
                }
              }
            }
          },data=>data)
        }.columnsTemplate('1fr 1fr 1fr')
        .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
        .columnsGap(1)
        .width(Constants.WIDTH_75)
        .backgroundColor(0x242530)
        .height(Constants.WIDTH_100)

        Grid(){
          ForEach(this.Number2, (data: string,index:number) => {
            GridItem() {
              if (index == 0) {
                ClItem({
                  content:data,
                  font_size:Constants.TEXT_SIZE_20,
                  font_color:$r('app.color.white'),
                  background_color:$r('app.color.FFBB00'),border_radio:{topRight:Constants.RADIO_30}})
                  .onClick(()=>{
                    this.deleteClick()
                  })
              }else if (index==3){
                ClItem({
                  content:data,
                  font_size:Constants.TEXT_SIZE_60,
                  font_color:$r('app.color.white'),
                  background_color:$r('app.color.FFBB00'),
                  border_radio:{}})
                  .onClick(()=>{
                    this.equalClick()
                  })
              }else{
                ClItem({
                  content:data,
                  font_size:Constants.TEXT_SIZE_60,
                  font_color:$r('app.color.FFBB00'),
                  background_color:$r('app.color.363746'),
                  border_radio:{}})
                  .onClick(()=>{
                    this.calClick(data)
                  })
              }
            }
          },data=>data)
        }.columnsTemplate('1fr')
        .rowsTemplate('1fr 1fr 1fr 2fr')
        .columnsGap(1)
        .rowsGap(1)
        .width(Constants.WIDTH_23)
        .backgroundColor(0x242530)
        .height(Constants.WIDTH_100)
        .padding({left:1})
      }
    }.width(Constants.WIDTH_100)
    .height(Constants.WIDTH_100)
    .backgroundColor(0x242530)
  }

}