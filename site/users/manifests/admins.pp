class users::admins{
  $admins = ['admin','administrator','scoday','wheel']

  users::managed_user{  $admins : 
    }

}
