package example6.tables;

public interface TableModel {
    public int getRowNumber();	//获取表格的行数
    public int getColNumber();	//获取表格的列数
    public String getColName(int index);	//获取表头名称
    public Object getValue(int row,int col);	//获取 row行col列的数据
}
