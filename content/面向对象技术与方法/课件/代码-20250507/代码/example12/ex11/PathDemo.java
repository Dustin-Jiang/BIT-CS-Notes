package example12.ex11;

import java.nio.file.Path;
import java.nio.file.Paths;

public class PathDemo {

    public static void main(String[] args) {
        Path absolute = Paths.get("/home", "source");  //绝对路径
        Path relative = Paths.get("chap12", "ex13", "PathDemo.java");  //相对路径
        Path current = Paths.get("");   //空路径

        System.out.println(absolute);
        System.out.println(relative);
        System.out.println(current);

        Path newPath = absolute.resolve("java");
        System.out.println(newPath);

        Path newPath2 = absolute.resolve("/java");
        System.out.println(newPath2);

        Path path1 = Paths.get("home/demo.html");
        Path path2 = Paths.get("home/images/logo.png");
        Path relativePath = path1.relativize(path2);
        System.out.println(relativePath);
    }

}
