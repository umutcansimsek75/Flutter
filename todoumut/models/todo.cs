internal class todo
{
    public int id {get;set;}
    public string title {get;set;}
    public bool isComplated {get;set;}

   public todo(int id,string title,bool isComplated){
    this.id=id;
    this.title=title;
    this.isComplated= isComplated;
    }
}