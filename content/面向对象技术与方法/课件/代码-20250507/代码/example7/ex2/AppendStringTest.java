package example7.ex2;

public class AppendStringTest {

    public static void main(String[] args) {

        //String对象的拼接
        String text="";
        long beginTime=System.currentTimeMillis();  //起始时间
        for(int i=0; i<20000; i++){ //循环100000次拼接字符串
            text=text+i;
        }
        long endTime=System.currentTimeMillis();	//终止时间
        System.out.println("String的执行时间："+(endTime-beginTime));

        //StringBulider对象的拼接
        StringBuilder builder = new StringBuilder("");
        beginTime=System.currentTimeMillis();
        for(int i=0; i<20000; i++){ //用StringBuffer类的append()方法拼接字符串
            builder.append(i);
        }
        endTime=System.currentTimeMillis();
        System.out.println("StringBuilder的执行时间："+(endTime-beginTime));
    }
}
