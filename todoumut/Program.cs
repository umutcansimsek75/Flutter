List<todo> todolist=new List<todo>();
 string select,title,Durum;
 int id;
 while (true)
 {
    Console.WriteLine("İşlem Seçiniz\n[0] Çıkış\n[1] Listele \n[2] Ekle \n[3] Düzenle \n[4] Sil");
    select=Console.ReadLine()!;
    switch (select) 
    {
        case "0":
        Console.WriteLine("Güle Güle...");
        Environment.Exit(0);
        break;
        
        case"1":
        Listele();
        continue;

        case "2":
        ekle();
        continue;

        case "4":
        Sil();
        continue;
        
        case "3":
        Düzenle();
        continue;


        default:
        Console.WriteLine("Lütfen 0-4 Arasında Bir Değer Giriniz");
        continue;
    }
 }
 void Listele()
{
if (todolist.Count>0)
{
    Console.WriteLine("Id\tBaşlık\t\tDurum");
    foreach (var todo in todolist)
    {
      Console.WriteLine("{0}\t{1}\t\t{2}",todo.id,todo.title,todo.isComplated);  
    }
}
else
{
    Console.WriteLine("Kayıt Bulunamadı");
}
}
void ekle()
{
Console.WriteLine("Başlık :");
 title=Console.ReadLine()!;
 if (todolist.Count()>0)
 {
    id= todolist.Last().id+1;
 }
else
{
    id=1;
}
    todo todo =new todo(id , title,false);
    todolist.Add(todo);
    Console.WriteLine("Kayıt Eklendi");
}
  void Sil ()
{
    Listele();
    Console.Write("Silmek İstediğiniz İd : ");
    id=int .Parse(Console.ReadLine()!);
    todo todo =todolist.Find(x=> x.id ==id)!;
    
    if (todo!=null)
    {
       todolist.Remove(todo);
       Console.WriteLine("Kayıt Silindi"); 
    }
else
{
    Console.WriteLine("Girmiş Olduğunuz İd Ye Sahip Kayıt Bulunamadı");
    Sil();
}

}
 void Düzenle ()
{
    Listele();
    Console.Write("Düzenlemek İstediğiniz İd :");
    id=int .Parse(Console.ReadLine()!);
    todo todo =todolist.Find(x=> x.id ==id)!;
    
    if (todo!=null)
    {
       Console.WriteLine("Yeni Başlık");
       title=Console.ReadLine()!;

       Console.WriteLine("Görev Tamamlandımı {E/H}");
       Durum=Console.ReadLine()!.ToUpper();
       if (Durum=="E")
       {
        todo.isComplated=true;
       }
       else
       {
        todo.isComplated=false;
       }
       todo.title=title;
       Console.WriteLine("Kayıt Güncellendi");
    }
else
{
    Console.WriteLine("Girmiş Olduğunuz İd Ye Sahip Kayıt Bulunamadı");
    Sil();
}

}