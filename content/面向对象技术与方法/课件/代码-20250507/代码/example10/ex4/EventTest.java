package example10.ex4;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

//ActionListener为事件监听器
public class EventTest implements ActionListener{
    private Frame frame;
    private Button  button;
    private TextArea area;

    public EventTest(){
        frame = new Frame("事件测试");
        button = new Button("单击我");
        area  = new TextArea(10,20);
    }
    private void init(){
        frame.add(button, BorderLayout.NORTH);
        frame.add(area, BorderLayout.CENTER);
    }
    public void showMe(){
        init();

        //为事件源注册事件监听器
        button.addActionListener(this);

        frame.setBounds(50,50,400,160);
        frame.setVisible(true);
    }

    //本类做监听,实现事件处理器
    public void actionPerformed(ActionEvent e) {//ActionEvent为事件对象
        area.append("按钮被点击"+"\n" );
    }

    public static void main(String[] args){
        new EventTest().showMe();
    }
}

