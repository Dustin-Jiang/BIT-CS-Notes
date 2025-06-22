package example6.tables;


public class PrintTable {
    private TableModel model;

    public PrintTable(){
    }
    public PrintTable(TableModel model) {
        this.model = model;
    }

    public void setModel(TableModel model) {
        this.model = model;
    }

    public void printTable(){
        for(int i=0; i<model.getColNumber(); i++){	//输出表头，用model调用接口中的方法
            System.out.print(model.getColName(i)+"\t");
        }
        System.out.println();
        System.out.println("---------------------------");

        //输出表格内容
        for(int i=0; i<model.getRowNumber(); i++){  //所有行，用model调用接口中的方法
            for(int j=0; j<model.getColNumber(); j++){	//所有列，用model调用接口中的方法
                System.out.print(model.getValue(i, j)+"\t");	//打印输出i行j列的数据，用model调用接口中的方法
            }
            System.out.println();
        }
    }
}

