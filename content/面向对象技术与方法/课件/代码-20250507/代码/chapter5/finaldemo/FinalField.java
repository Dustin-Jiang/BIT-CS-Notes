package chapter5.finaldemo;

public class FinalField {
    final String defineInitStr = "在定义时赋初值";
    final static String staticInitStr;
    final String initStr;
    final String constructorInitStr;

    static{
        staticInitStr="在静态代码块中赋初值!";
    }

    {
        initStr="在构造代码块中赋初值!";
    }

    public FinalField(String constructorInitStr) {
        this.constructorInitStr = constructorInitStr;   	//在构造方法中赋初值
    }

    public void changeFinalField(){
//      defineInitStr="a";	//编译错
//		staticInitStr="b";	//编译错
//		initStr="c";	//编译错
//		constructorInitStr="d";	//编译错
    }

    public static void main(String[] args) {
        FinalField ff = new FinalField("在构造方法中赋初值");
    }
}
