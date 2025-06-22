package example11.ex5;

public class MyRunnable implements Runnable{
    private int i=0;  //i作为属性

    public void run(){
        while(i<5){
            i++;
            for (int j = 0; j < 20000000; j++);
     //       System.out.println(Thread.currentThread().getName() + "=======");
            System.out.print(Thread.currentThread().getName()+" ");
            System.out.println("i="+i);
      //      System.out.println("end  =======");
        }
    }
}