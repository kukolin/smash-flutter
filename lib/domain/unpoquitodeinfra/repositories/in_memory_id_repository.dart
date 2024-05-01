class InMemoryUserRepository {
  String _myId = "";
  String _myName = "";

  void saveMyId(String myId){
    _myId = myId;
  }

  String getMyId(){
    return _myId;
  }

  void saveMyName(String myName){
    _myName = myName;
  }

  String getMyName(){
    return _myName;
  }
}