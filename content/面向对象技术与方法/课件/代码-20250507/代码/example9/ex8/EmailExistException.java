package example9.ex8;

public class EmailExistException extends Exception{
    public EmailExistException(){

    }
    public EmailExistException(String msg){
        super(msg);
    }
}
