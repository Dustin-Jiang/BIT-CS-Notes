package example10.ex3;
import java.awt.*;

public class AWTCalculation {
    //将窗口中需要控制的组件定义为属性
    private Frame frame;
    private TextField field;
    private Button[] allButtons;

    //在构造方法中创建组件
    public AWTCalculation(){
        frame = new Frame("计算器");

        field = new TextField(20);
        field.setText("0");

        allButtons = new Button[20];
        String str="←C√±789/456*123-0.=+";
        for(int i=0; i<str.length(); i++){
            allButtons[i]=new Button(str.substring(i,i+1));
        }
    }

    //初始化窗口，设置布局
    private void init(){
        Panel northPanel = new Panel();
        northPanel.add(field);

        Panel centerPanel = new Panel();
        GridLayout grid = new GridLayout(5,4,2,2);
        centerPanel.setLayout(grid);

        for(int i=0; i<allButtons.length; i++){
            centerPanel.add(allButtons[i]);
        }

        frame.add(northPanel,BorderLayout.NORTH);
        frame.add(centerPanel,BorderLayout.CENTER);
    }

    public void showMe(){
        init();
        frame.setLocation(300,200);
        frame.setSize(270, 300);
        frame.setResizable(false);	//禁止改变窗口的大小
        frame.setVisible(true);
    }

    public static void main(String[] args){
        new AWTCalculation().showMe();
    }
}
