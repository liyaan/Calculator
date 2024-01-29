export default class Utils {

   static  stringToNumber(value): any{
      return parseFloat(value)
   }

   static  calculatorNumber(value:string,arr:string[],i:number): any{
      let i1 = arr[i - 1]
      let i2 = arr[i + 1]
      let count


      console.log("data",value+"  "+i+"  "+arr.toString())
      switch (value){
         case '×':
            count = parseFloat(i1)*parseFloat(i2)
            break;
         case '÷':
            count = parseFloat(i1)/parseFloat(i2)
            break;
         case '+':
            count = parseFloat(i1)+parseFloat(i2)
            break;
         case '-':
            count = parseFloat(i1)-parseFloat(i2)
            break;
         case '%':
            count = parseFloat(i1)%parseFloat(i2)
            break;
      }
      if (count) {
         arr[i - 1] = count.toString()
         arr.splice(i,2)
      }

   }
}