package example6.ex0;

public class Test {

    public static void main(String[] args) {
        Animal a1 = new Animal();
        a1.move();

        Animal a2 = new Bird();	//子类对象送给父类引用
        a2.move();

        Animal a3= new Fish();
        a3.move();

        if(a2 instanceof Bird){
            ((Bird)a2).singing();   //强转后可以调用a2运行时类型的方法了
        }

    }
}