package example6.ex3;

public class UserDaoForArray implements UserDao{
    private User[] data;
    private int count=0;

    public UserDaoForArray(){
        data=new User[10];
    }
    public boolean addUser(User user) {
        if(count==data.length){ //用户上限已达到
            return false;
        }

        //查找用户是否已存在
        for(int i=0; i<count; i++){
            if(data[i].getUserName().equals(user.getUserName())){
                return false;
            }
        }

        //添加新用户
        data[count]=user;
        count++;
        return true;
    }


    public User getUser(String userName, String password) {
        for(int i=0;i<count;i++){
            if(data[i].getUserName().equals(userName) && data[i].getPassword().equals(password) ){
                return new User(userName, password);
            }
        }
        return null;
    }
}

