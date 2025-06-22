package example9.ex4;

public class ExceptionDemo3 {
    public static void main(String[] args) {
        ExceptionDemo3 me = new ExceptionDemo3();
        try{
            System.out.println("try");
          if(1==1) return;

            System.out.println(1/0);
        }catch(ArithmeticException ae){
            System.out.println("catch...");
        }finally{
            System.out.println("finally...");
        }
    }

}
