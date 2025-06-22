package example8.map;

import java.io.*;
import java.util.*;

public class PropertiesDemo {

    public static void main(String[] args) throws FileNotFoundException,IOException{
        Properties pro = new Properties();

        //1.创建一个指向配置文件的输入流
        FileInputStream fis  = new FileInputStream("ipConfig.properties");
        //2.读取配置文件
        pro.load(fis);

        //按属性名字获取属性值
        System.out.println("server ip:"+ pro.getProperty("server"));
        System.out.println("port:"+ pro.getProperty("port"));
    }
}
