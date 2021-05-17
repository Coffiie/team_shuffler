class Validator{
  bool validateName(String name) {
    if(name == null)
    {
      return false;
    }
    if(name.isEmpty)
    {
      return false;
    }
   
   return true;
  }

  bool validateRating(int rating) {
    if(rating == null)
    {
      return false;
    }
    if(rating < 1 || rating > 3)
    {
      return false;
    }
    return true;
  }

}