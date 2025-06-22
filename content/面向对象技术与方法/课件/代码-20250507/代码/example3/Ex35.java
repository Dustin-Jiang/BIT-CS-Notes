package example3;

public class Ex35 {

    /**
     * @param args
     */
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        System.out.println("1+2="+getSum(1,2));     //2个参数
        System.out.println("1+2+3="+getSum(1,2,3));  ////3个参数
        System.out.println("1+2+3+4+5="+getSum(1,2,3,4,5));  //5个参数

    }
    public static int getSum(int... numbers){ //可变长形参，本质为数组
        int sum=0;
        for(int i=0; i<numbers.length; i++){  //按数组的方式操作
            sum+=numbers[i];
        }
        return sum;
    }



}