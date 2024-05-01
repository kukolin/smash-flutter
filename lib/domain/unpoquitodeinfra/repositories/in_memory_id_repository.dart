class InMemoryIdRepository {
  String myId = "";

  void saveMyId(String myId){
    this.myId = myId;
  }

  String getMyId(){
    return myId;
  }
}