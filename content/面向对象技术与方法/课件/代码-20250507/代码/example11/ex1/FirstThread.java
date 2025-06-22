package example11.ex1;

public class FirstThread extends Thread{
    //重写run方法
    public void run(){
        for(int i=0; i<5; i++){
            System.out.println(this.getName()+" :  "+(char)(i+'A'));
            for(int j=0; j<400000000; j++);
        }
    }
}
