package example11.ex2;

public class SecondThread implements Runnable{
    private int i=0;  //i作为属性
    //重写run方法
    public void run(){
        for(; i<5; i++){
            //利用静态方法currentThread()获取线程对象
            System.out.println(Thread.currentThread().getName()
                    +" :  "+(char)(i+'A'));
            try {
                Thread.sleep(500);	//休眠500毫秒
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
