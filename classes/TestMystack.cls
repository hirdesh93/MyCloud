@istest
private class TestMystack {
    static testmethod void show(){
		Mystack ms = new Mystack();
        sObject item;
       	ms.pop();
      	ms.push(item);
        ms.peek();
        ms.isEmpty();
        ms.size();
    }
}