import Constants from '../constants/Constants'
@Component
export struct ClItem {
  private content:string
  private font_color:ResourceColor
  private background_color:ResourceColor
  private font_size:ResourceStr
  private border_radio : BorderRadiuses
  build(){
    Text(this.content)
      .fontColor(this.font_color)
      .fontSize(this.font_size)
      .backgroundColor(this.background_color)
      .width(Constants.WIDTH_100)
      .height(Constants.WIDTH_100)
      .textAlign(TextAlign.Center)
      .borderRadius(this.border_radio)
  }
}